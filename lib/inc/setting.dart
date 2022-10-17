import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:market/widget/language_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationAppPage extends StatefulWidget {
  @override
  _LocalizationAppPageState createState() => _LocalizationAppPageState();
}

class _LocalizationAppPageState extends State<LocalizationAppPage> {
  var user = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
     // backgroundColor: Colors.black,

      title: Text(AppLocalizations.of(context)!.setting),
      centerTitle: true,
      actions: [
        LanguagePickerWidget(),
        const SizedBox(width: 12),
      ],
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LanguageWidget(),
           SizedBox(height: 32),
          Center(
            child: Text(
              AppLocalizations.of(context)!.language,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
           SizedBox(height: 8),
          Center(
            child: FittedBox(
              child: Text(
                AppLocalizations.of(context)!.hello(user!),
                style: TextStyle(fontSize: 36),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
