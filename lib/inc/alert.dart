import 'package:flutter/material.dart';

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("Please Wait")),
          content: Container(
              height: 50, child: Center(child: CircularProgressIndicator())),
        );
      });
}