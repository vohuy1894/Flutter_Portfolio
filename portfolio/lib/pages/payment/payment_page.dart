import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment"),),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardField(
              onCardChanged: (card) {
                print(card);
              },
            ),
            TextButton(
              onPressed: () async {
                await dotenv.load(fileName: "assets/.env");
                Stripe.publishableKey =
                    dotenv.env["STRIPE_SHAREABLE_KEY"].toString();
                 Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
                 Stripe.urlScheme = 'flutterstripe';
                await Stripe.instance.applySettings();
                // create payment method
                final paymentMethod = await Stripe.instance
                    .createPaymentMethod(PaymentMethodParams.card());
              },
              child: Text('pay'),
            )
          ],
        ),
      ),
    );
  }
}
