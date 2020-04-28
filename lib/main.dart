import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pantau_corona/pages/splashscreen_page.dart';
import 'package:pantau_corona/widgets/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

    final String jsonConfig = await rootBundle.loadString('assets/config.json');
    Config config = Config.fromJson(jsonDecode(jsonConfig));

    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('apiUrl', config.apiUrl);

    return runApp(MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Pantau Corona',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Colors.indigo,
                fontFamily: 'PTSans'
            ),
            home: SplashscreenPage()
    ));
}
