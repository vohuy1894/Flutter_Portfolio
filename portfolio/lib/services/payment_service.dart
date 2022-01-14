import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PaymentService{
  final int amountToPay;
  final String url;

  PaymentService({required this.amountToPay, required this.url});

  static init(){
    //Stripe.instance.
  }
}