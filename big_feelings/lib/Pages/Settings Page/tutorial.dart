// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Tutorial extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Tutorial({Key? key});

  //? Ref 18 - Used to help launch a url from my flutter application.
  void _launchURL(BuildContext context, String url) async {
    final Uri url0 = Uri.parse(url);
    if (!await canLaunch(url0.toString())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('The url cannot be launched: $url'),
        ),
      );
    } else {
      await launch(url0.toString());
    }
  }

  //! This is a code that presents educational video urls, and when the user selects a container they will be forwarded to the youtube channel based on the url.
  //! Code was reused here and edited to fit the libary video section.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final fontProvider = Provider.of<FontProvider>(context);
        Color getContainerColor =
            Provider.of<ThemeNotifier>(context).getContainerColor();
        Color iconColor = themeNotifier.getIconColor();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Tutorial',
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20), // Add horizontal padding
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 20.0),
                      decoration: BoxDecoration(
                        color: getContainerColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Big Feelings is an interactive web application that presents children with various activities, minigames, and resources. With a user-friendly user interface, children can engage and build an understanding of different types of emotions and learn how to cope with them. Feelings and moods can be documented and viewed in the journal and mood tracker tools.\n\n'
                            'How does the application help?\n'
                            '• Emotion recognition: Children can learn to identify and name different emotions and become self-aware of what emotions they are feeling.\n'
                            '• Coping strategies: The application provides evidence-based coping mechanisms and techniques to help children regulate and cope with their emotions.\n'
                            '• Empathy Building: Children can become more understanding of their emotions and other people\'s emotions and develop empathy.\n'
                            '• Safe Environment: The app offers a safe and supportive environment for children to explore and express themselves without judgment.\n\n'
                            'The Big Feelings application is intended for educational and entertainment purposes only. It is unsuitable for professional mental health advice, diagnoses, or treatment; users should seek guidance from a qualified healthcare provider/professional if they need support.',
                            style: fontProvider.subheading(themeNotifier),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: getContainerColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Tap the button below to watch the tutorial video:',
                        style: fontProvider.subheading(themeNotifier),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _launchURL(
                        context, 'https://www.youtube.com/watch?v=9ekY8EvrZmM');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: getContainerColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_circle_fill,
                              color: iconColor,
                              size: 30,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Big Feelings Tutorial',
                              style:
                                  fontProvider.subheadinglogin(themeNotifier),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.play_circle_fill,
                              color: iconColor,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/images_mood/sad.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/images_mood/tired.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/images_mood/surprised.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/images_mood/ok.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/images_mood/happy.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
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
