import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_challenge/ui/pages/active_search_page.dart';
import 'package:weather_challenge/ui/widgets/weather_logo_image.dart';
import 'package:weather_challenge/util/keys.dart';
import 'package:weather_challenge/util/strings.dart';
import 'package:weather_challenge/util/theme.dart';

/// First page shown when loading the app.
/// You can see a simple logo, a button and
/// a little text about the author(me).
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(
      context,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              theme.switchThemeMode();
            },
            icon: theme.isDarkMode
                ? const Icon(
                    Icons.dark_mode,
                  )
                : const Icon(
                    Icons.light_mode,
                  ),
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
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
              style: Theme.of(context).textTheme.titleLarge,
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
                      transitionDuration: const Duration(
                        seconds: 1,
                      ),
                      pageBuilder: (_, __, ___) => const ActiveSearchPage(),
                    ),
                  );
                },
                child: Text(
                  WeatherStrings.searchBarHint,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: constraints.maxHeight * 0.025),
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.1,
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
        );
      }),
    );
  }
}
