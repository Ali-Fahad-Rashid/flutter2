import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market/comp/details.dart';
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}
class _SearchState extends State<Search> {
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val.toLowerCase();
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // ignore: unnecessary_null_comparison
        stream: (name != "" && name != null) ?
        FirebaseFirestore.instance.collection('posts')
            .where("search", arrayContains: name)
            .snapshots()
            : FirebaseFirestore.instance.collection("posts")
            .where("search", isEqualTo:  name)
            .snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data!.docs[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return Details(car: snapshot.data!.docs[index]);
                  }));
                },
                child: Card(
                  child: Row(
                    children: <Widget>[
                      Image.network(
                        data['imageurl'],
                        width: 150,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        data['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

}