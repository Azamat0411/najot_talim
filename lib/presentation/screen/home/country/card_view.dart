import 'package:flutter/material.dart';
import 'package:najot_talim/core/constant/app_colors.dart';
import 'package:najot_talim/presentation/component/text_widget.dart';

import '../../../../entities/hive_db.dart';

class CountryCardView extends StatelessWidget {
  const CountryCardView({Key? key, required this.country}) : super(key: key);

  final Countries country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
            text: country.name ?? '',
            textColor: kPrimaryWhiteColor,
            fontWeight: FontWeight.w600,
            fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            _row(title: "Name:", name: country.name??''),
            _row(title: "Capital:", name: country.capital??''),
            _row(title: "Phone:", name: country.phone??''),
            _row(title: "Currency:", name: country.currency??''),
            _row(title: "Continent:", name: country.emoji??''),
            _row(title: "Continent:", name: (country.continent?.name)??''),
          ],
        ),
      ),
    );
  }

  _row({required String title, required String name}) {
    return Row(
      children: [
        TextWidget(
            text: title,
            textColor: kPrimaryBlack50Color,
            fontWeight: FontWeight.w500,
            fontSize: 22),
        const SizedBox(width: 5),
        Expanded(
          child: TextWidget(
              text: name,
              textColor: kPrimaryBlackColor,
              fontWeight: FontWeight.w500,
              fontSize: 22),
        ),
      ],
    );
  }
}
