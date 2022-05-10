import 'package:flutter/material.dart';
import 'package:weather_challenge/ui/pages/active_search_page.dart';
import 'package:weather_challenge/ui/widgets/weather_logo_image.dart';
import 'package:weather_challenge/util/keys.dart';
import 'package:weather_challenge/util/strings.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              WeatherLogoImage(
                key: const Key(TestingKeys.logoImage),
                height: constraints.maxHeight * 0.12,
                width: constraints.maxHeight * 0.12,
              ),
              Text(
                WeatherStrings.titleName,
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.02,
              ),
              Hero(
                tag: WeatherStrings.tagSearch,
                child: OutlinedButton(
                  key: const Key(TestingKeys.searchButton),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(seconds: 1),
                        pageBuilder: (_, __, ___) => const ActiveSearchPage(),
                      ),
                    );
                  },
                  child: Text(
                    WeatherStrings.searchBarHint,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: constraints.maxHeight * 0.025,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  WeatherStrings.madeBy,
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.02,
              ),
            ],
          ),
        );
      }),
    );
  }
}
