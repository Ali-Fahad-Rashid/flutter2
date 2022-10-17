



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:market/widget/notification.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool admin=false ;
  var user = FirebaseAuth.instance.currentUser!.email;
  CollectionReference use = FirebaseFirestore.instance.collection('users');
  void log() async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed("login");
  }

  @override
  void initState() {
    super.initState();
    use.where("email",isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .where("role",isEqualTo: 'admin')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        //   print(doc["email"]);
        admin=true;
        await FirebaseMessaging.instance.subscribeToTopic('admin');
        // print(admin);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
            child: Center(
              child: FittedBox(
                child: Text(user!,
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.red,
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
            ),
          ),
          // ListTile(leading: Icon(Icons.message),title: Text('Messages'),),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(AppLocalizations.of(context)!.profile
            ),
            onTap: () {
              Navigator.of(context).pushNamed("Profile");
            },
          ),
          (admin == true) ?
          ListTile(
            leading: Icon(Icons.admin_panel_settings),
            title: Text(AppLocalizations.of(context)!.admin
            ),
            onTap: () {
              Navigator.of(context).pushNamed("Add_post");
            },
          )
              : Container() ,

          ListTile(
            leading: Icon(Icons.settings),
            title: Text(AppLocalizations.of(context)!.setting
            ),
            onTap: () {
              Navigator.of(context).pushNamed("setting");
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(AppLocalizations.of(context)!.out),
            onTap: () {
              log();
            },
          ),
           ListTile(
              leading: Icon(Icons.terrain_sharp),
              title: Text('Test'),
              onTap: () {

                var notifi = new Notifi();
                notifi.sendnoty(FirebaseAuth.instance.currentUser!.email,'name',"admin");
                // Navigator.of(context).pushNamed("test");
              },
            ),
            ListTile(
              leading: Icon(Icons.terrain_sharp),
              title: Text('subscribe'),
              onTap: () async{
                await FirebaseMessaging.instance.subscribeToTopic('ali');
              },
            ),
            ListTile(
              leading: Icon(Icons.terrain_sharp),
              title: Text('unsubscribe'),
              onTap: () async{
                await FirebaseMessaging.instance.unsubscribeFromTopic('ali');
              },
            ),
        ],
      ),
    );
  }
}
