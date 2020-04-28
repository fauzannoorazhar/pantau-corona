import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantau_corona/pages/main_page.dart';

class OfflinePage extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
    // TODO: implement build
        return InkWell(
            onTap: () {
                Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => MainPage())
                );
            },
            child: Container(
                alignment: Alignment.center,
                //height: MediaQuery.of(context).size.height * 0.8,
                child: offlinePageContent()
            )
        );
    }

    Widget offlinePageContent() {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                Visibility(
                    visible: false,
                    child: CircularProgressIndicator(),
                ),
                Icon(
                    Icons.signal_wifi_off,
                    size: 100,
                ),
                Text(
                    'Internet Tidak Terhubung',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                ),
                SizedBox(height: 3),
                Text(
                    'Klik untuk memuat ulang halaman',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14
                    ),
                )
            ],
        );
    }
}