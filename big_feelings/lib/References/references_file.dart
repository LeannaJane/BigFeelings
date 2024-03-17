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






