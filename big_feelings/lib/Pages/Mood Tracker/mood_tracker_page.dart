import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MoodTrackerPage extends StatefulWidget {
  const MoodTrackerPage({Key? key}) : super(key: key);

  @override
  _MoodTrackerPageState createState() => _MoodTrackerPageState();
}

class _MoodTrackerPageState extends State<MoodTrackerPage> {
  late int selectedEmotionIndex;

  @override
  void initState() {
    super.initState();
    //! This Initialises the selected emotion index to -1  which means that no emotion is selected
    selectedEmotionIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    //! Added a logger
    var logger = Logger();

    /*
     ! Below shows a page, that asks the user how they feel and presents the
     ! users with 12 different emotional images. 
     ! There are 4 columns with the 10 space between the rows and the columns.
     ! Each image is represented by an index.
     ! References for the emotion images are in the reference page.
     */
    return Scaffold(
      appBar: AppBar(
        //! I changed the title to how do you feel, as this page is going to be a option page, so that the user can place an amotion and check their emotions.
        title: const Text('How do you feel?'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        //! Total number of emotion images
        itemCount: 12,
        itemBuilder: (context, index) {
          String imagePath = 'assets/images/images_mood/';
          //! Adding an emotion name to go under each emotional image.
          String emotionName = '';

          switch (index) {
            case 0:
              imagePath += 'angry.png';
              emotionName = 'Angry';
              break;
            case 1:
              imagePath += 'happy.png';
              emotionName = 'Happy';
              break;
            case 2:
              imagePath += 'Ok.png';
              emotionName = 'Ok';
              break;
            case 3:
              imagePath += 'overwhelmed.png';
              emotionName = 'Overwhelmed';
              break;
            case 4:
              imagePath += 'sad.png';
              emotionName = 'Sad';
              break;
            case 5:
              imagePath += 'sick.png';
              emotionName = 'Sick';
              break;
            case 6:
              imagePath += 'Silly.png';
              emotionName = 'Silly';
              break;
            case 7:
              imagePath += 'surprised.png';
              emotionName = 'Surprised';
              break;
            case 8:
              imagePath += 'tired.png';
              emotionName = 'Tired';
              break;
            case 9:
              imagePath += 'unhappy.png';
              emotionName = 'Unhappy';
              break;
            case 10:
              imagePath += 'upset.png';
              emotionName = 'Upset';
              break;
            case 11:
              imagePath += 'lonely.png';
              emotionName = 'Lonely';
              break;
          }

          return GestureDetector(
            onTap: () {
              setState(() {
                //! This checks if the tapped emotion is already selected
                if (selectedEmotionIndex == index) {
                  //! If its already selected and clicked again it will unselect.
                  selectedEmotionIndex = -1;
                  logger.i('Emotion ${index + 1} unselected');
                } else {
                  //! If it's not selected, unselect all other emotions and select the tapped one
                  //! Only one emotion can be selected at a time.
                  selectedEmotionIndex = index;
                  logger.i('Emotion ${index + 1} selected');
                }
              });
            },
            //! This adds a border by adding a selected box to the image, and when the image is selected the boarder will show on the selected image.
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    //! Wrapped the column with Expanded due to exceptions.
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedEmotionIndex == index
                              ? Colors.black
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  //! Adding space between the image and text underneath.
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    //! Then adding the emotion name underneath the image emotion.
                    emotionName,
                    //! This will eventually be changed.
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
