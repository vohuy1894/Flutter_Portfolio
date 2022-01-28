import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
//import 'constants.dart';

/// This example demonstrates fluid ads.
class FluidExample extends StatefulWidget {
  @override
  _FluidExampleExampleState createState() => _FluidExampleExampleState();
}

class _FluidExampleExampleState extends State<FluidExample> {
  FluidAdManagerBannerAd? _fluidAd;
  double _width = 200.0;
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Fluid example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.separated(
            itemCount: 3,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 40,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              if (index == 1) {
                return Align(
                  alignment: Alignment.center,
                  child: FluidAdWidget(
                    width: _width,
                    ad: _fluidAd!,
                  ),
                );
              } else if (index == 2) {
                return ElevatedButton(
                    onPressed: () {
                      double newWidth;
                      if (_width == 200.0) {
                        newWidth = 100.0;
                      } else if (_width == 100.0) {
                        newWidth = 150.0;
                      } else {
                        newWidth = 200.0;
                      }
                      setState(() {
                        _width = newWidth;
                      });
                    },
                    child: Text('Change size'));
              }
              return Text(
                Constants.placeholderText,
                style: TextStyle(fontSize: 24),
              );
            },
          ),
        ),
      ));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Create the ad objects and load ads.
    _fluidAd = FluidAdManagerBannerAd(
      adUnitId: '/6499/example/APIDemo/Fluid',
      request: AdManagerAdRequest(nonPersonalizedAds: true),
      listener: AdManagerBannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$_fluidAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$_fluidAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$_fluidAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$_fluidAd onAdClosed.'),
      ),
    )..load();
  }

  @override
  void dispose() {
    super.dispose();
    _fluidAd?.dispose();
  }
}

class Constants {
  /// Placeholder text.
  static const String placeholderText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod'
      ' tempor incididunt ut labore et dolore magna aliqua. Faucibus purus in'
      ' massa tempor. Quis enim lobortis scelerisque fermentum dui faucibus'
      ' in. Nibh praesent tristique magna sit amet purus gravida quis.'
      ' Magna sit amet purus gravida quis blandit turpis cursus in. Sed'
      ' adipiscing diam donec adipiscing tristique. Urna porttitor rhoncus'
      ' dolor purus non enim praesent. Pellentesque habitant morbi tristique'
      ' senectus et netus. Risus ultricies tristique nulla aliquet enim tortor'
      ' at.';
}