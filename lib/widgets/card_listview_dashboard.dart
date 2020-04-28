import 'package:flutter/material.dart';

class CardListViewDashboard extends StatelessWidget {
    final String textJudul;
    final String textTotal; 
    final Icon icon; 
    final List<Color> listColors;
    final bool isHasLoad;

    CardListViewDashboard({
        this.textJudul = 'data',
        this.textTotal,
        this.icon,
        this.listColors,
        this.isHasLoad = false
    });

    @override
    Widget build(BuildContext context) {
      return Container(
            margin: EdgeInsets.only(right: 3),
            child: Card(
                child: Container(
                    decoration: BoxDecoration(
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
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: this.listColors
                        )
                    ),
                    width: 200,
                    child: isHasLoad == true ? Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                // this.icon,
                                // SizedBox(height: 10),
                                Text(
                                    this.textJudul,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500
                                    ),
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: this.textTotal,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                        ),
                                        children: [
                                            TextSpan(
                                                text: ' - Orang',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.black
                                                ),
                                            ),
                                        ]
                                    ),
                                ),
                            ],
                        ),
                    ) : Container(
                        margin: EdgeInsets.fromLTRB(82, 18, 82, 18),
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.black)
                        ),
                    )
                )
            ),
        );
    }
}