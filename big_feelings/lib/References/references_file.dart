// ! Welcome to the References File!
//! This file contains all the references and citations used in this project.
//* --------------------------------------------------------------------------------------------


//! References from the Login page.

/*
1
? docs.flutter.dev. (n.d.). Display a snackbar. [online] Available at: https://docs.flutter.dev/cookbook/design/snackbars [Accessed 3 Feb. 2024].
* - This website provided guidance on displaying a snackbar in Flutter and assisted me in creating a snackbar.
2
? stack Overflow. (n.d.). Do not use BuildContexts across async gaps. [online] Available at: https://stackoverflow.com/questions/68871880/do-not-use-buildcontexts-across-async-gaps [Accessed 5 Feb. 2024].
* - This website was used to help guide me on how to handle the 'BuildContext' across async.
* - It told me to use the mounted property to check if the widgets are still mounted before performing actions asynchronously.
3
?  Kumar, Y. (2022). Login Page UI in Flutter. [online] Medium. Available at: https://levelup.gitconnected.com/login-page-ui-in-flutter-65210e7a6c90.
* - This login page was origionally a template guided by the flutter webpage, and was eventually updated to be my own login page.
* - This login page was used for inspiration that guided me to create a basic login, then I improved it making it my own.
4
?  Stack Overflow. (n.d.). Flutter Text Field: How to add Icon inside the border. [online] Available at: https://stackoverflow.com/questions/55929495/flutter-text-field-how-to-add-icon-inside-the-border [Accessed 3 Feb. 2024].
*  This page helped me understand how to add an icon inside the border.
5
? Firebase. (n.d.). Error Handling | Firebase Documentation. [online] Available at: https://firebase.google.com/docs/auth/flutter/errors.
* - This was used to help me understand how to use a if statement for the error codes.
* if (e.code == 'account-exists-with-different-credential') {
* This line assisted me in creating my own if statements, but I had to try create errors when testing my login to see what errors and place the error in the if statement.
6
? somniosoftware.com. (n.d.). Email Authentication with Flutter - Firebase. [online] Available at: https://www.somniosoftware.com/blog/email-authentication-with-flutter-firebase [Accessed 11 Feb. 2024].
* This website guided me on how to create a email login and a create an account page.
7
? www.youtube.com. (n.d.). 📱Login & Logout • Firebase x Flutter Tutorial ♡. [online] Available at: https://www.youtube.com/watch?v=TkuO8OLgvkk
* This video guided me on how to create a login and logout using firebase and the email controller and password controller. 
8
? GitHub. (n.d.). SignInWithEmailAndPassword unable to handle error when the email address is badly formatted · Issue #3303 · firebase/flutterfire. [online] Available at: https://github.com/firebase/flutterfire/issues/3303 [Accessed 11 Feb. 2024].
* When I moved the error code if statement into own logic class, I had to edit my if statement to catch the error
* and if it was equal to the message that it contains it will set the login error, and when the user experiences this error it will print the correct error.
* } on FirebaseAuthException catch  (e) {
*  if (e.code == 'invalid-email') {
*   // Do something :D
* }
* 
9
? Freepik. (n.d.). Emoji icons created by Freepik. [online] Flaticon. Available at: https://www.flaticon.com/free-icons/emoji [Accessed <access date>].
* - This website provided Emoji icons created by Freepik, which were used in the project for Mood Tracker page.

10
? Firebase. (n.d.). Read and Write Data | Firebase Realtime Database. [online] Available at: https://firebase.google.com/docs/database/flutter/read-and-write.
* This website assisted me in saving my data from the mood tracker to the firebase using UserID.

*DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");
*await ref.set({
* "name": "John",
*  "age": 18,
*  "address": {
*  "line1": "100 Mountain View"
* }
* This code allowed me to save the date, the user ID and the chosen emotion.

11
? Githubusercontent.com. (2022). Available at: https://user-images.githubusercontent.com/56982087/192634126-b0bab8fb-3544-481c-8267-f29f6469d66d.jpg [Accessed 26 Feb. 2024].
* This github code Ui for the emotion layout was inspired by this github respos. 

12
? www.youtube.com. (n.d.). Retrieve Firebase Data & ListView | Part 5. [online] Available at: https://www.youtube.com/watch?v=RGIogk7MFG4 [Accessed 22 Jan. 2024].
* This video guided me on how to create a list that outputs the firebase data from the collection of the user id.
‌
13 
? www.youtube.com. (n.d.). Delete a document of a Cloud Firestore collection from a Flutter app. [online] Available at: https://www.youtube.com/watch?v=KLDVXaTPa5E [Accessed 2 Mar. 2024].
* This youtube video assisted me on adding a delete option to delete firebase documents. 

14
? groups.google.com. (n.d.). How to create a pop up menu on a ListTile?? Why is my code for it not working?? [online] Available at: https://groups.google.com/g/flutter-dev/c/KbEsBmVecpo?pli=1 [Accessed 2 Mar. 2024].
* Then this reminded me how to add a popup menu item for the containers that have the document information in.
‌

15
? www.youtube.com. (n.d.). Flutter To-Do List App Tutorial with Firebase: Part 3 - Firestore. [online] Available at: https://www.youtube.com/watch?v=tWCZCP_qtFA
* This youtube playlist guided me into how to connect to firestore using firebase, and how to make a working journal and mood tracker page.
‌
16
? www.youtube.com. (n.d.). 📱 Popup Menu • Flutter Tutorial. [online] Available at: https://www.youtube.com/watch?v=FYFqUMHxu3Q 
* I have used this video a few times to help me learn how to create a pop up button for a delete option.

17
? Stack Overflow. (n.d.). how to delete item list using pop up menu - flutter. [online] Available at: https://stackoverflow.com/questions/54997629/how-to-delete-item-list-using-pop-up-menu-flutter.
* This was used to help create a trailing option for the popup button to place the icon at the end of the container.
*/

// ! References for the libary page
/*
18
? Dart packages. (n.d.). url_launcher example | Flutter package. [online] Available at: https://pub.dev/packages/url_launcher/example [Accessed 15 Mar. 2024].
* This website helped me understand how to launch a url within the application for my video section. This is the code that assisted me:
* Future<void> _launchInBrowser(Uri url) async {
*  if (!await launchUrl(
*      url,
*      mode: LaunchMode.externalApplication,
*    )) {
*      throw Exception('Could not launch $url');
*  }
* }
* I eddited the code and made it fit for my program. 
‌
19
? https://www.facebook.com/flaticon (2019). Feedback Icon - 2282387. [online] Flaticon. Available at: https://www.flaticon.com/free-icon/feedback_2282387?term=emotion&page=1&position=23&origin=search&related_id=2282387 [Accessed 15 Mar. 2024].
? Attribute:  <a href="https://www.flaticon.com/free-icons/emotion" title="emotion icons">Emotion icons created by Freepik - Flaticon</a>
* Used emotion icon for the libary page.

20
? https://www.facebook.com/flaticon (2020). Bubbles Icon - 2652726. [online] Flaticon. Available at: https://www.flaticon.com/free-icon/bubbles_2652726?term=bubble&page=1&position=7&origin=search&related_id=2652726 [Accessed 15 Mar. 2024].
? Attribute: <a href="https://www.flaticon.com/free-icons/bubbles" title="bubbles icons">Bubbles icons created by kerismaker - Flaticon</a>
* Used bubble icon for the libary video page.

21 
? https://www.facebook.com/flaticon (2021). Stack of books Icon - 5833290. [online] Flaticon. Available at: https://www.flaticon.com/free-icon/stack-of-books_5833290?term=book&page=1&position=32&origin=search&related_id=5833290icons [Accessed 15 Mar. 2024].
? <a href="https://www.flaticon.com/free-icons/books" title="books icons">Books icons created by popo2021 - Flaticon</a>
* Used book icon for the libary video page.

22
? www.youtube.com. (n.d.). Quiet Classroom Music For Children - Calming Sensory Bubbles - Morning music for class. [online] Available at: https://www.youtube.com/watch?v=9ekY8EvrZmM.
* This youtube video is used as a url link to forward the user to a youtube video. 

23
? Smile and Learn - English (2020). Emotions for Kids - Happiness, Sadness, Fear, Anger, Disgust and Surprise. YouTube. Available at: https://www.youtube.com/watch?v=jetoWelJJJk.
* This youtube video is used as a url link to forward the user to a youtube video. 

24
? www.youtube.com. (n.d.). The Emotions Book. [online] Available at: https://www.youtube.com/watch?v=jl8G2jiSNA0.
* This youtube video is used as a url link to forward the user to a youtube video. 
‌

*/

//! Lottie animation
/*

25
? LottieFiles. (n.d.). Issey. [online] Available at: https://lottiefiles.com/trufffle [Accessed 17 Mar. 2024].
* This animation was edited and changed but created by Issey in lottie files, under the Simple lottie Lisense.
‌
*/
//! Icon launcher maker.
/*
26 - edited in the android src res file.
? romannurik.github.io. (n.d.). Android Asset Studio - Launcher icon generator. [online] Available at: https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html#foreground.type=image&foreground.space.trim=0&foreground.space.pad=0&foreColor=rgba(96%2C%20125%2C%20139%2C%200)&backColor=rgb(255%2C%20255%2C%20255)&crop=0&backgroundShape=square&effects=none&name=ic_launcher [Accessed 17 Mar. 2024].
* I used this site to add my image logo into it and it generated the right sizes for my logo for my application for the android version:D.
*/

//! Logo maker using canva.
/*
27 - edited in the web file.
? Canva (2024). Canva. [online] Canva. Available at: https://www.canva.com/.
* Created my logo for my application using canva, this application provided text and allowed me to customsie my logo.
*/

//! I had an error with the application on the android device not allowing urls to be forwarded.
/*
28
? Stack Overflow. (n.d.). Flutter url_launcher is not launching url in release mode. [online] Available at: https://stackoverflow.com/questions/65883844/flutter-url-launcher-is-not-launching-url-in-release-mode [Accessed 17 Mar. 2024].
* This website asisted me in how to fixing the issue on the manifest page in the android folder. I made sure to add permissions for the url.
 */


//! Font dialog page References
/*
29
? Android Developers. (n.d.). Work with fonts | Jetpack Compose. [online] Available at: https://developer.android.com/jetpack/compose/text/fonts [Accessed 3 Feb. 2024].
* This website assisted in me setting fonts.

30 
? www.youtube.com. (n.d.). Custom Font in Flutter | Flutter external font | Flutter Tutorial #14. [online] Available at: https://www.youtube.com/watch?v=qI_7znKKlhA [Accessed 3 Feb. 2024].
* This video guided me on how to use custom fonts in my flutter application.

31
? * www.youtube.com. (n.d.). Flutter Tutorial - Full Course - Project Based. [online] Available at: https://www.youtube.com/watch?v=OO_-MbnXQzY [Accessed 3 Feb. 2024].
* This video guided me on how to use custom fonts in my flutter application.

32
? docs.flutter.dev. (n.d.). Work with long lists. [online] Available at: https://docs.flutter.dev/cookbook/lists/long-lists.
* Tjos website taught me how to create lists.

33 
? api.flutter.dev. (n.d.). actions property - AppBar class - material library - Dart API. [online] Available at: https://api.flutter.dev/flutter/material/AppBar/actions.html [Accessed 6 Feb. 2024].
* Implemented an action widget using the code provided by flutter to assist me.
 
34
? Stack Overflow. (n.d.). How to refresh an AlertDialog in Flutter? [online] Available at: https://stackoverflow.com/questions/51962272/how-to-refresh-an-alertdialog-in-flutter [Accessed 6 Feb. 2024].
* I had an issue where the fonts were not updating to the selected font on the drop down, so this website helped me understand how to use an alert dialog.
* This website also helped me understand how to write my show dialog dropdown using a stateful builder.
 
35
? Stack Overflow. (n.d.). How to make a full screen dialog in flutter? [online] Available at: https://stackoverflow.com/questions/51908187/how-to-make-a-full-screen-dialog-in-flutter [Accessed 6 Feb. 2024].
* I used this website to understand how to change the opacity of the dimming in the background the line:
* backgroundColor: Colors.white.withOpacity(0.85),

36
?  Stack Overflow. (n.d.). flutter DropDownButton remove arrow icon? [online] Available at: https://stackoverflow.com/questions/67997560/flutter-dropdownbutton-remove-arrow-icon [Accessed 12 Feb. 2024].
* Hiding the default icon.
 */
//! Main references
/*
37
? flutterbyexample.com. (n.d.). ChangeNotifierProvider. [online] Available at: https://flutterbyexample.com/lesson/change-notifier-provider [Accessed 3 Feb. 2024].
* The change notifier is a class provided by the provider package, this is used for managing and providing
* instances.
* In this case I used it to create and provider a instance of the Font provider class. 
* This is used to change the font state, and then the changes will adapt. 
* This code for the adding a ChangeNotiferProvider was assited by the flutter website.
 */

//! Home page references
/*
38
? GeeksforGeeks. (2023). Flutter - Elevation in AppBar. [online] Available at: https://www.geeksforgeeks.org/flutter-elevation-in-appbar/ [Accessed 5 Feb. 2024].
* This website helped me understand how to remove the shadow from the bottom appbar.
39
?GitHub. (n.d.). Inner ListView.builder with shrinkWrap as true builds all children at once · Issue #26072 · flutter/flutter. [online] Available at: https://github.com/flutter/flutter/issues/26072 [Accessed 5 Feb. 2024].
* This was used to help me fix a issue with my code. The list builder had issues, and the text would show outside the list, but this fixed it.
40
? Kumar, Y. (2020). ListView in Flutter. [online] The Startup. Available at: https://medium.com/swlh/listview-in-flutter-222caba33e42 [Accessed 5 Feb. 2024].
* Teaches me how to use list view and listview builder which was used in my home page.
? Flutterdynasty (2023). Listview.builder in Flutter. [online] Medium. Available at: https://medium.com/@flutterdynasty/listview-builder-in-flutter-e54a8fa2c7a0 [Accessed 5 Feb. 2024].
* Another reference to help me understand how to use a list.
41
?‌ dartpad.dev. (n.d.). DartPad Workshops. [online] Available at: https://dartpad.dev/workshops.html?webserver=https://fdr-shrinkwrap-slivers.web.app#Step2 [Accessed 5 Feb. 2024].
42
? Gupta, D. (2018). Flutter: Displaying Dynamic Contents using ListView.builder. [online] Medium. Available at: https://medium.com/@CognitiveProgrammer/flutter-displaying-dynamic-contents-using-listview-builder-f2cedb1a19fb [Accessed 5 Feb. 2024].
* Another reference to help me understand how to use a list.
43 
? Sarkar, M. (2023). Flutter ListView Widget Full Tutorial. [online] All About Flutter | Flutter and Dart. Available at: https://www.allaboutflutter.com/flutter-listview-widget-full-tutorial [Accessed 5 Feb. 2024].
* This website guided me how to create a listview widget.
44
? www.youtube.com. (n.d.). Add Dynamic Items to ListView in Flutter using GetX || Flutter || GetX. [online] Available at: https://www.youtube.com/watch?v=3G-dPzwO9s4 [Accessed 5 Feb. 2024].
* This video walked me through on how to use a listview of the items for my home page, where all of the items, are in a list in containers.
45
?  How to Flutter. (n.d.). Maps & Sets. [online] Available at: https://howtoflutter.dev/dart/data-types/maps-sets/ [Accessed 5 Feb. 2024].
*  This guided me on how to create a map dynamic string menu items, with the variables and their routes.

46
? Hire Developers, Free Coding Resources for the Developer. (n.d.). [Solved]-List to List Dart-Flutter. [online] Available at: https://www.appsloveworld.com/flutter/200/223/listmapstringdynamic-to-liststring-dart [Accessed 5 Feb. 2024].
* This website provided sample code that helped me understand how to organise using kmaps to strcute data.
* I made modifications to align it with my code. 
* I made a method that navigates the user depedning on their menu item index and it will send the user to the correct route/page.


47
? Stack Overflow. (n.d.). Flutter: How to flip an icon to get mirror effect? [online] Available at: https://stackoverflow.com/questions/58047009/flutter-how-to-flip-an-icon-to-get-mirror-effect [Accessed 23 Mar. 2024].
This website taught me how to flip an icon using transform the the homepage darkmode and light mode icons. 
*/

 
/*
48
? LottieFiles. (n.d.). UsamaRazzaq. [online] Available at: https://lottiefiles.com/animations/walking-kid-DqYW4LjiwO.
* This animation was edited and changed but created by Issey in lottie files, under the Simple lottie Lisense.

49
? LottieFiles. (n.d.). Md Maruf. [online] Available at: https://lottiefiles.com/qvessfriim.
* This animation was edited and changed but created by Issey in lottie files, under the Simple lottie Lisense.

50
? LottieFiles. (n.d.). Tamojit Das. [online] Available at: https://lottiefiles.com/animations/water-splash-rrD8jCHcFi?from=search.
* This animation was edited and changed but created by Issey in lottie files, under the Simple lottie Lisense.
 
51
? Klein-baer, R. (2022). How to Model Healthy Coping Skills. [online] Child Mind Institute. Available at: https://childmind.org/article/how-to-model-healthy-coping-skills/.
* This website I used to gain information on scientific information around coping mechanism for kids, for the coping mechanism page.
‌

52
? Dart packages. (n.d.). flutter_painter_themedata example | Flutter package. [online] Available at: https://pub.dev/packages/flutter_painter_themedata/example [Accessed 1 Feb. 2024].
? CustomPainter for pulsating circles

* Adding the circle animation for the breathing animation.
* Code assisted by Stack Overflow.
* PulsatingCirclesPainter defines the custom painting logic for the pulsating circles
* that visualizes the breathing exercise.


*/
 
/*
53
? Coping Skills for Kids. (2016). Coping Skill Spotlight: Take a Mindful Walk. [online] Available at: https://copingskillsforkids.com/blog/coping-skill-spotlight-take-a-mindful-walk [Accessed 5 Apr. 2024].
* This website assisted me in writing my descriptions for the coping description page.
‌54
? https://www.helpguide.org. (n.d.). Social Support for Stress Relief - HelpGuide.org. [online] Available at: https://www.helpguide.org/articles/stress/social-support-for-stress-relief.htm#:~:text=While%20a%20text%20or%20phone.
* Gathered information recarding social interaction for the social interaciton card on the coping page.
55
? Gray, A. (2022). How does music affect your mood and reduce stress. [online] PPL PRS. Available at: https://pplprs.co.uk/health-wellbeing/music-reduce-stress/.
* Gathered information for the music card page, to show the benefits of using music as a coping mechansim.
‌
56
? www.urmc.rochester.edu. (n.d.). Journaling for Mental Health - Health Encyclopedia - University of Rochester Medical Center. [online] Available at: https://www.urmc.rochester.edu/encyclopedia/content.aspx?ContentID=4552&ContentTypeID=1#:~:text=Write%20or%20draw%20whatever%20feels.
* Gathered information on how to journal, and the benefits of journalling.
‌
57
? Barnardo’s. (n.d.). What is anxiety? [online] Available at: https://www.barnardos.org.uk/blog/what-anxiety?gclsrc=aw.ds&gad_source=1&gclid=CjwKCAjwwr6wBhBcEiwAfMEQs5BGDO4ugzhZ562pLTv5dg4ErmynVbhmpXzcOM6TVw-riGlc7eF2LhoCNpYQAvD_BwE [Accessed 5 Apr. 2024].
* Gathering information on how to practise breathing.
‌
58
? Philadelphia, T.C.H. of (2018). The Power of Yoga Breathing for Children. [online] www.chop.edu. Available at: https://www.chop.edu/news/health-tip/power-yoga-breathing-children#:~:text=Three%2Dpart%20breathing%20brings%20a [Accessed 5 Apr. 2024].
* Gathering information on breathing techniques like yoga breathing and presenting an example in the card.

59
? Childrens.com. (2020). Breathing Exercises for Kids – Children’s Health. [online] Available at: https://www.childrens.com/health-wellness/breathing-exercises-for-kids#:~:text=%22Children%20can%20use%20deep%20breathing [Accessed 5 Apr. 2024].
* Gathering informaiton on how breathing is helpful for children.
‌
60
? Science of Spirituality. (n.d.). Benefits from Meditation|Improve Health>Reduce Anxiety>Enhance Emotional Wellbeing. [online] Available at: https://www.sos.org/benefits-from-meditation/?gad_source=1&gclid=CjwKCAjwwr6wBhBcEiwAfMEQs5L9z1E0Hu_4SoEb96hPbSR_WhsGXukS75fhmb4cpfHCTZbb00B0JhoC3u8QAvD_BwE [Accessed 5 Apr. 2024].
* Gathering informaiton on how meditation is helpful for children.
‌
61
? Staff, M. (2019). How to meditate. [online] Mindful. Available at: https://www.mindful.org/how-to-meditate/.
* Gathering informaiton on how to meditate.
‌
62
? www.annafreud.org. (n.d.). Distraction techniques. [online] Available at: https://www.annafreud.org/resources/children-and-young-peoples-wellbeing/self-care/distraction-techniques/#:~:text=Having%20distraction%20techniques%20can%20help.
* Gathering informaiton on distractions.
‌
63
? Mental Health Foundation (2022). Pets and mental health. [online] www.mentalhealth.org.uk. Available at: https://www.mentalhealth.org.uk/explore-mental-health/a-z-topics/pets-and-mental-health.
* Gathering informaiton on mental health and pets.
‌
64
? www.stylist.co.uk. (n.d.). Need an instant reset? Try splashing your face with cold water. [online] Available at: https://www.stylist.co.uk/health/mental-health/cold-water-splashing-face-benefits-anxiety-stress/870541 [Accessed 5 Apr. 2024].
* Splashing water technique
‌
65
? www.annafreud.org. (n.d.). Warm bath. [online] Available at: https://www.annafreud.org/resources/children-and-young-peoples-wellbeing/self-care/warm-bath/#:~:text=refreshing%20and%20calming.-.
* Bath benefits.

‌66
? Vanik, J. (2021). Ice Cube Hack for Panic Attacks - Be Present Ohio. [online] Available at: https://bepresentohio.org/ice-cube-hack-for-panic-attacks/#:~:text=The%20ice%20can%20also%20trigger [Accessed 5 Apr. 2024].
* Gathering informaiton on icecubes and coping techniques.

67
? educationhub.blog.gov.uk. (n.d.). Mental health resources for children, students, parents, carers and school/college staff - The Education Hub. [online] Available at: https://educationhub.blog.gov.uk/2021/09/03/mental-health-resources-for-children-parents-carers-and-school-staff/.
* Information resources numbers for children for the help card.
‌
‌
*/
/*

68

* Image icons used for the coping mechanism page.
? Flaticon. (n.d.). 116,406 Free icons of child. [online] Available at: https://www.flaticon.com/free-icons/child.

? Flaticon. (n.d.). 116,406 Walking icon. [online] Available at: https://www.flaticon.com/free-icon/walking-to-school_835886?term=walk+kid&page=1&position=1&origin=search&related_id=835886.

? Flaticon. (n.d.). 116,406 Jorunal. [online] Available at: https://www.flaticon.com/free-icon/journal_2708780?term=journal&page=1&position=8&origin=search&related_id=2708780. 

? Flaticon. (n.d.). 116,406 Phone. [online] Available at: https://www.flaticon.com/free-icon/phone-call_455705?term=call&page=1&position=3&origin=search&related_id=455705. 

? Flaticon. (n.d.). 116,406 Heaphones. [online] Available at: https://www.flaticon.com/free-icon/headphones_3791429?term=headphone&page=1&position=6&origin=search&related_id=3791429. 

? Flaticon. (n.d.). 116,406 Ice. [online] Available at: https://www.flaticon.com/free-icon/ice-cube_2458132?term=ice&page=1&position=3&origin=search&related_id=2458132. 

? Flaticon. (n.d.). 116,406 Water. [online] Available at: https://www.flaticon.com/free-icon/drops_599508?term=splash&page=1&position=16&origin=search&related_id=599508. 

? Flaticon. (n.d.). 116,406 Meditation. [online] Available at: https://www.flaticon.com/free-icon/meditation_2906496?term=meditation&page=1&position=1&origin=search&related_id=2906496.

? Flaticon. (n.d.). 116,406 Pets. [online] Available at: https://www.flaticon.com/free-icon/pets_3460335?term=pet&page=1&position=7&origin=search&related_id=3460335.

? Flaticon. (n.d.). 116,406 Paint. [online] Available at:https://www.freepik.com/icon/painting_9250268#fromView=search&page=1&position=11&uuid=b3abb647-9b4a-4e13-9d92-b454dfe42fec

? Flaticon. (n.d.). 116,406 Help. [online] Available at:https://www.freepik.com/icon/help_2597143#fromView=search&page=1&position=30&uuid=5bcc30ac-35c0-4b70-bcde-b9b5d54f887b.


 */


