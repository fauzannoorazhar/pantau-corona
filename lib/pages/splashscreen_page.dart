import 'package:flutter/material.dart';
import 'package:pantau_corona/pages/main_page.dart';
import 'package:pantau_corona/pages/main_page2.dart';
import 'package:pantau_corona/widgets/splashscreen.dart';

class SplashscreenPage extends StatefulWidget {
    SplashscreenPageState createState() {
        return SplashscreenPageState();
    }
}

class SplashscreenPageState extends State<SplashscreenPage> {
    Widget build(BuildContext context) {
        return Splashscreen(
            seconds: 5,
            navigateAfterSeconds: MainPage2(),
            contentAfterImages: contentSplash(),
            image: Image.asset(
                'assets/images/logo-icon.png', 
                fit: BoxFit.fill,
                height: 100,
            ),
            backgroundColor: Colors.white,
            loadingText: Text('Tunggu Sebentar . . .',style: TextStyle(fontFamily: 'PTSans')),
            styleTextUnderTheLoader: TextStyle(),
            imageRadius: 80.0,
            loaderColor: Theme.of(context).primaryColor,
        );
    }

    Widget contentSplash() {
       return Padding (
        padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
            child: Container(
                child: Column(
                    children: <Widget>[
                        Text(
                            'SELAMAT DATANG DI APLIKASI',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                                fontFamily: 'PTSans'
                            ),
                        ),
                        SizedBox(height: 2),
                        RichText(
                            text: TextSpan(
                                text: 'PANTAU',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).primaryColor,
                                    fontFamily: 'PTSans'
                                ),
                                children: [
                                    TextSpan(
                                        text: ' CORONA',
                                        style: TextStyle(color: Colors.black, fontSize: 35,fontFamily: 'PTSans'),
                                    ),
                                ]
                            ),
                        )
                    ],
                )
            )
        );
    }
}