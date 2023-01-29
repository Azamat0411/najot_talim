import 'package:flutter/material.dart';
import 'package:najot_talim/core/constant/app_colors.dart';
import 'package:najot_talim/entities/card_model.dart';
import 'package:najot_talim/presentation/bloc/custom_bloc_consumer.dart';
import 'package:najot_talim/presentation/component/loader.dart';
import 'package:najot_talim/presentation/component/text_widget.dart';
import 'package:najot_talim/presentation/screen/home/card/widget.dart';
import 'package:provider/provider.dart';

import '../../../route/routes_const.dart';
import 'bloc/card_bloc.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    // initPlatformState().then((value) => _deviceData = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBloc<CardBloc>(
      create: (context) => CardBloc()..add(LoadingEvent()),
      listener: (BuildContext context, state) {},
      builder: (blocContext, state) {
        return state is CardLoaded
            ? _body(blocContext, state.cards, state.id)
            : const Loader();
      },
    );
  }

  _body(BuildContext blocContext, List<CardModel> cards, String id) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            ...List.generate(
                cards.length, (index) => _card(blocContext, cards[index], id)),
            _inkWell(blocContext, id),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  _inkWell(BuildContext blocContext, String id) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.teal,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            await Navigator.pushNamed(context, RouteList.cardAdd, arguments: id)
                .then((value) {
              Provider.of<CardBloc>(blocContext, listen: false)
                  .add(LoadingEvent());
            });
          },
          child: Center(
            child: Icon(
              Icons.add,
              size: 50,
              color: kPrimaryWhiteColor,
            ),
          ),
        ),
      ),
    );
  }

  _card(BuildContext blocContext, CardModel card, String id) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            await Navigator.pushNamed(context, RouteList.cardEdit,
                arguments: [card.cardId, card.userId, id]).then((value) {
              Provider.of<CardBloc>(blocContext, listen: false)
                  .add(LoadingEvent());
            });
          },
          child: Container(
              padding: const EdgeInsets.only(right: 30, left: 30),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: linearGradient[card.gradient ?? 0],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      TextWidget(
                          text: card.cardName ?? '',
                          textColor: kPrimaryBlackColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      const Spacer(),
                      TextWidget(
                          text: card.cardType ?? '',
                          textColor: kPrimaryBlackColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ],
                  ),
                  const SizedBox(height: 50),
                  TextWidget(
                      text: card.cardNumber ?? '',
                      textColor: kPrimaryBlackColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                              text: "Karta egasi",
                              textColor: kPrimaryBlack50Color,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                          TextWidget(
                              text: card.cardOwner ?? '',
                              textColor: kPrimaryBlackColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                              text: "Amal qilish muddati",
                              textColor: kPrimaryBlack50Color,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                          TextWidget(
                              text: card.cardExpired ?? '',
                              textColor: kPrimaryBlackColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ],
                      )
                    ],
                  )
                ],
              )),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
