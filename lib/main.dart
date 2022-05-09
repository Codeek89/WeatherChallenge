import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_challenge/bloc/search_bloc.dart';
import 'package:weather_challenge/bloc/weather_bloc.dart';
import 'package:weather_challenge/ui/pages/search_page.dart';
import 'package:weather_challenge/util/strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: WeatherStrings.titleName,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.redAccent,
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            headline3: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
            bodyText1: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            bodyText2: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              textStyle: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              elevation: 5,
              padding: const EdgeInsets.all(8.0),
            ),
          ),
        ),
        home: const SearchPage(),
      ),
    );
  }
}
