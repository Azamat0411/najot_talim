import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:najot_talim/core/constant/app_colors.dart';
import 'package:najot_talim/domain/api_client_impl.dart';
import 'package:najot_talim/presentation/component/loader.dart';
import 'package:najot_talim/presentation/component/text_widget.dart';
import 'package:najot_talim/presentation/route/route.dart';
import 'package:najot_talim/presentation/route/routes_const.dart';
import 'package:najot_talim/presentation/screen/internetHelper/internetHelper.dart';

import '../../../../core/constant/const.dart';
import '../../../../domain/api_client.dart';
import '../../../../entities/hive_db.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({Key? key}) : super(key: key);

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  ApiClientImpl apiClient = ApiClient();

  _getCountries() {
    apiClient.getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return InternetHelper(
      connect: _getCountries,
      builder: (context) => ValueListenableBuilder(
          valueListenable: Hive.box<HiveDB>(db).listenable(),
          builder: (context, Box<HiveDB> box, _) {
            List<Countries>? countries =
                box.get(db)?.countryModel?.data?.countries;
            return countries != null
                ? ListView.builder(
                    itemCount: countries.length,
                    itemBuilder: (context, index) {
                      return _card(countries[index]);
                    })
                : const Loader();
          }),
    );
  }

  _card(Countries country) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kPrimaryWhiteColor
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: (){
            NavigationPages().pushNamed(RouteList.cardView, arguments: country);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                    text: country.name ?? '',
                    textColor: kPrimaryBlackColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
                TextWidget(
                    text: country.capital ?? '',
                    textColor: kPrimaryGrey100Color,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
