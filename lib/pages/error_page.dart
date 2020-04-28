import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantau_corona/pages/main_page.dart';

class ErrorPage extends StatelessWidget {

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
                margin: EdgeInsets.only(right: 10, left: 10),
                height: MediaQuery.of(context).size.height * 0.8,
                child: errorPageContent()
            )
        );
    }

    Widget errorPageContent() {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                Visibility(
                    visible: false,
                    child: CircularProgressIndicator(),
                ),
                Icon(
                    Icons.error_outline,
                    size: 100,
                ),
                Text(
                    'Kesalahan Sumber Data ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                ),
                SizedBox(height: 3),
                Text(
                    'Sistem mendeteksi terdapat kesalahan pada sumber data refrensi yang digunakan, silahkan coba klik kembali untuk memuat ulang halaman',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14
                    ),
                )
            ],
        );
    }
}