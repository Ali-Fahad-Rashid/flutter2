import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:market/carousell/Carou.dart';
import 'package:market/carousell/Carousel.dart';
import 'package:market/carousell/Carousell.dart';
import 'package:market/inc/cat.dart';
import 'package:market/inc/grid.dart';
import 'footer.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  CarouselController _controller = CarouselController();
int v=0,c=0;
  final List dataa = [];
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  @override
  void initState() {
    posts.limit(5)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        dataa.add(doc);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  // print("v=${v++}");
    return
      ListView(
        children: <Widget>[
          SizedBox(height: 1),
          Carousell(dataa:dataa,controller:_controller),
          Carou(dataa:dataa),
          Carousel(dataa:dataa,controller:_controller),
          Center(
            child: Container(
              padding: EdgeInsets.all(5),
              margin:EdgeInsets.fromLTRB(0,20,0,0),
              child: Text(AppLocalizations.of(context)!.newest,
                style: TextStyle(fontSize: 20, ),
              ),
            ),
          ),
          Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
          Grid(),
          Center(
            child: Container(
              padding: EdgeInsets.all(5),
              margin:EdgeInsets.fromLTRB(0,10,0,0),
              child: Text(AppLocalizations.of(context)!.type,

                style: TextStyle(fontSize: 20,),
              ),
            ),
          ),
          Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(
            height:50,
          ),

          Cat(),
          SizedBox(
            height:50,
          ),
          Footer2(),
        ],
      );
}}