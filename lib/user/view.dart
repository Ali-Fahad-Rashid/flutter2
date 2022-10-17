import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market/comp/details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class View extends StatefulWidget {
  View({Key? key}) : super(key: key);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> with TickerProviderStateMixin {
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  @override
  Widget build(BuildContext context) {
    return
      ListView(
        children: [
          SizedBox(height: 20),
          Center(child: TweenAnimationBuilder(
           tween: Tween<double>(begin: 0, end: 1),
             duration: Duration(seconds: 3),
              child: Text(AppLocalizations.of(context)!.buying,
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 5,
                    //  backgroundColor: Colors.yellow,
                    shadows: [
                      Shadow(color: Colors.blueAccent, offset: Offset(2,1), blurRadius:10)
                    ]
                            ),
                          ),
                  builder: (BuildContext context, double _val, child) {
                        return Opacity(
                        opacity: _val,
                        child: child,
                        );
                        }
                              ),
                        ),
          SizedBox(height: 10),
          StreamBuilder(
          stream: posts.snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
    if (snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height -200,
              child: ListView.builder(
                itemCount: snapshot.data.docs.length,
               itemBuilder: (context, i) {
                  return ListNotes(
                    car: snapshot.data.docs[i],
                  );
                },
              ),
            );}
            return Center(child: CircularProgressIndicator());
          },
    ),
        ],
      );
  }
}

class ListNotes extends StatelessWidget {
  final car;
  ListNotes({this.car});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Details(car: car);
        }));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),),
        child: Column(
   //     mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(car['imageurl'],
        ),
            SizedBox(height: 10),
            Container( height: 60,

              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 100),
                      Text(car['company'],
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 8,
                            //  backgroundColor: Colors.yellow,
                            shadows: [
                              Shadow(color: Colors.blueAccent, offset: Offset(2,1), blurRadius:10)
                            ]
                        ),
                      ),
                  SizedBox(width: 30),
                  Text(car['name'],
                    style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 35,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 8,
                        wordSpacing: 20,
                        //  backgroundColor: Colors.yellow,
                        shadows: [
                          Shadow(color: Colors.blueAccent, offset: Offset(2,1), blurRadius:10)
                        ]
                    ),
                  ),
                ],
              ),
              ],),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //   Text(car["user"]),
                Text(car["model"],
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 8,
                      wordSpacing: 20,
                      //  backgroundColor: Colors.yellow,
                      shadows: [
                        Shadow(color: Colors.blueAccent, offset: Offset(2,1), blurRadius:10)
                      ]
                  ),
                ),
                SizedBox(width: 30),
                Text(car["price"]+"\$",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 8,
                      wordSpacing: 20,
                      //  backgroundColor: Colors.yellow,
                      shadows: [
                        Shadow(color: Colors.blueAccent, offset: Offset(2,1), blurRadius:10)
                      ]
                  ),
                ),
              ],
            ),
            Divider(
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            ),
          ],
        ),
      ),
    );
  }
}
