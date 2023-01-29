import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:najot_talim/entities/card_model.dart';
import 'package:najot_talim/presentation/screen/card/widget.dart';

import '../../../firebase_repostory.dart';
import 'guid_gen.dart';

class CardEditScreen extends StatefulWidget {
  final List cardIdAndUserId;

  const CardEditScreen({Key? key, required this.cardIdAndUserId}) : super(key: key);

  @override
  State<CardEditScreen> createState() => _CardEditScreenState();
}

class _CardEditScreenState extends State<CardEditScreen> {
  TextEditingController cardNumber = TextEditingController();
  TextEditingController cardExpired = TextEditingController();
  TextEditingController cardName = TextEditingController();
  TextEditingController cardOwner = TextEditingController();
  TextEditingController cardType = TextEditingController();
  final maskFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
  );
  final maskFormatterExpired = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
  );
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  Future<Map<String, dynamic>> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      deviceData = readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      print('_CardEditScreenState.initPlatformState ${deviceData["id"]}');
    } on PlatformException {
      deviceData = <String, dynamic>{'Error:': 'Failed to get platform version.'};
    }
    setState(() {
      _deviceData = deviceData;
    });

    return deviceData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  var _linearGradient = linearGradient[0];
int gradient=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Alert Dialog"),
                        content: Text("Dialog Content"),
                        actions: [
                          TextButton(
                            child: Text("Yes"),
                            onPressed: () async {
                              await FireStoreRepository.deleteTask(widget.cardIdAndUserId[2], widget.cardIdAndUserId[0]);
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.delete))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await FireStoreRepository.getItem(_deviceData["id"], widget.cardIdAndUserId[0]).then((value) {
              setState(() {
                CardModel model=CardModel(cardExpired: '');
                model.toJson();
                _linearGradient=linearGradient[value['gradient']];
                cardNumber.text = value['cardNumber'];
                cardExpired.text = value['cardExpired'];
                cardType.text = value["cardType"];
                cardName.text = value["cardName"];
                cardOwner.text = value["cardOwner"];
                // proList = value;
              });
            });
          },
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 20, left: 20),
                    padding: EdgeInsets.only(right: 30, left: 30),
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: _linearGradient,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Text(cardName.text,style: TextStyle(color: Colors.white),),
                            Spacer(),
                            Text(cardType.text,style: TextStyle(color: Colors.white),),
                          ],
                        ),
                        const SizedBox(height: 50),
                        Text(cardNumber.text, style: TextStyle(fontSize: 16, color: Colors.white)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text("Karta egasi", style: TextStyle(color: Colors.white)), Text(cardOwner.text,style: TextStyle(color:Colors.white),)],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Amal qilish muddati",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(cardExpired.text,style: TextStyle(color: Colors.white),)
                              ],
                            )
                          ],
                        )
                      ],
                    )),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < 10; i++)
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: ClipOval(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _linearGradient = linearGradient[i];
                                  gradient=i;
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  gradient: linearGradient[i],
                                ),
                                child: Center(
                                  child: _linearGradient==linearGradient[i]?Icon(Icons.check,color: Colors.white,):SizedBox(),
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text("Karta raqam"),
                SizedBox(height: 10),
                customCardTextField(
                    maskFormatter: maskFormatter,
                    controller: cardNumber,
                    keyboardType: TextInputType.number,
                    enable: false,
                    onChanged: (v) {
                      setState(() {});
                    }),
                SizedBox(height: 10),
                Text("Karta mudati"),
                SizedBox(height: 10),
                customCardTextField(
                    keyboardType: TextInputType.number,
                    controller: cardExpired,
                    enable: false,
                    maskFormatter: maskFormatterExpired,
                    onChanged: (value) {
                      setState(() {});
                      if (value != "" && int.parse(value.toString().substring(0, 1)) < 2 && int.parse(value.toString().substring(0, 1)) >= 0) {
                        print('_CardAddScreenState.build aasa ${value.toString().substring(0, 1)}');
                      }
                      // print('_CardAddScreenState.build  aa${value.toString().substring(0,2)}');
                      // print('_CardAddScreenState.build month ${DateTime.now().month.toString()}');
                      // print('_CardAddScreenState.build ${DateTime.now().year.toString().substring(2)}');
                    }),
                SizedBox(height: 10),
                Text("Karta nomi"),
                SizedBox(height: 10),
                customLabelTextField(
                    controller: cardName,
                    onChanged: (v) {
                      setState(() {});
                    }),
                SizedBox(height: 10),
                Text("Karta egasi "),
                SizedBox(height: 10),
                customLabelTextField(
                    controller: cardOwner,
                    onChanged: (v) {
                      setState(() {});
                    }),
                SizedBox(height: 10),
                Text("Karta turi"),
                SizedBox(height: 10),
                customLabelTextField(
                    enabled: false,
                    controller: cardType,
                    onChanged: (v) {
                      setState(() {});
                    }),
                SizedBox(height: 100),
                TextButton(
                    style: TextButton.styleFrom(maximumSize: Size(double.infinity, 40), minimumSize: Size(double.infinity, 40), backgroundColor: Colors.black),
                    onPressed: () async {
                      final _fireStore = FirebaseFirestore.instance.collection(_deviceData["id"]);
                      await _fireStore.doc(widget.cardIdAndUserId[0]).update({
                        "cardId": widget.cardIdAndUserId[0],
                        "gradient": gradient,
                        "cardNumber": cardNumber.text.replaceAll(" ", ""),
                        "cardName": cardName.text,
                        "cardExpired": cardExpired.text,
                        "cardOwner": cardOwner.text,
                        "cardType": cardType.text,
                        "userId": widget.cardIdAndUserId[1],
                      }).then((value) {
                        Navigator.pop(context);
                        setState(() {});
                      });
                    },
                    child: Text("Saqlash"))
              ],
            ),
          ),
        ));
  }
}
