import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:market/inc/alert.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var myusername, mypassword, myemail;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  signUp() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();

      try {
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: myemail, password: mypassword);
        return userCredential;

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.INFO,
            body: Center(child: Text(
              'Weak Password',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),),
            title: 'This is Ignored',
            desc:   'This is also Ignored',
            btnOkOnPress: () {
            },
          )..show();

        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();

          AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.INFO,
            body: Center(child: Text(
              'Email Exist',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),),
            title: 'This is Ignored',
            desc:   'This is also Ignored',
            btnOkOnPress: () {
            },
          )..show();
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 150),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (val) {
                        myusername = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "username can't to be larger than 100 letter";
                        }
                        if (val.length < 2) {
                          return "username can't to be less than 2 letter";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: AppLocalizations.of(context)!.username,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onSaved: (val) {
                        myemail = val;
                      },
                      validator: (val) {
                        if (val!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val)) {
                          return 'Enter a valid email!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: AppLocalizations.of(context)!.email,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onSaved: (val) {
                        mypassword = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "Password can't to be larger than 100 letter";
                        }
                        if (val.length < 4) {
                          return "Password can't to be less than 4 letter";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: AppLocalizations.of(context)!.password,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(AppLocalizations.of(context)!.have),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed("login");
                              },
                              child: Text(AppLocalizations.of(context)!.click
                                ,
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        )),
                    Container(
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          textColor: Colors.white,
                          onPressed: () async{
                            UserCredential user = await signUp();
                          //  print(user);
                            if (user != null) {
                            await FirebaseFirestore.instance
                                .collection("users")
                                .add({"username": myusername, "email": myemail,"role":"user","id":FirebaseAuth.instance.currentUser!.uid});

                            User? user = FirebaseAuth.instance.currentUser;

                            }

                            },

                          child: Text(AppLocalizations.of(context)!.signup
                            ,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ))
                  ],
                )),
          )
        ],
      ),
    );
  }
}