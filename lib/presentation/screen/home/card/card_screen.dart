import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:najot_talim/presentation/route/route.dart';
import 'package:najot_talim/presentation/route/routes_const.dart';
import 'package:najot_talim/presentation/screen/home/card/widget.dart';

import '../../../../domain/firebase_repostory.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  Future<Map<String, dynamic>> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      deviceData = readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      print('_CardAddScreenState.initPlatformState ${deviceData["id"]}');
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    setState(() {
      _deviceData = deviceData;
    });

    return deviceData;
  }

  List proList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FireStoreRepository.get(_deviceData["id"]).then((value) {
            setState(() {
              proList = value;
            });
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < proList.length; i++)
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        NavigationPages().pushNamed(RouteList.cardEdit,
                            arguments: [
                              proList[i]["cardId"],
                              proList[i]["userId"],
                              _deviceData["id"]
                            ]);
                      },
                      child: Container(
                          padding: const EdgeInsets.only(right: 30, left: 30),
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: linearGradient[proList[i]["gradient"]],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  Text(proList[i]["cardName"].toString()),
                                  Spacer(),
                                  Text(proList[i]["cardType"].toString()),
                                ],
                              ),
                              const SizedBox(height: 50),
                              Text(proList[i]['cardNumber'].toString(),
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFF12121D))),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Karta egasi",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  18, 18, 29, 0.3))),
                                      Text(proList[i]["cardOwner"].toString())
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Amal qilish muddati",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                18, 18, 29, 0.3)),
                                      ),
                                      Text(proList[i]['cardExpired'].toString())
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteList.cardAdd);
                },
                child: Container(
                    // margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                    padding: EdgeInsets.only(right: 30, left: 30),
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.teal,
                    ),
                    child: Center(
                      child: Icon(Icons.add),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
