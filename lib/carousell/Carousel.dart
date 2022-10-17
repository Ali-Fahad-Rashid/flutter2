



import 'package:flutter/material.dart';
import 'package:market/market_provider/Market_Provider.dart';
import 'package:provider/provider.dart';

class Carousel extends StatelessWidget {
  final  controller;
  final List dataa;
  Carousel({required this.dataa, this.controller});

  @override
  Widget build(BuildContext context) {
    var co= Provider.of<Market_Provider>(context);
    return
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.red,
                primary:  co.value ? Colors.black87 : Colors.white,
              ),
              onPressed: () => controller.previousPage(),
              child: Icon(Icons.arrow_back),
            ),
          ),

          ...Iterable<int>.generate(dataa.length).map(
                (int pageIndex) => Flexible(
              child: InkWell(
                onTap: () => controller.animateToPage(pageIndex),
                child: co.currentPos == pageIndex ? Image.network(dataa[pageIndex]["imageurl"],
                  height:30,fit:BoxFit.fill,width: 100,

                ) : Image.network(dataa[pageIndex]["imageurl"],
                  height:30,fit:BoxFit.fill,width: 100,
                  color: Colors.grey,
                  colorBlendMode: BlendMode.lighten,),
              ),
            ),
          ),

          Flexible(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.red,
                primary:  co.value ? Colors.black54 : Colors.white,

              ),
              onPressed: () => controller.nextPage(),
              child: Icon(Icons.arrow_forward),
            ),
          ),

        ],
      );

  }
}
