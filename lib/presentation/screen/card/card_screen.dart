import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for(int i=0;i<10;i++)
              Container(
                  margin: const EdgeInsets.only(right: 20, left: 20,bottom: 20),
                  padding: EdgeInsets.only(right: 30, left: 30),
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
                          Text("cardName.text"),
                          Spacer(),
                          Text("cardType.text"),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Text("cardNumber.text", style: TextStyle(fontSize: 16, color: Color(0xFF12121D))),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text("Karta egasi", style: TextStyle(color: Color.fromRGBO(18, 18, 29, 0.3))), Text("cardOwner.text")],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Amal qilish muddati",
                                style: TextStyle(color: Color.fromRGBO(18, 18, 29, 0.3)),
                              ),
                              Text("cardExpired.text")
                            ],
                          )
                        ],
                      )
                    ],
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
