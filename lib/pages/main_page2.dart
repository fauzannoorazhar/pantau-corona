import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantau_corona/pages/tabs/tabs_home2.dart';
import 'package:pantau_corona/pages/tabs/tabs_hotline.dart';

class MainPage2 extends StatefulWidget {
    MainPage2State createState() {
        return MainPage2State();
    }
}

class MainPage2State extends State<MainPage2> {
    int _selectedIndexTab = 0;

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return Scaffold(
            backgroundColor: Colors.white,
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
                backgroundColor: Colors.white,
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
            return TabsHome2();
        }

        if  (_selectedIndexTab == 1) {
            return Scaffold(
                appBar: AppBar(
                    title: Text(
                        'PANTAU CORONA',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                        )
                    ),
                ),
                body: TabsHotline(),
            );
        }
    }
}