
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardDashboard extends StatelessWidget {
    final String textJudul;
    final String textTotal; 
    final String textTanggal; 
    final String gambarIcon; 
    final List<Color> listColors;
    final bool isHasLoad;

    CardDashboard({
        this.textJudul,
        this.textTotal = '0',
        this.textTanggal,
        this.gambarIcon,
        this.listColors,
        this.isHasLoad = true,
    });

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.only(bottom: 3),
            height: 110,
            width: MediaQuery.of(context).size.width * 1,
            child: Card(
                semanticContainer: true,
                elevation: 10,
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/indonesia.png",
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
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: this.listColors
                        )
                    ),
                    padding: EdgeInsets.all(10),
                    child: Row(
                        children: <Widget>[
                            Expanded(
                                flex: 2,
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Text(
                                                this.textJudul,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'PTSans'
                                                ),
                                            ),
                                            SizedBox(height: 5),
                                            // Show Data
                                            RichText(
                                                text: TextSpan(
                                                    text: this.textTotal.toString(),
                                                    style: TextStyle(
                                                        fontSize: 32,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black,
                                                        fontFamily: 'PTSans'
                                                    ),
                                                    children: [
                                                        TextSpan(
                                                            text: ' - Orang',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.normal,
                                                                color: Colors.black,
                                                                fontFamily: 'PTSans'
                                                            ),
                                                        ),
                                                    ]
                                                ),
                                            ),
                                            SizedBox(height: 5),
                                            // Row(
                                            //     mainAxisAlignment: MainAxisAlignment.center,
                                            //     crossAxisAlignment: CrossAxisAlignment.start,
                                            //     children: <Widget>[
                                            //         Icon(
                                            //             FontAwesomeIcons.calendarAlt,
                                            //             size: 13,
                                            //         ),
                                            //         SizedBox(width: 5),
                                            //         Expanded(
                                            //             child: Text(
                                            //                 this.textTanggal,
                                            //                 style: TextStyle(
                                            //                     fontSize: 13
                                            //                 ),
                                            //             ),
                                            //         )
                                            //     ],
                                            // )
                                        ],
                                    ),
                                ),
                            ),
                            Expanded(
                                flex: 1,
                                child: isHasLoad == true ? Container(
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.asset(
                                            gambarIcon,
                                            height: 55,
                                            width: 55,
                                        ),
                                    ),
                                    margin: EdgeInsets.only(bottom: 10),
                                    //color: Colors.red,
                                ) : Container(
                                    padding: EdgeInsets.fromLTRB(35, 20, 35, 20),
                                    child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black)
                                    ),
                                )
                            ),
                        ],
                    ),
                ),
            ) 
        );
    }
}