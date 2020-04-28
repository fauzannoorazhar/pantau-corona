import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantau_corona/class/dashboard.dart';
import 'package:pantau_corona/pages/list_provinsi_page.dart';
import 'package:pantau_corona/pages/main_page.dart';
import 'package:pantau_corona/pages/offline_page.dart';
import 'package:pantau_corona/widgets/card_dashboard.dart';
import 'package:pantau_corona/widgets/card_listview_dashboard.dart';
import 'package:http/http.dart' as http;

class TabsHome extends StatefulWidget {
    TabsHomeState createState() {
        return TabsHomeState();
    }
}

class TabsHomeState extends State<TabsHome> {
    Dashboard dataIndonesia;

    String totalPositif = '0';
    String namaPositif = 'Data Positif';

    String totalSembuh = '0';
    String namaSembuh = 'Data Sembuh';

    String totalMeninggal = '0';
    String namaMeninggal = 'Data Meninggal';

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
        checkConnetion();

        return SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(10),
                child: online == false ? OfflinePage() : RefreshIndicator(
                onRefresh: () {
                    return _getDataDashboardIndonesia();
                },
                child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            getDashboardIndonesiaBuilder(),
                            title('Data Kasus Corona Virus : ', 'Dunia'),
                            Container(
                                height: 80,
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: <Widget>[
                                        getCardListViewDashboardBuilder([
                                            Colors.blueGrey[100],
                                            Colors.blueGrey,
                                        ], 'https://api.kawalcorona.com/positif', 
                                        namaPositif, totalPositif, dataPositifHasLoad),
                                        getCardListViewDashboardBuilder([
                                            Colors.blueGrey,
                                            Colors.blueGrey[100],
                                        ], 'https://api.kawalcorona.com/sembuh', 
                                        namaSembuh, totalSembuh, dataSembuhHasLoad),
                                        getCardListViewDashboardBuilder([
                                            Colors.blueGrey[100],
                                            Colors.blueGrey,
                                        ], 'https://api.kawalcorona.com/meninggal', 
                                        namaMeninggal, totalMeninggal, dataMeninggalHasLoad),
                                    ],
                                ),
                            )
                        ],
                    ),
                )
            )
        );
    }

    Widget title(String text1, String text2) {
        return Container(
            margin: EdgeInsets.only(bottom: 10),
            child: RichText(
                text: TextSpan(
                    text: text1,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700
                    ),
                    children: [
                        TextSpan(
                            text: text2,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold
                            )
                        )
                    ]
                ),
            ),
        );
    }

    Widget getCardDashboardIndonesia(BuildContext context, Dashboard dashboard) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                title('Data Kasus Corona Virus : ', 'Indonesia'),
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
                // InkWell(
                //     onTap: () {
                //         Navigator.push(
                //             context, 
                //             MaterialPageRoute(builder: (context) => ListProvinsiPage())
                //         );
                //     },
                //     child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: <Widget>[
                //             Text(
                //                 'Lihat Data Per Provinsi ',
                //                 style: TextStyle(
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.bold,
                //                 ),
                //             ),
                //             Icon(
                //                 FontAwesomeIcons.angleDoubleRight,
                //                 size: 16,
                //             ),
                //         ],
                //     ),
                // ),
                SizedBox(height: 10),
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

    getCardListViewDashboardBuilder(List<Color> listColors, String stringUrl, String nama, String total, bool hasLoad) {
        return FutureBuilder(
            future: _getDataCardListViewDashboard(stringUrl),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                    return Center(
                        child: Text("${snapshot.error}"),  
                    );
                }

                return CardListViewDashboard(
                    isHasLoad: hasLoad,
                    textJudul: nama,
                    textTotal: total,
                    listColors: listColors
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
                        namaPositif = jsonDecode['name'];
                        totalPositif = jsonDecode['value'];
                        dataPositifHasLoad = true;
                    });
                }

                if (jsonDecode['name'].toString().toLowerCase().contains('total sembuh')) {
                    setState(() {
                        namaSembuh = jsonDecode['name'];
                        totalSembuh = jsonDecode['value'];
                        dataSembuhHasLoad = true;
                    });
                }

                if (jsonDecode['name'].toString().toLowerCase().contains('total meninggal')) {
                    setState(() {
                        namaMeninggal = jsonDecode['name'];
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