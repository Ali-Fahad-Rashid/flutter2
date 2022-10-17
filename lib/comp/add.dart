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
import 'package:market/market_provider/Market_Provider.dart';
import 'package:market/widget/notification.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Add extends StatefulWidget {
  Add({Key? key}) : super(key: key);
  @override
  _AddState createState() => _AddState();
}
class _AddState extends State<Add> with SingleTickerProviderStateMixin {
  bool uploading = true;
  double val = 0;
  late firebase_storage.Reference ref;
  List<File> _image = [];
  final picker = ImagePicker();
  late var pickedFile;
List ur = [];
  CollectionReference notesref = FirebaseFirestore.instance.collection("posts");
  //late Reference ref;
  late File file;
  var name, company, price,description,picked,search;
  var notifi = new Notifi();

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
        search = name!.toLowerCase().split(" ");
        search += company!.toLowerCase().split(" ");
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
        "date":DateTime.now(),
      }).then((value) {
      Navigator.of(context).pushNamed("homepage");
      }).catchError((e) {
        print("$e");
      });
    }
    notifi.sendnoty(FirebaseAuth.instance.currentUser!.email,name,"admin");

  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<double> _curve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset(1.5, 0.0),
    end:  Offset(0.0, 0.0),
  ).animate(_curve);


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }


  @override
  void initState() {
    _controller.forward();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Market_Provider>(context);

    return
          ListView(
        children: [
          SizedBox(height: 20),

          Container(
            decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.white12, offset: new Offset(1.0, 1.0),),
            ],
          ),
            child: Center(child: FadeTransition(
              opacity: _curve,

              child: SlideTransition(
                  position: _offsetAnimation,

                child: Text(AppLocalizations.of(context)!.sell,
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
                     // filled: true,
                      //fillColor: Colors.white,
                      labelText: AppLocalizations.of(context)!.car,
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
                    //  filled: true,
                    //  fillColor: Colors.white,
                      labelText: AppLocalizations.of(context)!.company,
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
               //       filled: true,
                 //     fillColor: Colors.white,
                      labelText: AppLocalizations.of(context)!.description,
                      prefixIcon: Icon(Icons.description)),
                ),
                TextFormField(
                  onSaved: (val) {
                    price = val;
                  },
                  validator: (val) {
                    if (val!.length > 3) {
                      return "price can't to be larger than 100 letter";
                    }
                    if (val.length < 1) {
                      return "price can't to be less than 4 letter";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                 //     fillColor: Colors.white,
                //      filled: true,

                      prefixIcon: Text("    \$",
                        style: TextStyle(height: 2,
                           fontSize: 20,
                          color: provider.value ? Colors.white : Colors.black,

                        ),
                      ),
                      labelText: AppLocalizations.of(context)!.price,
                  ),
                ),

                    SizedBox(height: 10,),
                    Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                    borderRadius: BorderRadius.circular(50.0),

                    ),
                      child: DropdownButton<String>(
                      value: dropdownValue,
                      icon:  Icon(Icons.arrow_back,
                        color: provider.value ? Colors.black : Colors.white,

                      ),
                      iconSize: 25,
                   //   elevation: 16,
                      style:  TextStyle(color: Colors.white,
                        backgroundColor: Colors.white,
                      ),
                        dropdownColor: Colors.blue,

                          underline: Container(
                          height: 1,
                          color: Colors.blue,
                          ),
            /*                       hint:Text(
                          "Please choose a langauage",
                          style: TextStyle(backgroundColor: Colors.yellow,
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),*/

                      onChanged: (String? newValue) {
                      setState(() {
                      dropdownValue = newValue!;
                      });
                      },
                      items: <String>['2021', '2020', '2019', '2018',"2017","2016","old"]
                          .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                      value: value,
                      child: Center(child: Text("               "+value+"             ",
                          style: TextStyle(
                              backgroundColor: Colors.blue,
                              color: provider.value ? Colors.black : Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                          ))),
                      );
                      }).toList(),
                      ),
                    ),
                // ignore: deprecated_member_use
                Container(
                  margin: EdgeInsets.all(7),
                  child: FloatingActionButton.extended(backgroundColor: Colors.blue,
                    onPressed: () {
                      showBottomSheet2(context);
                    },
                    label:  Text(AppLocalizations.of(context)!.primary),
                    icon:     Icon(
                      Icons.camera_alt_rounded,
                      size: 20.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0,0,0,7),
                  child: FloatingActionButton.extended(backgroundColor: Colors.blue,
                    onPressed: () {
                      showBottomSheet(context);
                    },
                    icon:     Icon(
                      Icons.image,
                      size: 20.0,
                    ),
                    label:  Text(" "+AppLocalizations.of(context)!.other+"   "),

                  ),
                ),


                  ElevatedButton(
                    onPressed: () async {
                      await addNotes(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.submit,
                      style:TextStyle(fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,)
                    ),
                    style: ElevatedButton.styleFrom(
                    onPrimary: Colors.blue,
                    primary: Colors.white,
                    shadowColor: Colors.red,
                    side: BorderSide(color: Colors.blue, width: 1),
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 70
                    ),
                    onSurface: Colors.grey,
                    ),
                    ),
                SizedBox(height: 10,),


              ]))
        ],

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
