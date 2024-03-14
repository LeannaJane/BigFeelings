import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart'; // Add this import
import 'package:big_feelings/Classes/font_provider.dart'; // Add this import

class StartQuiz2 extends StatefulWidget {
  const StartQuiz2({Key? key}) : super(key: key);

  @override
  _StartQuiz2State createState() => _StartQuiz2State();
}

class _StartQuiz2State extends State<StartQuiz2> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final fontProvider = Provider.of<FontProvider>(context);
      Color getContainerColor =
          Provider.of<ThemeNotifier>(context).getContainerColor();
      Color iconColor = themeNotifier.getIconColor();

      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Welcome to Quiz 2',
            style: fontProvider.getOtherTitleStyle(themeNotifier),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30.0,
              color: iconColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    });
  }
}
