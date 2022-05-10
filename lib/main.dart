import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_challenge/bloc/search_bloc.dart';
import 'package:weather_challenge/bloc/weather_bloc.dart';
import 'package:weather_challenge/domain/domain.dart';
import 'package:weather_challenge/ui/pages/search_page.dart';
import 'package:weather_challenge/util/strings.dart';
import 'package:weather_challenge/util/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiBlocProvider(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => ThemeNotifier(),
            lazy: false,
          ),
        ],
        child: const MyApp(),
      ),
      providers: [
        BlocProvider(
          create: (context) => WeatherBloc(
            baseDomain: Domain(),
          ),
        ),
        BlocProvider(
          create: (context) => SearchBloc(
            baseDomain: Domain(),
          ),
        )
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: WeatherStrings.titleName,
        theme: theme.currentTheme,
        themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: const SearchPage(),
      );
    });
  }
}
