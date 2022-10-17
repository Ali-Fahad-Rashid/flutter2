// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:market/market_provider/Market_Provider.dart';
import 'package:market/widget/Function.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LightMode extends StatefulWidget {
  @override
  State<LightMode> createState() => _LightModeState();
}
class _LightModeState extends State<LightMode> {
  @override

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Market_Provider>(context);
      provider.getPref();
    return
      Switch(
        value: provider.value,
        onChanged: (bool newValue) {
          provider.Light(newValue);
        },
      );
  }}