import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'payment_sheet_screen_custom_flow.dart';
import 'example_scaffold.dart';
import 'loading_button.dart';
import 'response_card.dart';

class SetupFuturePaymentScreen extends StatefulWidget {
  @override
  _SetupFuturePaymentScreenState createState() =>
      _SetupFuturePaymentScreenState();
}

class _SetupFuturePaymentScreenState extends State<SetupFuturePaymentScreen> {
  PaymentIntent? _retrievedPaymentIntent;
  CardFieldInputDetails? _card;
  SetupIntent? _setupIntentResult;
  String _email = 'jenny@gmail.com';

  int step = 0;
  final kApiUrl = defaultTargetPlatform == TargetPlatform.android
      ? 'http://10.0.2.2:4242'
      : 'http://localhost:4242';
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold1(
      title: 'Setup Future Payment',
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: TextFormField(
            initialValue: _email,
            decoration: InputDecoration(hintText: 'Email', labelText: 'Email'),
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: CardField(
            onCardChanged: (card) {
              setState(() {
                _card = card;
              });
            },
          ),
        ),
        Stepper(
          controlsBuilder: emptyControlBuilder,
          currentStep: step,
          steps: [
            Step(
              title: Text('Save card'),
              content: LoadingButton(
                onPressed: _card?.complete == true ? _handleSavePress : null,
                text: 'Save',
              ),
            ),
            Step(
              title: Text('Pay with saved card'),
              content: LoadingButton(
                onPressed: _setupIntentResult != null
                    ? _handleOffSessionPayment
                    : null,
                text: 'Pay with saved card off-session',
              ),
            ),
            Step(
              title: Text('[Extra] Recovery Flow - Authenticate payment'),
              content: Column(
                children: [
                  Text(
                      'If the payment did not succeed. Notify your customer to return to your application to complete the payment. We recommend creating a recovery flow in your app that shows why the payment failed initially and lets your customer retry.'),
                  SizedBox(height: 8),
                  LoadingButton(
                    onPressed: _retrievedPaymentIntent != null
                        ? _handleRecoveryFlow
                        : null,
                    text: 'Authenticate payment (recovery flow)',
                  ),
                ],
              ),
            ),
          ],
        ),
        if (_setupIntentResult != null)
          Padding(
            padding: EdgeInsets.all(16),
            child: ResponseCard(
              response: _setupIntentResult!.toJson().toPrettyString(),
            ),
          ),
      ],
    );
  }

  Future<void> _handleSavePress() async {
    if (_card == null) {
      return;
    }
    try {
      // 1. Create setup intent on backend
      final clientSecret = await _createSetupIntentOnBackend(_email);
      print('Client Secret: ' + clientSecret.toString());
      // 2. Gather customer billing information (ex. email)
      final billingDetails = BillingDetails(
        name: "Test User",
        email: 'email@stripe.com',
        phone: '+48888000888',
        address: Address(
          city: 'Houston',
          country: 'US',
          line1: '1459  Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),
      ); // mo/ mocked data for tests

      // 3. Confirm setup intent

      final setupIntentResult = await Stripe.instance.confirmSetupIntent(
        clientSecret,
        PaymentMethodParams.card(
          billingDetails: billingDetails,
        ),
      );
      log('Setup Intent created $setupIntentResult');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Success: Setup intent created.',
          ),
        ),
      );
      setState(() {
        step = 1;
        _setupIntentResult = setupIntentResult;
      });
    } catch (error, s) {
      print('Error while saving payment' + error.toString() + s.toString());
      log('Error while saving payment', error: error, stackTrace: s);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error code: $error')));
    }
  }

  Future<void> _handleOffSessionPayment() async {
    final res = await _chargeCardOffSession();
    if (res['error'] != null) {
      // If the PaymentIntent has any other status, the payment did not succeed and the request fails.
      // Notify your customer e.g., by email, text, push notification) to complete the payment.
      // We recommend creating a recovery flow in your app that shows why the payment failed initially and lets your customer retry.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Error!: The payment could not be completed! ${res['error']}')));
      await _handleRetrievePaymentIntent(res['clientSecret']);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Success!: The payment was confirmed successfully!')));
      setState(() {
        step = 2;
      });
    }

    log('charge off session result: $res');
  }

  // When customer back to the App to complete the payment, retrieve the PaymentIntent via clientSecret.
  // Check the PaymentIntent’s lastPaymentError to inspect why the payment attempt failed.
  // For card errors, you can show the user the last payment error’s message. Otherwise, you can show a generic failure message.
  Future<void> _handleRetrievePaymentIntent(String clientSecret) async {
    final paymentIntent =
        await Stripe.instance.retrievePaymentIntent(clientSecret);
    /*final errorCode = paymentIntent.lastPaymentError?.code;
    var failureReason = 'Payment failed, try again.'; // Default to a generic error message
    if (paymentIntent?.lastPaymentError?.type == 'Card') {
      failureReason = paymentIntent.lastPaymentError.message;
    }*/
    final errorCode = false;

    if (errorCode) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('failureReason')));
      //setPaymentError(errorCode);
    }

    final paymentMethodId = paymentIntent.paymentMethodId == null
        ? _setupIntentResult?.paymentMethodId
        : paymentIntent.paymentMethodId;

    setState(() {
      _retrievedPaymentIntent =
          paymentIntent.copyWith(paymentMethodId: paymentMethodId);
    });
  }

  //  https://stripe.com/docs/payments/save-and-reuse?platform=ios#start-a-recovery-flow
  Future<void> _handleRecoveryFlow() async {
    // TODO lastPaymentError
    if (_retrievedPaymentIntent?.paymentMethodId != null && _card != null) {
      await Stripe.instance.confirmPayment(
        _retrievedPaymentIntent!.clientSecret,
        PaymentMethodParams.cardFromMethodId(
            paymentMethodId: _retrievedPaymentIntent!.paymentMethodId!),
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Success!: The payment was confirmed successfully!')));
  }

  Future<String> _createSetupIntentOnBackend(String email) async {
    final url = Uri.parse('https://api.stripe.com/v1/setup_intents');
    var data = {
       'payment_method_types[]': 'card',
      };
    final response = await http.post(
      url,
      body: data,
      headers: {
        'Authorization': 'Bearer ${dotenv.env["STRIPE_SECRET_KEY"].toString()}',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );
    final Map<String, dynamic> bodyResponse = json.decode(response.body);
    print('Client Secret 235: ' + bodyResponse.toString());
    final clientSecret = bodyResponse['client_secret'] as String;
    log('Client token  $clientSecret');
    print('Client Secret 235: ' + clientSecret.toString());

    return clientSecret;
  }

  Future<Map<String, dynamic>> _chargeCardOffSession() async {
    final url = Uri.parse('https://api.stripe.com/v1/setup_intents');
    var data = {
       'usage': 'on_session',
      };
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${dotenv.env["STRIPE_SECRET_KEY"].toString()}',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: data,
    );
    return json.decode(response.body);
  }
}

extension PrettyJson on Map<String, dynamic> {
  String toPrettyString() {
    var encoder = new JsonEncoder.withIndent("     ");
    return encoder.convert(this);
  }
}
