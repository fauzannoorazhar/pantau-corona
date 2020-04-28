import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ListProvinsiPage extends StatefulWidget {
    ListProvinsiPageState createState() {
        return ListProvinsiPageState();
    }
}

class ListProvinsiPageState extends State<ListProvinsiPage> {
    final TextEditingController _filter = TextEditingController();
    static String title = 'Data COVID per Provinsi';
    final dio = Dio();
    List listNamaProvinsi = List();
    List listProvinsi = List();
    String _searchText = "";
    Icon _searchIcon = Icon(Icons.search);
    Widget _appBarTitle = Text(title);

    ListProvinsiPageState() {
        _filter.addListener(() {
            if (_filter.text.isEmpty) {
                setState(() {
                    _searchText = "";
                    listProvinsi = listNamaProvinsi;
                });
            } else {
                setState(() {
                    _searchText = _filter.text;
                });
            }
        });
    }

    @override
    void initState() {
        this.getListProvinsiAsync();
        super.initState();
    }

    Widget build(BuildContext context) {
        return Scaffold(
            appBar: _buildBar(context),
            body: Container(
                child: _buildListView(),
            ),
            resizeToAvoidBottomPadding: false,
        );
    }

    Widget _buildBar(BuildContext context) {
        return AppBar(
            centerTitle: true,
            title: _appBarTitle,
            leading: IconButton(
                icon: _searchIcon,
                onPressed: () {
                    setState(() {
                        if (this._searchIcon.icon == Icons.search) {
                            this._searchIcon = Icon(Icons.close);
                            this._appBarTitle = TextField(
                                controller: _filter,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    hintText: 'Search...'
                                ),
                            );
                        } else {
                            this._searchIcon = Icon(Icons.search);
                            this._appBarTitle = Text(title);
                            listProvinsi = listNamaProvinsi;
                            _filter.clear();
                        }
                    });
                },

            ),
        );
    }

    Widget _buildListView() {
        if (_searchText.isNotEmpty) {
            List templateListProvinsi = List();
            for (int i = 0; i < listProvinsi.length; i++) {
                if (listProvinsi[i]['Provinsi'].toString().toLowerCase().contains(_searchText.toLowerCase())) {
                    templateListProvinsi.add(listProvinsi[i]);
                }
            }
            listProvinsi = templateListProvinsi;
        }

        if (listNamaProvinsi.isEmpty) {
            return Center(
                child: Text('Load Data'),
            );
        }

        return ListView.builder(
            itemCount: listNamaProvinsi == null ? 0 : listProvinsi.length,
            itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text(listProvinsi[index]['Provinsi'].toString() ?? '-'),
                    onTap: () {
                        //print('value search :' + _searchText);
                        //print('listProvinsi : ' + listProvinsi[index]['Provinsi'].toString());
                    },
                );
            },
        );
    }

    void getListProvinsiAsync() async {
        final response = await dio.get('https://api.kawalcorona.com/indonesia/provinsi/');

        List templateListProvinsi = List();
        for (int i = 0; i < response.data.length; i++) {
            templateListProvinsi.add(response.data[i]['attributes']);
        }

        setState(() {
            listNamaProvinsi = templateListProvinsi;
            listProvinsi = listNamaProvinsi;
        });
    }
}