import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market/comp/details.dart';
class Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.all(10),
      height: 400,
      child: GridView.count(
        primary: true,
        padding:  EdgeInsets.all(5),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 1,
        children: <Widget>[

          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').orderBy('date').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');        }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());        }
              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, i) {

                    return
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return Details(car: snapshot.data.docs[i]);
                          }));
                        },
                        child: Container(
                      //    padding:  EdgeInsets.all(8),
                          margin:EdgeInsets.all(5),

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child:Image.network(
                              snapshot.data.docs[i]['imageurl'],
                              width: 500,
                              height: 500,
                              fit: BoxFit.fill,
                            ),
                          ),
                          decoration: BoxDecoration(border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                            borderRadius: BorderRadius.circular(25),),
                        ),
                      );

                    },);}
              return Center(child: CircularProgressIndicator());     },      ),


        ],
      ),
    );
  }
}