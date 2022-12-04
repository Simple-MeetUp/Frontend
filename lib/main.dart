import 'package:dawu_start_from_homescreen/constants.dart';
import 'package:dawu_start_from_homescreen/models/Contest.dart';
import 'package:dawu_start_from_homescreen/models/current_index.dart';
import 'package:dawu_start_from_homescreen/models/user_attribute.dart';
import 'package:dawu_start_from_homescreen/models/user_auth_info.dart';
import 'package:dawu_start_from_homescreen/providers/contest_list_api.dart';
import 'package:dawu_start_from_homescreen/providers/user_attribute_api.dart';
import 'package:dawu_start_from_homescreen/providers/user_auth_info_api.dart';
import 'package:dawu_start_from_homescreen/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'http/dto.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ContestListApi contestListApi = ContestListApi();
    const DefaultColor = Color(0xff6667AB);

    return MultiProvider(
      providers: [
        Provider<CurrentIndex>.value(
            value: CurrentIndex(index: 1)), // for BottomNavigationBar
        Provider<List<Contest>>.value(
            value: ContestListApi.getContestList()), // for ContestList
        Provider<UserAttribute?>.value(
            value: UserAttributeApi.getUserAttribute()), // for ContestList,
        Provider<UserAuthInfo?>.value(value: UserAuthInfoApi.getUserAuthInfo()),
        Provider<TokenResponse>.value(
            value: TokenResponse("", accessToken: "", refreshToken: "")),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: createMaterialColor(defaultColor),
        ),
        home: SplashScreen(), // origin : HomeScreen()
      ),
    );
  }
}
