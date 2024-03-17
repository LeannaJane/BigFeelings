import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class QuizResults extends StatelessWidget {
  const QuizResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final fontProvider = Provider.of<FontProvider>(context);
      Color getContainerColor =
          Provider.of<ThemeNotifier>(context).getContainerColor();
      Color iconColor = themeNotifier.getIconColor();
      if (user == null) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Quiz Results',
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
      final String userId = user.uid;

      return Scaffold(
        backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
          title: Text(
            'Quiz Results',
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
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('QuizCollectionResults')
                .where('user', isEqualTo: userId)
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                print('Error fetching data: ${snapshot.error}');
                return const Center(
                  child: Text('An error occurred while fetching data.'),
                );
              }
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No quiz results found.'),
                );
              }

              List<Widget> quizresultContainers =
                  snapshot.data!.docs.map((quizResult) {
                String? quizId = quizResult['quizId'] as String?;
                Timestamp timestamp = quizResult['timestamp'];
                DateTime dateTime = timestamp.toDate();
                String date = DateFormat('dd MMMM yyyy').format(dateTime);
                String time = DateFormat('hh:mm a').format(dateTime);

                int score = quizResult['score'] as int;
                //! Quiz number
                String quizNumber = '';
                if (quizId != null) {
                  if (quizId.contains('1')) {
                    quizNumber = '1';
                  } else if (quizId.contains('2')) {
                    quizNumber = '2';
                  }
                  //! Quiz numbers will need to be added here if more quizes are made.
                }
                String quizDisplayText = 'Quiz $quizNumber';
                String scoreText = 'Score: $score out of 10';
                String timeText = 'Time submitted: $date - $time ';
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
                    title: Text(
                      quizDisplayText,
                      style: fontProvider.subheading(themeNotifier),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          timeText,
                          style: fontProvider.subheading(themeNotifier),
                        ),
                        Text(
                          scoreText,
                          style: fontProvider.subheading(themeNotifier),
                        ),
                      ],
                    ),
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
                      onSelected: (String value) async {
                        if (value == 'delete') {
                          await quizResult.reference.delete();
                        }
                      },
                    ),
                  ),
                );
              }).toList();
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: quizresultContainers,
              );
            },
          ),
        ),
      );
    });
  }
}
