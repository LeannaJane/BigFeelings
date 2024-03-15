// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoOptions extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const VideoOptions({Key? key});

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
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final fontProvider = Provider.of<FontProvider>(context);
      Color getContainerColor =
          Provider.of<ThemeNotifier>(context).getContainerColor();
      Color iconColor = themeNotifier.getIconColor();
      return Scaffold(
          appBar: AppBar(
            title: Text(
              'Educational Videos',
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
              Container(
                width: 300,
                height: 200,
                margin: const EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  color: getContainerColor,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Hello, and welcome to the fun video page where you learn all about managing your feelings with cool sensory videos! Also, we have content teaching you about your emotions,why you feel those emotions and how to manage them. ',
                      style: fontProvider.subheading(themeNotifier),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                onTap: () {
                  _launchURL(
                      context, 'https://www.youtube.com/watch?v=9ekY8EvrZmM');
                  //? Ref 22
                },
                title: buildVideoContainer('Sensory Video', getContainerColor,
                    fontProvider, themeNotifier, 'assets/icons/bubbles.png'),
                //? Ref 20
              ),
              const SizedBox(height: 20),
              ListTile(
                onTap: () {
                  _launchURL(
                      context, 'https://www.youtube.com/watch?v=jetoWelJJJk');
                  //? Ref 23
                },
                title: buildVideoContainer(
                    'Emotion understanding video',
                    getContainerColor,
                    fontProvider,
                    themeNotifier,
                    'assets/icons/emotion.png'),
                //? Ref 19
              ),
              const SizedBox(height: 20),
              ListTile(
                onTap: () {
                  _launchURL(
                      context, 'https://www.youtube.com/watch?v=jl8G2jiSNA0');
                  //? Ref 23
                },
                title: buildVideoContainer(
                    'Story book video',
                    getContainerColor,
                    fontProvider,
                    themeNotifier,
                    'assets/icons/book.png'),
                //? Ref 21
              ),
            ],
          )));
    });
  }

  //! Rused code from the home page to place the images.
  Widget buildVideoContainer(
      String title,
      Color containerColor,
      FontProvider fontProvider,
      ThemeNotifier themeNotifier,
      String imagePath) {
    return Container(
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
        color: containerColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(imagePath, height: 30, width: 30, fit: BoxFit.cover),
          Expanded(
            child: Text(
              title,
              style: fontProvider.subheading(themeNotifier),
              textAlign: TextAlign.center,
            ),
          ),
          Image.asset(imagePath, height: 30, width: 30, fit: BoxFit.cover),
        ],
      ),
    );
  }
}
