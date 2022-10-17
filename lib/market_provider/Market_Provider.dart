import 'package:flutter/material.dart';
import 'package:market/l10n/l10n.dart';
import 'package:market/widget/Function.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: camel_case_types
class Market_Provider with ChangeNotifier {

  bool value=false;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    value = preferences.getBool("value") ?? false;
  }



  setPref(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("value", value);
  }

   Light(newValue) {
    value = newValue;
    setPref(newValue);
    notifyListeners();
   }


  int selectedIndex = 0;
  onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }


int currentPos=0;
  counter (index) {
    currentPos = index;
    notifyListeners();
  }
   Locale? _locale;
  Locale? get locale => _locale;
  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }
  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
/*
int c=0;
cc(){
  c++;
  notifyListeners();
}
*/
//inside build
//var co= Provider.of<Market_Provider>(context,listen: false);
/*FloatingActionButton(
onPressed: (){
co.counter();
//  setState(() {
//   c++;
//  });
},
child:pc(),
)*/
/*
class pc extends StatelessWidget {
  const pc({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var co= Provider.of<Market_Provider>(context);
    return Text("c= ${co.c}");
  }
}
*/
/*
Consumer<Market_Provider>(builder:(context,prov,child) {
return  FloatingActionButton(
onPressed: (){
prov.cc();      },
);
},
),
Consumer<Market_Provider>(builder:(context,prov,child) {
return Text('c=${prov.c}');
},),*/
