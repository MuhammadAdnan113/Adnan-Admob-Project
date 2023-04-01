import 'package:adnan_admob_task/variables/variables.dart';
import 'package:flutter/material.dart';

import '../services/ad_services.dart';
import 'home_screen.dart';

class RecyclerActivity extends StatefulWidget {
  List<String> list;
  RecyclerActivity({super.key, required this.list});

  @override
  State<RecyclerActivity> createState() => _RecyclerActivityState();
}

class _RecyclerActivityState extends State<RecyclerActivity> {
  Future<bool> showDialog() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double mtHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recycler Activity'),
        // leading: IconButton(
        //   onPressed: () {
        //     AdServices.myBanner.load();
        //     Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(builder: (context) => const HomeScreen()));
        //   },
        //   icon: const Icon(Icons.arrow_back),
        // ),
      ),
      body: WillPopScope(
        onWillPop: () {
          Variables.tvText = "اردو";
          setState(() {});
          return showDialog();
        },
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          height: mtHeight - 100,
          width: double.infinity,
          child: ListView.builder(
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                String item = widget.list.elementAt(index);
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        debugPrint('Pressed : $item');
                        AdServices.showInterstitialAd();
                      },
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
