import 'package:adnan_admob_task/screens/recycler_activity.dart';
import 'package:adnan_admob_task/services/ad_services.dart';
import 'package:adnan_admob_task/variables/variables.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> list = [];

  // ignore: todo
  static const _kAdIndex = 4;

  @override
  void initState() {
    super.initState();
    AdServices.myBanner.load();
    AdServices.createInterstitialAd();
    Variables.tvText == ''
        ? Variables.tvText = "Task"
        : Variables.tvText = "اردو";
    list.add('Pakistan');
    list.add('Panama');
    list.add('America');
    list.add('China');
    list.add('Russia');
    list.add('India');
    list.add('United Kingdom');
    list.add('United Arab Emarat');
    list.add('Tunisia');
    list.add('Oman');

    //======== Native Ad =========
    AdServices.ad = NativeAd(
      adUnitId: AdServices.nativeAdUnitId,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            AdServices.ad = ad as NativeAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load

          ad.dispose();

          debugPrint(
              'Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    AdServices.ad!.load();
    //=================
  }

  //============ Logout Dialog ======================

  Future<bool> showLogOutDialog(BuildContext context) async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Exit"),
              content: const Text("Do you want to Exit App?"),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('No')),
                TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Yes')),
              ],
            ));
  }

  //============ END ===================
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => showLogOutDialog(context),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: AdServices.myBanner.size.width.toDouble(),
                  height: AdServices.myBanner.size.height.toDouble(),
                  child: AdWidget(ad: AdServices.myBanner),
                ),
                SizedBox(
                  height: myHeight - 98,
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        Variables.tvText,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Variables.tvText = "اردو";
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RecyclerActivity(
                                    list: list,
                                  )));
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 37)),
                        child: const Text(
                          "Recycler Activity",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: AdServices.loaded == true
                            ? () {
                                AdServices.showInterstitialAd();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 37)),
                        child: const Text(
                          "Show Ad",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      //==== Native Ad ===
                      Container(
                        height: 72.0,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: AdWidget(ad: AdServices.ad!),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
