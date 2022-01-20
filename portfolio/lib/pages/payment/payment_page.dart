import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'list_order_items.dart';

class PaymentPage extends StatefulWidget {
  double amountToPay;
  double shippingCharge;
  double discount;
  double taxRate;
  PaymentPage(
      {Key? key,
      required this.amountToPay,
      required this.shippingCharge,
      required this.discount,
      required this.taxRate})
      : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

enum AddressTypes {
  Home,
  OnlinePayment,
}

class _PaymentPageState extends State<PaymentPage> {
  Map<String, dynamic>? paymentIntentData;
  var myType = AddressTypes.Home;

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    double tax = widget.amountToPay * widget.taxRate;
    double total =
        widget.amountToPay + tax + widget.shippingCharge - widget.discount;
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: primaryColor,
      ),
      bottomNavigationBar: ListTile(
        tileColor: primaryColor.withOpacity(0.1),
        title: Text("Total Amount"),
        subtitle: Text(
          "\$${total.toStringAsFixed(2)}",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: () async {
              await makePayment();
            },
            child: const Text(
              "Place Order",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      "User Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      "User Name: ",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: Text(
                      "Huy Vo",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      "Delivery Address: ",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      "5225 Buffalo Speedway, Houston, TX 77005fadsjfnkadsjnfkadsjnfkajsndkf",
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(),
                  ExpansionTile(
                    title: Text("Order Items"),
                    children: reviewCartProvider.getReviewCartDataList.map((e) {
                      return ListOrderItem(
                        reviewCartModel: e,
                      );
                    }).toList(),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      "Sub Total",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      "\$${reviewCartProvider.getTotalPrice()}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      "Shipping Charge",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: Text(
                      "\$${widget.shippingCharge}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      "Discount",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: Text(
                      "-\$${widget.discount}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      "Tax",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: Text(
                      "\$${tax.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      "Total",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: Text(
                      "\$${total.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Text("Payment Options"),
                  ),
                  RadioListTile(
                    value: AddressTypes.Home,
                    groupValue: myType,
                    title: Text("Home"),
                    onChanged: (AddressTypes? value) {
                      setState(() {
                        myType = value!;
                      });
                    },
                    secondary: Icon(
                      Icons.work,
                      color: primaryColor,
                    ),
                  ),
                  RadioListTile(
                    value: AddressTypes.OnlinePayment,
                    groupValue: myType,
                    title: Text("OnlinePayment"),
                    onChanged: (AddressTypes? value) {
                      setState(() {
                        myType = value!;
                      });
                    },
                    secondary: Icon(
                      Icons.devices_other,
                      color: primaryColor,
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      double amount = widget.amountToPay +
          widget.amountToPay * widget.taxRate +
          widget.shippingCharge -
          widget.discount;
      print(amount);
      paymentIntentData = await createPaymentIntent(
          amount.toStringAsFixed(2).replaceAll(".", ""),
          'USD'); 
          final billingDetails = BillingDetails(
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
      ); // mocked data for tests

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            // Customer keys
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
          customerId: paymentIntentData!['customer'],
            applePay: true,
            googlePay: true,
            testEnv: true,
            style: ThemeMode.system,
            merchantCountryCode: 'US',
            merchantDisplayName: 'Portfolio Test',
            billingDetails: billingDetails,
          ))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer ${dotenv.env["STRIPE_SECRET_KEY"].toString()}',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
          if(response.statusCode == 200)
          {
            //point system add here
          }
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('error charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount));
    return a.toString();
  }
}
