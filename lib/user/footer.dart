import 'package:flutter/material.dart';
import 'package:market/market_provider/Market_Provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
class Footer2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Market_Provider>(context);

    return
      Container(height: 100,
            child: new Padding(
              padding: EdgeInsets.all(5.0),
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:<Widget>[
                    new Center(
                      child:new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Container(
                              height: 45.0,
                              width: 45.0,
                              child: Center(
                                child:Card(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
                                  ),
                                  child: IconButton(
                                    icon: new Icon(Icons.play_circle_fill,size: 20.0,),
                                   // color: Color(0xFF162A49),
                                    onPressed: () {launch('https://www.youtube.com/channel/UCNTtqJtJ7Dvp8pLfYy3lo7A');},
                                  ),
                                ),
                              )
                          ),
                          new Container(
                              height: 45.0,
                              width: 45.0,
                              child: Center(
                                child:Card(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
                                  ),
                                  child: IconButton(
                                    icon: new Icon(Icons.mail,size: 20.0,),
                                 //   color: Color(0xFF162A49),
                                    onPressed: () {
                                      String? encodeQueryParameters(Map<String, String> params) {
                                        return params.entries
                                            .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                            .join('&');
                                      }

                                      final Uri emailLaunchUri = Uri(
                                        scheme: 'mailto',
                                        path: 'chrisalialmla@gmail.com',
                                        query: encodeQueryParameters(<String, String>{
                                          'subject': 'Subject'
                                        }),
                                      );

                                      launch(emailLaunchUri.toString());
                                    },
                                  ),
                                ),
                              )
                          ),
                          new Container(
                              height: 45.0,
                              width: 45.0,
                              child: Center(
                                child:Card(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
                                  ),
                                  child: IconButton(
                                    icon: new Icon(Icons.facebook,size: 20.0,),
                                //    color: Color(0xFF162A49),
                                    onPressed: (){ launch('https://www.facebook.com/ProgrammingInstitution');}
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                    Text('Copyright ©2021, All Rights Reserved.',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0,
                      color:  provider.value ? Colors.grey : Colors.black,),),
                    Text('Powered by Ali Fahad',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0,
                        color:  provider.value ? Colors.grey : Colors.black,),),
                  ]
              ),
            ),


    );
  }
}

