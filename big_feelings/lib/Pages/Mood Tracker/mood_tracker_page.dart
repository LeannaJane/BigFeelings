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
        const SnackBar(
          content: Text(
            'Error saving mood entry. Please try again.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          duration: Duration(seconds: 2),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    //final User? user = FirebaseAuth.instance.currentUser;
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final fontProvider = Provider.of<FontProvider>(context);
      Color getContainerColor =
          Provider.of<ThemeNotifier>(context).getContainerColor();
      Color iconColor = themeNotifier.getIconColor();

      /*
     ! Below shows a page, that asks the user how they feel and presents the
     ! users with 12 different emotional images. 
     ! Each image is represented by an index.
     ! References for the emotion images are in the reference page.
     */

      return Scaffold(
        appBar: AppBar(
          title: Text(
            //! I made the title How do you feel.
            'How do you feel?',
            style: fontProvider.getOtherTitleStyle(themeNotifier),
            //! I aligned the title to the center. And then set the fontweight to bald for now until I add the font style.
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //! Adding a forward and backwards icon to allow the user to scroll through the different emotions.
            //! Ref 11.
            Container(
              //! The width and height of the container.
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                //! The boarder radius styled.
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
                  //! Added padding to the image to reduce the image size inside of the container.
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: getContainerColor,
                  ),
                  child: Image.asset(
                    'assets/images/images_mood/${moods[selectedEmotionIndex].toLowerCase()}.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _navigateBackward,
                  icon: Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: iconColor,
                  ),
                ),
                const SizedBox(width: 30),
                Text(
                  moods[selectedEmotionIndex],
                  style: fontProvider.subheadinglogin(themeNotifier),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: _navigateForward,
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: iconColor,
                  ),
                ),
              ],
            ),

            //! Adding space between the mood label and the save mood button.
            const SizedBox(height: 20.0),
            //! I added a elevated button that allows the user to save their emotion by selecting the button. This saves to firebase.
            GestureDetector(
              onTap: () {
                //! This accesses the current user ID
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  _saveMoodToFirestore(moods[selectedEmotionIndex], user.uid,
                      fontProvider, themeNotifier, context);
                } else {
                  logger.e('User is not logged in.');
                  //! This handles when user not logged in
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
                alignment: Alignment.center,
                child: Text(
                  'Save Mood',
                  style: fontProvider.subheadinglogin(themeNotifier),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
