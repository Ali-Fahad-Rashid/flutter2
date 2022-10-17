import 'package:flutter/material.dart';
import 'package:market/inc/viewcat.dart';

class Cat extends StatelessWidget {
  const Cat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return     Container(
        height: 60,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return Viewcat(car: 'BMW');
                }));
              },
              child: Container(
                  height: 100,
                  width: 100,
                  child: ListTile(
                    title: Image.asset(
                      'images/5.png',
                      width: 55,
                      height: 55,
                     // fit: BoxFit.fill,
                    ),
                    subtitle: Container(
                        child: Text(
                          "BMW",
                          textAlign: TextAlign.center,
                        )),
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return Viewcat(car: 'Rolls');
                }));
              },
              child: Container(
                  height: 100,
                  width: 100,
                  child: ListTile(
                    title: Image.asset(
                      'images/6.png',
                      width: 65,
                      height: 55,
                  //    fit: BoxFit.fill,
                    ),
                    subtitle: Container(
                        child: Text(
                          "Rolls",
                          textAlign: TextAlign.center,
                        )),
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return Viewcat(car: 'Mercedes');
                }));
              },
              child: Container(
                  height: 100,
                  width: 100,
                  child: ListTile(
                    title: Image.asset(
                      'images/22.png',
                      width: 55,
                      height: 55,
                    //  fit: BoxFit.fill,
                    ),
                    subtitle: Container(
                        child: Text(
                          "Mercedes",
                          textAlign: TextAlign.center,
                        )),
                  )),
            ),
            InkWell(
              onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Viewcat(car: 'Nissan');
              }));
            },
              child: Container(
                  height: 100,
                  width: 100,
                  child: ListTile(
                    title: Image.asset('images/33.png',
                        width: 55, height: 55,
                       // fit: BoxFit.fill
                    ),
                    subtitle: Container(
                        child: Text(
                          "Nissan",
                          textAlign: TextAlign.center,
                        )),
                  )
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return Viewcat(car: 'ToYoTa');
                }));
              },
              child: Container(
                  height: 100,
                  width: 100,
                  child: ListTile(
                    title: Image.asset('images/8.jpg',
                       width: 55, height: 55,
                        fit: BoxFit.fill
                    ),
                    subtitle: Container(
                        child: Text(
                          "ToYoTa",
                          textAlign: TextAlign.center,
                        )),
                  )),
            ),
          ],
        ));
  }
}
