import 'dart:io';
import 'dart:math';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market/inc/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Edit extends StatefulWidget {
  final docid;
  final car;

  Edit({this.docid,this.car});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("posts");

  late Reference ref;

  late File file;

  var name, company, price,description,picked,search;
  var imageurl="https://www.affordableautoselgin.com/images/no-photo-car.jpg";
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  String dropdownValue = '2021';
  @override
  void initState() {
    dropdownValue=widget.car['model'];
    imageurl=widget.car['imageurl'];

    super.initState();
  }
  edit(context) async {

    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      showLoading(context);

      formdata.save();

      if (picked != null) {
        await ref.putFile(file);
        imageurl = await ref.getDownloadURL();}
      setState(() {
        search = name!.split(" ");
        search += company!.split(" ");

      });
      await notesref.doc(widget.docid).update({
        "name": name,
        "company": company,

        "price":price,
        "description":description,
        "model": dropdownValue ,
        "imageurl": imageurl,
        "userid": FirebaseAuth.instance.currentUser!.uid,
        "user": FirebaseAuth.instance.currentUser!.email

      }).then((value) {
        Navigator.of(context).pushNamed("homepage");
      }).catchError((e) {
        print("$e");
      });
    }
  }

  @override
  Widget build(BuildContext context) {

        return Scaffold(
        backgroundColor: Colors.grey[100],

        appBar: AppBar(

    title: Center(child: Text('Profile')),
    backgroundColor: Colors.grey[700],

    ),

     body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.white12, offset: new Offset(1.0, 1.0),),
              ],
            ),
            child: Center(heightFactor: 2,child: Text('Edit Car ',
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
            )),
          ),
                  Image.network(widget.car['imageurl']),

    SizedBox(height: 10),

          Form(
              key: formstate,
              child: Column(children: [
                TextFormField(
                  initialValue: widget.car['name'],

                  validator: (val) {
                    if (val!.length > 30) {
                      return "car name can't to be larger than 30 letter";
                    }
                    if (val.length < 2) {
                      return "car name can't to be less than 2 letter";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    name = val;
                  },
                  maxLength: 30,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Car Name",
                      prefixIcon: Icon(Icons.drive_file_rename_outline)),
                ),
                TextFormField(
                  initialValue: widget.car['company'],

                  validator: (val) {
                    if (val!.length > 255) {
                      return "company name can't to be larger than 255 letter";
                    }
                    if (val.length < 1) {
                      return "company name can't to be less than 10 letter";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    company = val;
                  },
                  minLines: 1,
                  maxLines: 3,
                  maxLength: 30,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Company Name",
                      prefixIcon: Icon(Icons.car_rental)),
                ),
                TextFormField(
                  initialValue: widget.car['description'],

                  validator: (val) {
                    if (val!.length > 255) {
                      return "description  can't to be larger than 255 letter";
                    }
                    if (val.length < 1) {
                      return "description  can't to be less than 10 letter";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    description = val;
                  },
                  minLines: 1,
                  maxLines: 2,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Description",
                      prefixIcon: Icon(Icons.description)),
                ),
                TextFormField(
                  initialValue: widget.car['price'],

                  onSaved: (val) {
                    price = val;
                  },
                  validator: (val) {
                    if (val!.length > 100) {
                      return "price can't to be larger than 100 letter";
                    }
                    if (val.length < 1) {
                      return "price can't to be less than 4 letter";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,

                    prefixIcon: Text("    \$",
                      style: TextStyle(height: 2,),
                    ),
                    labelText: "Price",

                  ),
                ),
                DropdownButton<String>(

                  value:dropdownValue,
                  icon:  Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style:  TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['2021', '2020', '2019', '2018',"2017","2016","old"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                // ignore: deprecated_member_use
                Container(
                  margin: EdgeInsets.all(20),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      showBottomSheet(context);
                    },
                    label:  Text('Add Images'),
                    icon:     Icon(
                      Icons.camera_alt_rounded,
                      size: 40.0,
                    ),
                  ),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () async {
                    await edit(context);
                  },
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  child: Text(
                    "Edit",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
              ]))
        ],
     ),
      );
  }

  showBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            height: 185,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please Choose Image",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                     picked = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    if (picked != null) {
                      file = File(picked.path);
                      var rand = Random().nextInt(100000);
                      var imagename = "$rand" + basename(picked.path);
                      ref = FirebaseStorage.instance
                          .ref("images")
                          .child("$imagename");
                      Navigator.of(context).pop();


                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo_outlined,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "From Gallery",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () async {
                     picked = await ImagePicker()
                        .getImage(source: ImageSource.camera);
                    if (picked != null) {
                      file = File(picked.path);
                      var rand = Random().nextInt(100000);
                      var imagename = "$rand" + basename(picked.path);
                      ref = FirebaseStorage.instance
                          .ref("images")
                          .child("$imagename");
                      Navigator.of(context).pop();


                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "From Camera",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),
                ),
              ],
            ),
          );
        });
  }
}
