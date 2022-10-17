

import 'package:flutter/material.dart';
import 'package:market/comp/details.dart';

class Viewcarousell extends StatelessWidget {
  final item;

  const Viewcarousell({Key? key,this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Details(car: item);
        }));
      },
      child: Container(
        margin:  EdgeInsets.fromLTRB(0,0,5,0),

        child: GridTile(
          child: Container(
            decoration: BoxDecoration(

              image:  DecorationImage(image: NetworkImage(item["imageurl"],),
                fit:BoxFit.cover ,
              ),
              borderRadius: BorderRadius.all(Radius.circular(18.0)),

            ),
          ),
          footer: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18.0)),
                color: Colors.black54,

              ),
              child: Center(
                child: Text(
                  item["name"],
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  //   textAlign: TextAlign.right,
                ),
              )),
        ),
      ),
    );
  }
}
