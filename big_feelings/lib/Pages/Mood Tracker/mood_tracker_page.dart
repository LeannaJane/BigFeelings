import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MoodTrackerPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MoodTrackerPage({Key? key});

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
        title: const Text('How do you feel?'), // Change the title
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: 12, // Total number of emotion images
        itemBuilder: (context, index) {
          String imagePath = 'assets/images/images_mood/';

          switch (index) {
            case 0:
              imagePath += 'angry.png';
              break;
            case 1:
              imagePath += 'happy.png';
              break;
            case 2:
              imagePath += 'Ok.png';
              break;
            case 3:
              imagePath += 'overwhelmed.png';
              break;
            case 4:
              imagePath += 'sad.png';
              break;
            case 5:
              imagePath += 'sick.png';
              break;
            case 6:
              imagePath += 'Silly.png';
              break;
            case 7:
              imagePath += 'surprised.png';
              break;
            case 8:
              imagePath += 'tired.png';
              break;
            case 9:
              imagePath += 'unhappy.png';
              break;
            case 10:
              imagePath += 'upset.png';
              break;
            case 11:
              imagePath += 'lonely.png';
              break;
          }

          return GestureDetector(
            onTap: () {
              logger.i('Emotion ${index + 1} selected');
            },
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
