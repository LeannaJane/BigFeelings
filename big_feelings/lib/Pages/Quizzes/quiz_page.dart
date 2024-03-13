import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Quizzes extends StatelessWidget {
  const Quizzes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final currentTheme = themeNotifier.currentTheme;
        final fontProvider = Provider.of<FontProvider>(context);
        Color backgroundColor = currentTheme == ThemeNotifier.darkTheme
            ? Colors.grey[800]!
            : Colors.white;
        Color iconColor = currentTheme == ThemeNotifier.darkTheme
            ? Colors.white
            : Colors.black;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Please select a quiz',
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
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                ListTile(
                  onTap: () {},
                  title: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: backgroundColor,
                    ),
                    child: Text(
                      'Quiz 1',
                      style: fontProvider.subheading(themeNotifier),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  onTap: () {},
                  title: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: backgroundColor,
                    ),
                    child: Text(
                      'Quiz 2',
                      style: fontProvider.subheading(themeNotifier),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
