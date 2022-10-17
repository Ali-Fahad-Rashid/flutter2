import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market/inc/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
class Add_post extends StatefulWidget {
  Add_post({Key? key}) : super(key: key);

  @override
  _Add_postState createState() => _Add_postState();
}
class _Add_postState extends State<Add_post> {
  bool uploading = true;
  double val = 0;
  late firebase_storage.Reference ref;
  List<File> _image = [];
  final picker = ImagePicker();
  late var pickedFile;
  List ur = [];
  CollectionReference notesref = FirebaseFirestore.instance.collection("admin");
  late File file;
  var name, company, price,description,picked,search;
  var imageurl="https://www.affordableautoselgin.com/images/no-photo-car.jpg";
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  String dropdownValue = '2021';
  addNotes(context) async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      showLoading(context);
      formdata.save();
      uploading = true;
      int i = 1;
      for (var img in _image) {
        setState(() {
          val = i / _image.length;
        });
        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('images/${Path.basename(img.path)}');
        await ref.putFile(img).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            ur.add(value);
            i++;
          });
        });
      }
      if (picked != null) {
        await ref.putFile(file);
       imageurl = await ref.getDownloadURL();}
      setState(() {
        search = name!.split(" ");
        search += company!.split(" ");
      });
      await notesref.add({
        "name": name,
        "company": company,
        "price":price,
        "description":description,
        "model": dropdownValue ,
        "imageurl": imageurl,
        "userid": FirebaseAuth.instance.currentUser!.uid,
        "user": FirebaseAuth.instance.currentUser!.email,
        "search":search,
        "ur":ur,
      }).then((value) {

        Navigator.of(context).pushNamed("homepage");
      }).catchError((e) {
        print("$e");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(actions: [ IconButton(
        icon: const Icon(Icons.search),
    color: Colors.white,
    onPressed: () {
    Navigator.of(context).pushNamed("Search");


    },
    ),],
    title: Center(child: Text('Admin')),
    backgroundColor: Colors.black,
    ),
     body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.white12, offset: new Offset(1.0, 1.0),),
              ],
            ),
            child: Center(heightFactor: 2,child: Text('Admin Board',
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
          SizedBox(height: 10),
          Form(
              key: formstate,
              child: Column(children: [
                TextFormField(
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
                  maxLength: 3,

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
                  value: dropdownValue,
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
                      showBottomSheet2(context);
                    },
                    label:  Text('Primary Images'),
                    icon:     Icon(
                      Icons.camera_alt_rounded,
                      size: 40.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      showBottomSheet(context);
                    },
                    label:  Text('Other Images'),
                    icon:     Icon(
                      Icons.camera_alt_rounded,
                      size: 40.0,
                    ),
                  ),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () async {
                    await addNotes(context);
                  },
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  child: Text(
                    "Submit",
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
          return Stack(
            children: [

              Container(
                padding: EdgeInsets.all(4),
                child: GridView.builder(
                    itemCount: _image.length + 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Center(
                        child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () async {
                              if(uploading) {
                                pickedFile = await picker.getImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  _image.add(File(pickedFile!.path));
                                });

                                if (pickedFile!.path == null) {
                                  final LostData response = await picker
                                      .getLostData();
                                  if (response.isEmpty) {
                                    return;
                                  }
                                  if (response.file != null) {
                                    setState(() {
                                      _image.add(File(response.file!.path));
                                    });
                                  } else {
                                    print(response.file);
                                  }



                                }
                                Navigator.of(context).pop();
                                showBottomSheet(context);

                              } else {}
                            }
                        ),
                      )
                          : Container(
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(_image[index - 1]),
                                fit: BoxFit.cover)),
                      );
                    }),
              ),

            ],
          );
        });
  }







  showBottomSheet2(context) {
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
                      var imagename = "$rand" + Path.basename(picked.path);
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
                      var imagename = "$rand" + Path.basename(picked.path);
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
