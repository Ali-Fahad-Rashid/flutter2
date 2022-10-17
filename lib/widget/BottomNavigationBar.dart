import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:market/market_provider/Market_Provider.dart';
import 'package:provider/provider.dart';


class BootomNav extends StatelessWidget {
  const BootomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Market_Provider>(context);

    return BottomNavigationBar(
      //  backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:Icon(
              Icons.home,
              color: Colors.pink,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            backgroundColor: Colors.white,
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.cars,
            icon:Icon(
              Icons.directions_car_outlined,
              color: Colors.pink,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.add,
            icon:     Icon(
              Icons.add,
              color: Colors.pink,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: provider.selectedIndex,
        selectedItemColor: Colors.cyan,
        onTap: (int index) {provider.onItemTapped(index);}
    );
  }
}
