import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pantau_corona/class/dashboard.dart';
import 'package:pantau_corona/constants/constant.dart';
import 'package:pantau_corona/pages/list_provinsi_page.dart';
import 'package:pantau_corona/pages/main_page.dart';
import 'package:pantau_corona/pages/main_page2.dart';
import 'package:pantau_corona/pages/offline_page.dart';
import 'package:pantau_corona/widgets/card_dashboard.dart';
import 'package:pantau_corona/widgets/card_listview_dashboard.dart';
import 'package:http/http.dart' as http;

class TabsHome2 extends StatefulWidget {
    TabsHome2State createState() {
        return TabsHome2State();
    }
}

class TabsHome2State extends State<TabsHome2> {
    Dashboard dataIndonesia;

    String totalPositif = '0';
    String namaPositif = 'Positif';

    String totalSembuh = '0';
    String namaSembuh = 'Sembuh';

    String totalMeninggal = '0';
    String namaMeninggal = 'Meninggal';

    bool online = true;
    bool connectionApiError = false;
    bool dataDashboardHasLoad = false;
    bool dataPositifHasLoad = false;
    bool dataSembuhHasLoad = false;
    bool dataMeninggalHasLoad = false;

    void checkConnetion() async {
        var connectivityResult = await Connectivity().checkConnectivity();

        if (connectivityResult==ConnectivityResult.none) {
            setState(() {
                online = false;
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

        checkConnetion();

        return SafeArea(
            child: Stack(
                children: <Widget>[
                    Positioned(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                        Colors.indigo,
                                        Colors.indigoAccent,
                                    ]
                                )
                            ),
                            child: Stack(
                                children: <Widget>[
                                    Positioned(
                                        top: 20,
                                        left: 40,
                                        child: Image.asset(
                                            'assets/images/doctor-woman.png',
                                            width: 120,
                                        ),
                                    ),
                                    Positioned(
                                        top: 115,
                                        left: 350,
                                        child: InkWell(
                                            child: Icon(
                                                FontAwesomeIcons.syncAlt,
                                                color: Colors.black,
                                            ),
                                            onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage2()));
                                            },
                                        ),
                                    ),
                                    Positioned(
                                        top: 25,
                                        left: 175,
                                        child: Text(
                                            'PANTAU \n CORONA VIRUS',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'PTSans'
                                            ),
                                        )
                                    ),
                                ],
                            ),
                        )
                    ),
                    Positioned(
                        top: 165,
                        child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                padding: EdgeInsets.fromLTRB(25, 20, 25, 30),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(50),
                                    )
                                ),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        title('Indonesia', formattedDate),
                                        SizedBox(height: 6),
                                        getDashboardIndonesiaBuilder(),
                                        Divider(),
                                        Container(
                                            margin: EdgeInsets.only(top: 0, bottom: 25),
                                            child: Row(
                                                children: <Widget>[
                                                    Expanded(
                                                        flex: 1,
                                                        child: getCardListViewDashboardBuilder(
                                                            'https://api.kawalcorona.com/positif',
                                                            namaPositif, totalPositif, dataPositifHasLoad
                                                        )
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: getCardListViewDashboardBuilder(
                                                            'https://api.kawalcorona.com/sembuh',
                                                            namaSembuh, totalSembuh, dataSembuhHasLoad
                                                        )
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: getCardListViewDashboardBuilder(
                                                            'https://api.kawalcorona.com/meninggal',
                                                            namaMeninggal, totalMeninggal, dataMeninggalHasLoad
                                                        )
                                                    ),
                                                ],
                                            )
                                        ),
                                    ]
                                )
                        )
                    )
                ]
            )
        );
    }

    Widget cardJumlahKasus(String totalPasien, String title, bool hasLoad) {
        return Card(
            color: Colors.yellow,
            child: Container(
                height: 80,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color:Colors.indigo[200],
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/world.png",
                        ),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.1), 
                            BlendMode.dstATop
                        ),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: <BoxShadow>[
                        BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2
                            )
                        ],
                ),
                child: hasLoad ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        Text(
                            totalPasien,
                            style: TextStyle(
                                fontSize: 17,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold
                            ),
                        ),
                        Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                letterSpacing: 1,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600
                            ),
                        ),
                    ],
                ) : Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black)
                ))
            )
        );
    }

    Widget title(String lokasi, String waktuUpdate) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                Text(
                    'Pembaruan Kasus',
                    style: TextStyle(
                        fontSize: headFontSize,
                        fontWeight: FontWeight.bold,
                    ),
                ),
                SizedBox(height: 5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            size: 15,
                        ),
                        SizedBox(width: 5),
                        RichText(
                            text: TextSpan(
                                text: '$lokasi : ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'PTSans'
                                ),
                                children: [
                                    TextSpan(
                                        text: '$waktuUpdate',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'PTSans'
                                        ),
                                    ),
                                ]
                            ),
                        ),
                    ],
                ),
            ],
        );
    }

    Widget getCardDashboardIndonesia(BuildContext context, Dashboard dashboard) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                CardDashboard(
                    textJudul: 'Total Pasien Positif',
                    textTotal: dataDashboardHasLoad == true ? dashboard.positif : '0',
                    isHasLoad: dataDashboardHasLoad,
                    gambarIcon: 'assets/images/icon/sad.png',
                    listColors: [
                        Colors.green[800],
                        Colors.green,
                    ]
                ),
                CardDashboard(
                    textJudul: 'Total Pasien Sembuh',
                    textTotal: dataDashboardHasLoad == true ? dashboard.sembuh : '0',
                    isHasLoad: dataDashboardHasLoad,
                    gambarIcon: 'assets/images/icon/smile.png',
                    listColors: [
                        Colors.blue[800], 
                        Colors.blue,
                    ]
                ),
                CardDashboard(
                    textJudul: 'Total Pasien Meninggal',
                    textTotal: dataDashboardHasLoad == true ? dashboard.meninggal : '0',
                    isHasLoad: dataDashboardHasLoad,
                    gambarIcon: 'assets/images/icon/cry.png',
                    listColors: [
                        Colors.red[600], 
                        Colors.red
                    ]
                ),
            ],
        );
    }

    getDashboardIndonesiaBuilder() {
        return FutureBuilder(
            future: _getDataDashboardIndonesia(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                    return Center(
                        child: Text("${snapshot.error}"),  
                    );
                }

                Dashboard dashboard = snapshot.data ?? dataIndonesia;

                return getCardDashboardIndonesia(context, dashboard);

                // if (connectionApiError) {
                //     return ErrorPage();
                // }
            },
        );
    }

    getCardListViewDashboardBuilder(String stringUrl, String nama, String total, bool hasLoad) {
        return FutureBuilder(
            future: _getDataCardListViewDashboard(stringUrl),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                    return Center(
                        child: Text("${snapshot.error}"),  
                    );
                }

                return cardJumlahKasus(
                    total, nama, hasLoad
                );

            }
        );
    }

    Future<Dashboard> _getDataCardListViewDashboard(String urlString) async {
        try {
            StringBuffer sp = new StringBuffer();
            sp.write(urlString);
            final String url = sp.toString();

            var response = await http.get(url);
            if (response.statusCode == 200) {
                var jsonDecode = json.decode(response.body);

                if (jsonDecode['name'].toString().toLowerCase().contains('total positif')) {
                    setState(() {
                        totalPositif = jsonDecode['value'];
                        dataPositifHasLoad = true;
                    });
                }

                if (jsonDecode['name'].toString().toLowerCase().contains('total sembuh')) {
                    setState(() {
                        totalSembuh = jsonDecode['value'];
                        dataSembuhHasLoad = true;
                    });
                }

                if (jsonDecode['name'].toString().toLowerCase().contains('total meninggal')) {
                    setState(() {
                        totalMeninggal = jsonDecode['value'];
                        dataMeninggalHasLoad = true;
                    });
                }
            }
        } catch (e) {
            print(e);
        }
    }

    Future<Dashboard> _getDataDashboardIndonesia() async {
        try {
            StringBuffer sp = new StringBuffer();
            sp.write('https://api.kawalcorona.com/indonesia');
            final String url = sp.toString();

            var response = await http.get(url);
            if (response.statusCode == 200) {
                var jsonDecod = json.decode(response.body);

                dataIndonesia = Dashboard(
                    positif: jsonDecod[0]['positif'],
                    sembuh: jsonDecod[0]['sembuh'],
                    meninggal: jsonDecod[0]['meninggal'],
                );

                setState(() {
                    dataDashboardHasLoad = true;
                });
            }
            

        } catch (e) {
            // setState(() {
            //     connectionApiError = true;
            // });
            print(e);
        }

        return dataIndonesia;
    }
}