import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:najot_talim/presentation/screen/home/card/widget.dart';

import 'guid_gen.dart';

class CardAddScreen extends StatefulWidget {
  const CardAddScreen({Key? key}) : super(key: key);

  @override
  State<CardAddScreen> createState() => _CardAddScreenState();
}

class _CardAddScreenState extends State<CardAddScreen> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(right: 20, left: 20),
                padding: const EdgeInsets.only(right: 30, left: 30),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.teal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(cardName.text),
                        Spacer(),
                        Text(cardType.text),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Text(cardNumber.text,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF12121D))),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Karta egasi",
                                style: TextStyle(
                                    color: Color.fromRGBO(18, 18, 29, 0.3))),
                            Text(cardOwner.text)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Amal qilish muddati",
                              style: TextStyle(
                                  color: Color.fromRGBO(18, 18, 29, 0.3)),
                            ),
                            Text(cardExpired.text)
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
                      height: 50,
                      width: 50,
                      color: Colors.greenAccent,
                      margin: EdgeInsets.only(left: 5),
                    )
                ],
              ),
            ),
            Text("Karta raqam"),
            SizedBox(height: 10),
            customCardTextField(
                enable: true,
                maskFormatter: maskFormatter,
                controller: cardNumber,
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  setState(() {});
                }),
            SizedBox(height: 10),
            Text("Karta mudati"),
            SizedBox(height: 10),
            customCardTextField(
                enable: true,
                keyboardType: TextInputType.number,
                controller: cardExpired,
                maskFormatter: maskFormatterExpired,
                onChanged: (value) {
                  setState(() {});
                  if (value != "" &&
                      int.parse(value.toString().substring(0, 1)) < 2 &&
                      int.parse(value.toString().substring(0, 1)) >= 0) {
                    print(
                        '_CardAddScreenState.build aasa ${value.toString().substring(0, 1)}');
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
                controller: cardType,
                onChanged: (v) {
                  setState(() {});
                }),
            SizedBox(height: 100),
            TextButton(
                style: TextButton.styleFrom(
                    maximumSize: Size(double.infinity, 40),
                    minimumSize: Size(double.infinity, 40),
                    backgroundColor: Colors.black),
                onPressed: () async {
                  var cardId = GUIDGen.generate();
                  var token = GUIDGen.generate();
                  final _fireStore =
                      FirebaseFirestore.instance.collection(_deviceData["id"]);
                  await _fireStore.doc(cardId).set({
                    "cardId": cardId,
                    "gradient": 1,
                    "cardNumber": cardNumber.text.replaceAll(" ", ""),
                    "cardName": cardName.text,
                    "cardExpired": cardExpired.text,
                    "cardOwner": cardOwner.text,
                    "cardType": cardType.text,
                    "userId": token,
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
