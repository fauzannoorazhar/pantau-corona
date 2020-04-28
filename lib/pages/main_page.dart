
import 'dart:convert';
import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pantau_corona/class/dashboard.dart';
import 'package:pantau_corona/main.dart';
import 'package:pantau_corona/pages/error_page.dart';
import 'package:pantau_corona/pages/list_provinsi_page.dart';
import 'package:pantau_corona/pages/offline_page.dart';
import 'package:pantau_corona/pages/splashscreen_page.dart';
import 'package:pantau_corona/pages/tabs/tabs_home.dart';
import 'package:pantau_corona/pages/tabs/tabs_hotline.dart';
import 'package:pantau_corona/widgets/card_dashboard.dart';
import 'package:pantau_corona/widgets/card_listview_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
    MainPageState createState() {
        return MainPageState();
    }
}

class MainPageState extends State<MainPage> {
    int _selectedIndexTab = 0;

    @override
    Widget build(BuildContext context) {

        // TODO: implement build
        return Scaffold(
            appBar: AppBar(
                title: Text(
                    'PANTAU CORONA',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoMono'
                    ),
                ),
                centerTitle: false,
                leading: InkWell(
                    child: Icon(
                        FontAwesomeIcons.syncAlt,
                        color: Colors.white,
                    ),
                    onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                    },
                ),
            ),
            body: getBodyTabContent(),
            bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                    setState(() {
                        this._selectedIndexTab = index;
                    });
                },
                currentIndex: _selectedIndexTab,
                selectedItemColor: Colors.indigo,
                unselectedItemColor: Colors.black54,
                iconSize: 28,
                items: <BottomNavigationBarItem> [
                    BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.home),
                        title: Text(
                            'HOME',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                        )
                    ),
                    BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.phoneAlt),
                        title: Text(
                            'HOTLINE',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),)
                    ),
                ],
            ),
        );
    }

    Widget getBodyTabContent() {
        if(_selectedIndexTab == 0) {
            return TabsHome();
        }

        if  (_selectedIndexTab == 1) {
            return TabsHotline();
        }
    }
}