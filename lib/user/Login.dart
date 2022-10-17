import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market/inc/alert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}



class _LoginState extends State<Login> {
  var mypassword, myemail;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  signIn() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: myemail, password: mypassword);
        return userCredential;

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.INFO,
            body: Center(child: Text(
              'User Not Found',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),),
            title: 'This is Ignored',
            desc:   'This is also Ignored',
            btnOkOnPress: () {
            },
          )..show();
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.INFO,
            body: Center(child: Text(
              'wrong Password',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),),
            title: 'This is Ignored',
            desc:   'This is also Ignored',
            btnOkOnPress: () {
            },
          )..show();
        }
      }
    } else {
      print("Not Vaild");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
                key: formstate,
                child: Column(
                  children: [
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
                            Text(AppLocalizations.of(context)!.haven),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed("signup");
                              },
                              child: Text(AppLocalizations.of(context)!.click,
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        )),
                    Container(
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          textColor: Colors.white,
                          onPressed: () async {
                            var user = await signIn();
                            if (user != null) {
                              User? user = FirebaseAuth.instance.currentUser;

                              Navigator.of(context)
                                  .pushReplacementNamed("homepage");}

                          },
                          child: Text(AppLocalizations.of(context)!.signin
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

/*
showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please Wait"),
          content: Container(
              height: 50,
              child: Center(
                child: CircularProgressIndicator(),
              )),
        );
      });
}
*/