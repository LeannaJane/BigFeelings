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
*/



