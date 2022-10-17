



import 'package:flutter/material.dart';
import 'package:market/market_provider/Market_Provider.dart';
import 'package:provider/provider.dart';

class Carou extends StatelessWidget {
  final List dataa;
  Carou({required this.dataa});
  @override
  Widget build(BuildContext context) {
    var co= Provider.of<Market_Provider>(context);
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: dataa.map((url) {
          int index = dataa.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: co.currentPos == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      );
  }
}

