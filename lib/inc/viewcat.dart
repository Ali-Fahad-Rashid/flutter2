import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:market/comp/details.dart';


class Viewcat extends StatefulWidget {
  final car;
  Viewcat({Key? key,this.car}) : super(key: key);

  @override
  _ViewcatState createState() => _ViewcatState();
}

class _ViewcatState extends State<Viewcat> {
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(actions: [ IconButton(
        icon: Icon(Icons.search),
        color: Colors.white,
        onPressed: () {
          Navigator.of(context).pushNamed("Search");
        },
      ),
      ],
        leading: IconButton(
          icon:  Icon(Icons.arrow_back),
          tooltip: 'Go Back',
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('homepage');

          },
        ),
        title: Center(child: Text('Profile')),
        backgroundColor: Colors.grey[700],

      ),

      body:FutureBuilder(
        future: posts.where("company",
            isEqualTo: widget.car)
            .get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, i) {
                return ListNotes(
                  car: snapshot.data.docs[i],
                  docid: snapshot.data.docs[i].id,
                );


              },
            );}
          return Center(child: CircularProgressIndicator());


        },
      ),
    );
  }
}

class ListNotes extends StatelessWidget {
  final car;
  final docid;

  ListNotes({this.car,this.docid});
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
          children: <Widget>[
            Image.network(car['imageurl'],width: 400,height: 250,fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Container(        height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //SizedBox(width: 100),
                  Container(height:350,
                    width: 350,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: 80),

                        Align(
                          alignment: Alignment.topRight,

                          child: Text(car['company'],
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
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(car["model"],
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 8,
                      wordSpacing: 20,
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
                      //  backgroundColor: Colors.yellow,
                      shadows: [
                        Shadow(color: Colors.blueAccent, offset: Offset(2,1), blurRadius:10)
                      ]
                  ),
                ),
                SizedBox(width: 30),

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
