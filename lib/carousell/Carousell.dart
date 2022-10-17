



import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:market/carousell/Viewcarousell.dart';
import 'package:market/market_provider/Market_Provider.dart';
import 'package:provider/provider.dart';

class Carousell extends StatelessWidget {

  final  controller;
  final List dataa;
  Carousell({required this.dataa, this.controller});
  int c=0;
  @override
  Widget build(BuildContext context) {
    var co= Provider.of<Market_Provider>(context);
    //  print("c=${c++}");
    return

      CarouselSlider(
        options: CarouselOptions(
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          enableInfiniteScroll: true,
          scrollDirection: Axis.horizontal,
          autoPlay: true,
          onPageChanged: (index, reason) {
            co.counter(index);},
          autoPlayInterval: Duration(seconds: 2),
          autoPlayAnimationDuration: Duration(milliseconds: 400),
          height: 200,
        ),
        carouselController: controller,

        items: dataa.map((item) {
          return Viewcarousell(item:item);
        }).toList(),

      );}
}

