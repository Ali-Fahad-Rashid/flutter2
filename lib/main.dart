import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:market/admin/add_post.dart';
import 'package:market/inc/Verified.dart';
import 'package:market/inc/search.dart';
import 'package:market/inc/viewcat.dart';
import 'package:market/l10n/l10n.dart';
import 'package:market/user/HomePage.dart';
import 'package:market/user/Login.dart';
import 'package:market/user/SignUp.dart';
import 'package:market/user/home.dart';
import 'package:provider/provider.dart';
import 'comp/add.dart';
import 'comp/details.dart';
import 'comp/profile.dart';
import 'inc/setting.dart';
import 'inc/test.dart';
import 'package:market/market_provider/Market_Provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
bool islogin=true;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider<Market_Provider>(
      create: (context) => Market_Provider(),
      child:App()
  ),);
}
class App extends StatelessWidget {

  int k=0;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Market_Provider>(context);
    //print("kkkkkkkkk ${k++}");

    return  MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter',
        theme: ThemeData(
          brightness: provider.value ? Brightness.dark : Brightness.light,
            fontFamily: 'ElMessiri',
          primaryColor: provider.value ? Colors.black : Colors.black,

        ),
      locale: provider.locale,
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
        routes: {
          "login": (context) => Login(),
          "signup": (context) => SignUp(),
          "homepage": (context) => HomePage(),
          "home": (context) => Home(),
          "setting": (context) => LocalizationAppPage(),
          "add": (context) => Add(),
          "test": (context) => MyLoginPage(),
          "Details": (context) => Details(),
          "Profile": (context) => Profile(),
          "Viewcat": (context) => Viewcat(),
          "Search": (context) => Search(),
          "Add_post": (context) => Add_post(),
          "Verified": (context) => Verified(),

        },
        home:FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
      if (snapshot.hasError) {
        print ('error ${snapshot.error.toString()}');
        return Text('error');
      }
      else if (snapshot.hasData) {




        var user = FirebaseAuth.instance.currentUser;
        print(user);

        if (user == null ) {
          islogin = true;
        } else {
          islogin = false;
        }
      return islogin == false ? HomePage() : Login();
      }
else {
      return CircularProgressIndicator();
      }}
        ),
      );
  }
}
