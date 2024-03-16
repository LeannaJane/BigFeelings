import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoodEntriesPage extends StatelessWidget {
  // ignore: use_super_parameters
  const MoodEntriesPage({Key? key}) : super(key: key);
  //? This code below presents a mood entry page, that shows the different entries taken from firebase.
  //? It shows the time, the mood type and the image of the mood.

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final fontProvider = Provider.of<FontProvider>(context);
      Color getContainerColor =
          Provider.of<ThemeNotifier>(context).getContainerColor();
      Color iconColor = themeNotifier.getIconColor();

      //! If the user isnt logged in it will throw this into the page.
      if (user == null) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Your Mood Entries',
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
          body: const Center(
            child: Text('User is not logged in.'),
          ),
        );
      }
      //! getting the userId
      final String userId = user.uid;

      return Scaffold(
        //! Setting the current theme as the background colour.
        backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
        appBar: AppBar(
          //! Setting the current theme as the background colour.
          backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
          title: Text(
            //! Your entries title for this page, which is centered, the style will eventually be changed
            'Your Mood Entries',
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
              //! If selected it will return to the previous page.
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          //! StreamBuilder is used to listen changes in Firestore data
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                //! Changed the collection name without a space as that could also cause issues.
                .collection('MoodsCollection')
                .where('user', isEqualTo: userId)
                //! This orders the time in descending order
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //! This shows a loading  while data is being fetched
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                //! I struggled to understand the error why my code was not actually retrieivng the data, and it was because of
                //! an indexing problem.
                print('Error fetching data: ${snapshot.error}');
                //! If there is an error while fetching the data it will present a error text.
                return const Center(
                  //! If there is an error while fetching the data it will present a error text.
                  //! If there is an error while fetching the data it will present a error text.
                  child: Text('An error occurred while fetching data.'),
                );
              }
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return const Center(
                  //! This shows a message if no mood entries are found
                  child: Text('No mood entries found.'),
                );
              }
              //! This creates a list of mood entry containers
              List<Widget> moodEntryContainers =
                  snapshot.data!.docs.map((moodEntry) {
                //! This extracts mood data from Firestore collection document for moods
                String mood = moodEntry['mood'];
                Timestamp timestamp = moodEntry['time'];
                DateTime dateTime = timestamp.toDate();
                //! These variables format the date and the time.
                String date = DateFormat('dd MMMM yyyy').format(dateTime);
                String time = DateFormat('hh:mm a').format(dateTime);

                //! This returns a container for each mood entry
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                    color: getContainerColor,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    leading: Image.asset(
                      //! It will display a mood image based on the mood type, next to the mood information.
                      'assets/images/images_mood/${mood.toLowerCase()}.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                    //? Ref 14
                    //! This will show the date and time next to the image.
                    title: Text(
                      '$date - $time',
                      style: fontProvider.subheading(themeNotifier),
                    ),
                    subtitle: Text(
                      mood,
                      style: fontProvider.subheading(themeNotifier),
                    ),
                    //! A trailing is added that allows the item for a delete icon to be added to the container,
                    //! This allows the user to select delete and if they want to delete the value will = delete and then using async will
                    //! delete the document from firebase.
                    trailing: PopupMenuButton<String>(
                      //! Added a colour to the popupm menu and round edges.
                      //! Removing the placeholder of the button.
                      tooltip: '',

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      //! I added a offset to control where the popup should appear and i made it appear in the right side of the document output in the center vertically.
                      offset: const Offset(0, -12.5),
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'delete',
                            child: ListTile(
                              //! Adding a delete bin Icon.
                              title: Text(
                                'Delete',
                                style: fontProvider.subheading(themeNotifier),
                              ),
                              leading: const Icon(Icons.delete),
                            ),
                          ),
                        ];
                      },
                      //? Ref 13
                      onSelected: (String value) async {
                        if (value == 'delete') {
                          //! Performs the deletion from Firestore.
                          await moodEntry.reference.delete();
                        }
                      },
                    ),
                  ),
                );
              }).toList();
              //! This returns the mood entry containers with 20 spacing between them.
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: moodEntryContainers,
              );
            },
          ),
        ),
      );
    });
  }
}
