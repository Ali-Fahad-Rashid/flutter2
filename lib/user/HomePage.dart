import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:market/comp/add.dart';
import 'package:market/market_provider/Market_Provider.dart';
import 'package:market/user/view.dart';
import 'package:market/widget/BottomNavigationBar.dart';
import 'package:market/widget/Drawer.dart';
import 'package:market/widget/Switch.dart';
import 'package:market/widget/notification.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  //var notifi = new Notifi();
  static  List<Widget> _widgetOptions = <Widget>[
    Home(),
    View(),
    Add(),
  ];
  late final AnimationController _controller = AnimationController(
    duration:  Duration(seconds:2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<TextStyle> _styleTween = TextStyleTween(
    begin:  TextStyle(
        fontSize: 35, color: Colors.amber, fontWeight: FontWeight.w700),
    end:  TextStyle(
        fontSize: 25, color: Colors.yellow, fontWeight: FontWeight.w400),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticInOut,
  )
  );

  asd() async {
    var xxx = await FirebaseMessaging.instance.getToken();
    print('===========================================================');
    print(xxx);

  }

  @override
 initState()  {
    asd();
    var notifi = new Notifi();
    notifi.sendnoty(FirebaseAuth.instance.currentUser!.email,'name',"admin");
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
int c =0 ;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Market_Provider>(context);
   // print("ccccccccccccccccccccccccc ${c++}");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
              LightMode(),
        IconButton(
        icon:  Icon(Icons.search),
        onPressed: () {
          Navigator.of(context).pushNamed("Search");
        },
      ),
      ],
        title: Center(child: DefaultTextStyleTransition(
          style: _styleTween,
            child: Text(AppLocalizations.of(context)!.market),
        )
        ),
       // backgroundColor: Colors.black,
      ),
      drawer: MyDrawer(),
      body: _widgetOptions.elementAt(provider.selectedIndex),
      bottomNavigationBar: BootomNav(),
    );
  }
  }