import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Auth/Login/login_logic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//! This is a journal retrieval page, that retrieves all the journals of that users id.
//! This code was taken from the Mood retrival page and edited for the Journal Retrival, to keep consistency.
class JournalViewer extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const JournalViewer({Key? key});
  //? Reference 15
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final currentTheme = themeNotifier.currentTheme;
      final fontProvider = Provider.of<FontProvider>(context);
      Color backgroundColor = currentTheme == ThemeNotifier.darkTheme
          ? Colors.grey[800]!
          : Colors.white;
      final User? user = FirebaseAuth.instance.currentUser;
      Color iconColor = themeNotifier.getIconColor();
      //! If statement to check if the user is logged in.
      if (user == null) {
        Color iconColor = themeNotifier.getIconColor();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Your Journals',
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
          body: Center(
            child: Text(
              'User is not logged in.',
              style: fontProvider.getOtherTitleStyle(themeNotifier),
            ),
          ),
        );
      }
      //! Retrieving the user Id
      final String userId = user.uid;
      //! Presenting the journal retrievals.
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Your Journals',
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

        //! Retieving data from firebase Journal Collection and presenting error messages if there is an error.
        body: SingleChildScrollView(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('JournalCollection')
                .where('user', isEqualTo: userId)
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                logger.e('Error fetching data: ${snapshot.error}');
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 300),
                      Text(
                        'Service error', //! error for fetching data.
                        style: fontProvider.errormessages(themeNotifier),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 300),
                      Text(
                        'No journals saved',
                        style: fontProvider.errormessages(themeNotifier),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              //! Presenting the journal containers. Showing each journal, their data
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: snapshot.data!.docs.asMap().entries.map((entry) {
                  int journalNumber = entry.key + 1;
                  Timestamp timestamp = entry.value['time'];
                  DateTime dateTime = timestamp.toDate();
                  String date = DateFormat('dd MMMM yyyy').format(dateTime);
                  String time = DateFormat('hh:mm a').format(dateTime);
                  String entryText = entry.value['entry'] as String;
                  String timeText = 'Time submitted: $date - $time ';
                  String journalText = 'Journal $journalNumber:';

                  //! Singular containers for each journal which presents the journal number, the date, the entry and a delete option.
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
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
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      title: Text(
                        journalText,
                        style: fontProvider.subheadingbold(themeNotifier),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            timeText,
                            style: fontProvider.subheading(themeNotifier),
                          ),
                          Text(
                            entryText,
                            style: fontProvider.subheading(themeNotifier),
                          ),
                        ],
                      ),

                      //? Reference 17
                      trailing: PopupMenuButton<String>(
                        tooltip: '',
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        offset: const Offset(0, -12.5),
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'delete',
                              child: ListTile(
                                title: Text(
                                  'Delete',
                                  style: fontProvider.subheading(themeNotifier),
                                ),
                                leading: const Icon(Icons.delete),
                              ),
                            ),
                          ];
                        },
                        //! Deleting the entry from firebase.
                        onSelected: (String value) async {
                          if (value == 'delete') {
                            await entry.value.reference.delete();
                          }
                        },
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      );
    });
  }
}
