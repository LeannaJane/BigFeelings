import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

//! Added a logger
final logger = Logger();

class MoodTrackerPage extends StatefulWidget {
  // ignore: use_super_parameters
  const MoodTrackerPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MoodTrackerPageState createState() => _MoodTrackerPageState();
}

//! Adding an emotion name to go under each emotional image.
class _MoodTrackerPageState extends State<MoodTrackerPage> {
  late int selectedEmotionIndex;
  final List<String> moods = [
    'Angry',
    'Happy',
    'Ok',
    'Overwhelmed',
    'Sad',
    'Sick',
    'Silly',
    'Surprised',
    'Tired',
    'Unhappy',
    'Upset',
    'Lonely'
  ];
  //! Map to store descriptions for each mood
  final Map<String, String> moodDescriptions = {
    'Angry': 'Feeling really mad or upset.',
    'Happy':
        ' Feeling really good and joyful, like when you are laughing and smiling a lot.',
    'Ok': 'Feeling alright, not too good, not too bad.',
    'Overwhelmed':
        'Feeling like there is too much going on all at once and it hard to handle.',
    'Sad':
        'Feeling unhappy or down, like when you might want to cry because something makes you feel bad or disappointed. It can also include feeling anxious or worried.',
    'Sick': 'Feeling unwell or not very healthy.',
    'Silly': 'Feeling playful or goofy.',
    'Surprised': 'Feeling really amazed or shocked.',
    'Tired': 'Feeling really sleepy or worn out.',
    'Unhappy':
        'Feeling unhappy or down, like when you might want to cry because something makes you feel bad or disappointed.',
    'Upset': 'Feeling a bit bothered or troubled.',
    'Lonely':
        'Feeling like there\'s nobody around. Or feeling like you have no friends.'
  };

  bool showImage = true;
  bool showDescription = false;

  @override
  void initState() {
    super.initState();
    //! This Initialises the selected emotion index to 0  which means that no emotion is selected
    selectedEmotionIndex = 0;
  }

  //* Reference 10
  //! This method sets the current time, the mood selected and the userid, and saves it to firebase database.
  void _saveMoodToFirestore(
      String mood,
      String userId,
      FontProvider fontProvider,
      ThemeNotifier themeNotifier,
      BuildContext context) async {
    Timestamp currentTime = Timestamp.now();
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      //! Changing it to MoodsCollection without a space.
      await firestore.collection('MoodsCollection').add({
        //! The three items in the collection saved to firebase.
        'mood': mood,
        'time': currentTime,
        //! Changed it from userId to user as it couldve been the issue.
        'user': userId,
      });
      //! Shows that the mood is saved in the terminal.
      logger.i('Mood saved to Firestore with userId: $userId');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Mood entry saved successfully!',
            textAlign: TextAlign.center,
            style: fontProvider.subheadinglogin(themeNotifier),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      //! Throws an exception if it fails.
      logger.e('Error saving mood: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error saving mood entry. Please try again.',
            textAlign: TextAlign.center,
            style: fontProvider.subheadinglogin(themeNotifier),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  //! This is a method that allows the user to forward to the next emotion in the list by selecting the forward arrow.
  void _navigateForward() {
    setState(() {
      //! Increment the selectedEmotionIndex by 1 to move to the next emotion
      //! This uses a modulo (%) operator to make sure that the index remains within the bounds of the moods list
      selectedEmotionIndex = (selectedEmotionIndex + 1) % moods.length;
      showDescription = false;
    });
  }

  //! This is a method that allows the user to go to the previous emotion in the list by selecting the back button.
  void _navigateBackward() {
    setState(() {
      //! Decrement the selectedEmotionIndex by 1 to move to the previous emotion.
      //! This uses a modulo (%) operator to handle the case where the index becomes negative after decrementing
      //! This adds the moods.length before taking modulo to make sure that the index remains positive

      selectedEmotionIndex =
          (selectedEmotionIndex - 1 + moods.length) % moods.length;
      showDescription = false;
    });
  }

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
              'How do you feel?',
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
          body: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showDescription = !showDescription;
                      });
                    },
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(
                              30, 20, 30, 30), // Adjusted padding
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: getContainerColor,
                          ),
                          child: showDescription
                              ? Center(
                                  child: Text(
                                    moodDescriptions[
                                            moods[selectedEmotionIndex]] ??
                                        '',
                                    style: fontProvider
                                        .subheadinglogin(themeNotifier),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Image.asset(
                                  'assets/images/images_mood/${moods[selectedEmotionIndex].toLowerCase()}.png',
                                  fit: BoxFit.contain,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
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
                      child: IconButton(
                        onPressed: _navigateBackward,
                        icon: Icon(
                          Icons.arrow_back,
                          size: 20,
                          color: iconColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 120,
                      child: Center(
                        // Centering the text
                        child: Text(
                          moods[selectedEmotionIndex],
                          style: fontProvider.subheadinglogin(themeNotifier),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
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
                      child: IconButton(
                        onPressed: _navigateForward,
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 20,
                          color: iconColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 350.0),
              ],
            ),
            Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width / 2 - 75,
              child: GestureDetector(
                onTap: () {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    _saveMoodToFirestore(moods[selectedEmotionIndex], user.uid,
                        fontProvider, themeNotifier, context);
                  } else {
                    logger.e('User is not logged in.');
                  }
                },
                child: Container(
                  height: 40,
                  width: 150,
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
                      'Save Mood',
                      style: fontProvider.subheadinglogin(themeNotifier),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          ]));
    });
  }
}
