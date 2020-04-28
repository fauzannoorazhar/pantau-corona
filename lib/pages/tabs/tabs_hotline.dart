import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class TabsHotline extends StatefulWidget {
    TabsHotlineState createState() {
        return TabsHotlineState();
    }
}

class TabsHotlineState extends State<TabsHotline> {
    Future<void> _launched;

    Future<void> _call(String url) async {
        if (await UrlLauncher.canLaunch(url)) {
            await UrlLauncher.launch(url);
        } else {
            throw 'Could not launch $url';
        }
    }

    @override
    Widget build(BuildContext context) {
        return SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        title(),
                        SizedBox(height: 10),
                        Row(
                            children: <Widget>[
                                Expanded(
                                    child: getCardHotline(
                                        Image.asset(
                                            'assets/images/kemenkes.png',
                                            height: 80,
                                            width: 80,
                                        ),
                                        '021-5210-411',
                                        'Kementrian Kesehatan'
                                    ),
                                ),
                                Expanded(
                                    child: getCardHotline(
                                        Image.asset(
                                            'assets/images/kemenkes.png',
                                            height: 80,
                                            width: 80,
                                        ),
                                        '0812-1212-3119',
                                        'Kementrian Kesehatan'
                                    ),
                                ),
                            ],
                        ),
                        Row(
                            children: <Widget>[
                                Expanded(
                                    child: getCardHotline(
                                        Image.asset(
                                            'assets/images/pemprov-dki.png',
                                            height: 80,
                                            width: 80,
                                        ),
                                        '112',
                                        'Pemprov DKI Jakarta'
                                    ),
                                ),
                                Expanded(
                                    child: getCardHotline(
                                        Image.asset(
                                            'assets/images/pemprov-dki.png',
                                            height: 80,
                                            width: 80,
                                        ),
                                        '0813-8837-6955',
                                        'Pemprov DKI Jakarta'
                                    ),
                                ),
                            ],
                        ),
                        Row(
                            children: <Widget>[
                                Expanded(
                                    child: getCardHotline(
                                        Image.asset(
                                            'assets/images/pemprov-jabar.png',
                                            height: 80,
                                            width: 80,
                                        ),
                                        '119',
                                        'Pemprov Jawa Barat'
                                    ),
                                ),
                                Expanded(
                                    child: getCardHotline(
                                        Image.asset(
                                            'assets/images/pemprov-jabar.png',
                                            height: 80,
                                            width: 80,
                                        ),
                                        '0811-209-3306',
                                        'Pemprov Jawa Barat'
                                    ),
                                ),
                            ],
                        ),
                        Row(
                            children: <Widget>[
                                Expanded(
                                    child: getCardHotline(
                                        Image.asset(
                                            'assets/images/pemprov-jateng.png',
                                            height: 80,
                                            width: 80,
                                        ),
                                        '024-358-0713',
                                        'Pemprov Jawa Tengah'
                                    ),
                                ),
                                Expanded(
                                    child: getCardHotline(
                                        Image.asset(
                                            'assets/images/pemprov-jateng.png',
                                            height: 80,
                                            width: 80,
                                        ),
                                        '0823-1360-0560',
                                        'Pemprov Jawa Tengah'
                                    ),
                                ),
                            ],
                        ),
                        Row(
                            children: <Widget>[
                                Expanded(
                                    child: getCardHotline(
                                        Image.asset(
                                            'assets/images/pemprov-yogya.jpg',
                                            height: 80,
                                            width: 80,
                                        ),
                                        '0274-555-585',
                                        'Pemprov D.I Yogyakarta'
                                    ),
                                ),
                                Expanded(
                                    child: getCardHotline(
                                        Image.asset(
                                            'assets/images/pemprov-yogya.jpg',
                                            height: 80,
                                            width: 80,
                                        ),
                                        '0811-2764-800',
                                        'Pemprov D.I Yogyakarta'
                                    ),
                                ),
                            ],
                        ),
                        Row(
                            children: <Widget>[
                                Expanded(
                                    child: getCardHotline(
                                        Image.asset(
                                            'assets/images/pemprov-jatim.png',
                                            height: 80,
                                            width: 80,
                                        ),
                                        '031-843-0313',
                                        'Pemprov Jawa Timur'
                                    ),
                                ),
                                Expanded(
                                    child: getCardHotline(
                                        Image.asset(
                                            'assets/images/pemprov-jatim.png',
                                            height: 80,
                                            width: 80,
                                        ),
                                        '0813-3436-7800',
                                        'Pemprov Jawa Timur'
                                    ),
                                ),
                            ],
                        ),
                    ],
                )
            )
        );
    }

    Widget getCardHotline(Widget images, String nomor, String pemerintah) {
        return InkWell(
            onTap: () => setState(() {
                _launched = _call('tel:$nomor');
            }),
            child: Container(
                width: 150,
                height: 180,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                    ),
                    elevation: 5,
                    child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: images
                                ),
                                Container(
                                    margin: EdgeInsets.only(bottom: 3, top: 10),
                                    child: Text(
                                        nomor,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'PTSans'
                                        ),
                                    ),
                                ),
                                Text(
                                    pemerintah,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'PTSans'
                                    ),
                                ),
                            ],
                        )
                    )
                )
            ),
        );
    }

    Widget title() {
        return Column(
            children: <Widget>[
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'CORONA',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor,
                            fontFamily: 'PTSans'
                        ),
                        children: [
                            TextSpan(
                                text: '-VIRUS HOTLINE',
                                style: TextStyle(fontSize: 30,color: Colors.black,fontFamily: 'PTSans'),
                            ),
                            TextSpan(
                                text: ' INDONESIA',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontFamily: 'PTSans'
                                ),
                            )
                        ]
                    ),
                ),
                SizedBox(height: 5),
                Text(
                    'Berikut daftar layanan darurat yang disediakan oleh Kementrian Kesehatan dan Pemerintah Daerah',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'PTSans'
                    ),
                )
            ],
        );
    }
}