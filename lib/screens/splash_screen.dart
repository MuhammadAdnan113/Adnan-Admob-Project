import 'package:adnan_admob_task/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../services/ad_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  int splashtime = 5;
  // duration of splash screen on second

  @override
  void initState() {
    AdServices.createInterstitialAd();
    AdServices.myBanner.load();
    Future.delayed(Duration(seconds: splashtime), () async {
      AdServices.showInterstitialAd();
      Navigator.pushReplacement(context, MaterialPageRoute(
          //pushReplacement = replacing the route so that
          //splash screen won't show on back button press
          //navigation to Home page.
          builder: (context) {
        return const HomeScreen();
      }));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //vertically align center
                children: [
                  SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset("assets/images/splash_logo.jpg")),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    //margin top 30
                    child: const Text(
                      "by M. Adnan",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: const Text("Version: 1.0.0",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 20,
                        )),
                  ),
                ])));
  }
}
