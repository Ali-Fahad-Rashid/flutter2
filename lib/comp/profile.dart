import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:market/comp/details.dart';
import 'package:market/inc/alert.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'edit.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Colors.grey[100],
      appBar: AppBar(actions: [
        IconButton(
        icon: const Icon(Icons.search),
      //  color: Colors.white,
        onPressed: () {
          Navigator.of(context).pushNamed("Search");
        },
      ),
      ],

        title: Center(child: Text(AppLocalizations.of(context)!.cars)),
       // backgroundColor: Colors.grey[700],

      ),

      body:StreamBuilder(
        stream: posts.where("userid",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {


            return
            (snapshot.data.docs.length<=0) ?
            Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,

                child: Text("You Dont Have Any Car",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.green,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 4,
                      //  backgroundColor: Colors.yellow,
                      shadows: [
                        Shadow(color: Colors.purple, offset: Offset(2,2), blurRadius:7)
                      ]
                  ),
                ),
              ),
            )
            :

             ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, i) {
                return
                  Dismissible(
                  movementDuration: Duration(seconds: 3),
                  dismissThresholds: {
                    DismissDirection.startToEnd: 0.1,
                    DismissDirection.endToStart: 0.1
                  },
                    key: UniqueKey(),
                  onDismissed: (diretion) async {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.INFO,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Are You Sure',
                      desc: 'Are You Sure',
                      btnCancelOnPress: () {
                        Navigator.of(context).pushReplacementNamed('Profile');
                      },
                      btnOkOnPress: () async{
                        await posts
                            .doc(snapshot.data.docs[i].id)
                            .delete();
                        await FirebaseStorage.instance
                            .refFromURL(snapshot.data.docs[i]['imageurl'])
                            .delete()
                            .then((value) {
                        }
                        );
                      },
                    )..show();
                  },
                  background: Container(
                    color: Colors.pink[300],
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: AlignmentDirectional.centerStart,
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,size: 100,
                          color: Colors.white,
                        ),
                        Text('Move to trash', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.pink[300],
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: AlignmentDirectional.centerEnd,
                    child: Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Move to trash', style: TextStyle(color: Colors.white)),
                        Icon(
                          Icons.delete,size: 100,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  child: ListNotes(
                    car: snapshot.data.docs[i],
                    docid: snapshot.data.docs[i].id,
                  ),
                );
              },
            );
          }


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
            Image.network(car['imageurl'],width: 400,height: 250,fit: BoxFit.cover,),
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

                IconButton(
                  alignment: Alignment.topRight,color: Colors.purple,hoverColor: Colors.red,
                  focusColor: Colors.red,mouseCursor: SystemMouseCursors.text,
                  padding: EdgeInsets.all(10),
                  splashColor: Colors.red,splashRadius: 12,tooltip: 'Edit',
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Edit(docid: docid, car: car);
                    }));
                  },
                  icon: Icon(Icons.edit),
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
