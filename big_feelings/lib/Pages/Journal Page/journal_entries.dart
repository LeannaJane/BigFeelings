import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Pages/Login/login_logic.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class JournalEntriesPage extends StatefulWidget {
  // ignore: use_super_parameters
  const JournalEntriesPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _JournalEntriesPageState createState() => _JournalEntriesPageState();
}

class _JournalEntriesPageState extends State<JournalEntriesPage> {
  //! This is a controller for a text input field.
  late TextEditingController _textController;
  //! This is a firestore instance for database operations.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //! Below shows an empty entries list to store journal entries and variables, for currently focused day in the calender and currently
  //! selected day in the calender.
  late List<DocumentSnapshot> _entries = [];
  late DateTime _focusedDay;

  //! Below shows a initstate method being overwritten, and it initalises a text controller for handing
  //! text input, and sets the focused day to this day, and the selected day to the date now. Then it using the method
  //! retrieve method it retireves all te entries from the specific user that is signed in.
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _focusedDay = DateTime.now();
    retrieveEntries();
  }

  //! Releasing resources from above widgets.
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  //! This method retrieves the current user from firebase. then if the user is not null (is found) it
  //! queries the firestore collection JournalEntries and where the user is equal to the user id saved during the login.
  //! Thne it sets the state and updates the entries.
  void retrieveEntries() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final querySnapshot = await _firestore
          .collection('JournalEntries')
          .where('user', isEqualTo: user.uid)
          .get();
      setState(() {
        _entries.clear();
        _entries = querySnapshot.docs;
      });
    }
  }

  //! This method checks whether there is an existing journal from firebase with a matching date.
  //! This method uses converters to convert the datetime into a date format.
  bool _hasEntryForDate(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    final dateString = formatter.format(date);
    return _entries.any((entry) {
      final entryDate = (entry['time'] as Timestamp).toDate();
      return formatter.format(entryDate) == dateString;
    });
  }

  void _saveJournalEntry(
      String entry, String userId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('JournalEntries').add({
        'entry': entry,
        'time': Timestamp.now(),
        'user': userId,
      });
      logger.i('Journal entry saved successfully! User ID: $userId');
      retrieveEntries();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Journal entry saved successfully!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      logger.e('Error saving journal entry: $e. User ID: $userId');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Error saving journal entry. Please try again.',
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

  TextStyle getRegularFontStyle(FontProvider fontProvider,
      {double fontSize = 16.0}) {
    return fontProvider.fontstylenotbald(fontSize: fontSize);
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Consumer<FontProvider>(builder: (context, fontProvider, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Journal Page',
            style: fontProvider.getOtherTitleStyle(),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        //! Adding a single scroll view to allow the user to scroll if their device is too small, and to reduce exceptions.
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  //! Added a clipRRect to make sure that the corners for all the corners of the container does not get cut of or disapear.
                  //! When I didn't use a clip RRect the corners either at the top corners or the bottom would vanish due to the text field content being overflown.
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    child: TextField(
                      controller: _textController,
                      maxLines: 10,
                      style: fontProvider.smalltextfontstyle(),
                      decoration: InputDecoration(
                        hintText: 'Write your feelings here...',
                        filled: true,
                        hoverColor: Colors.transparent,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(12.0),
                        hintStyle: fontProvider.smalltextfontstyle(),
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                //! When the save buttons pressed, it checks if the user is not null and if there is an authenticated user,
                //! The journal will be saved to firebase with the text and the user Id.
                //! If they're not logged in the console will output the logger exception.

                //! Changing to a container to allow shadow around the box.
                Center(
                  //! Wrapping the GestureDetector with a Center widget to center the button, as I had an issue with the width not changing because of this.
                  child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    child: InkWell(
                      onTap: () {
                        if (_textController.text.isNotEmpty) {
                          if (user != null) {
                            _saveJournalEntry(
                                _textController.text, user.uid, context);
                            _textController.clear();
                          } else {
                            logger.e('User is not logged in.');
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please type something before saving.',
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
                      },
                      //! Changing the elevated button to a container to allow to customise and add shadows around the corntainer for consistency.
                      splashColor: Colors.blue,
                      borderRadius: BorderRadius.circular(40.0),
                      child: Container(
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Save Entry',
                            style: fontProvider.getSubTitleStyle(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //! Adding space between the save button and calender.
                const SizedBox(height: 20),
                //! This displays a calender with a entry status, so if the user has entried, the selected days will be in a certain
                //! The first date is set to the first date of 2024, as the application does not allow users to submit a date,
                //! and the app has only just been created, so it serves no point adding past years. unless a select date and time is added to the submission of the entries.
                TableCalendar(
                  //! First date of the calender.
                  firstDay: DateTime.utc(2024, 01, 01),
                  //! Last date of the calender.
                  lastDay: DateTime.utc(2030, 3, 14),
                  //! This is the current focused day on the calendar
                  focusedDay: _focusedDay,

                  //! If the user has entered a journal it will go dark blue.
                  selectedDayPredicate: (DateTime date) {
                    return _hasEntryForDate(date);
                  },

                  //! This sets the currently focused day to the selected day
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },
                  //! This line of code specifies the format for the calender, and it shows the month in the center.
                  calendarFormat: CalendarFormat.month,
                  //! Then this defines the styles for the calender cells. So each of these different styles can be found by
                  //! Selected the calenderStyle class and inputting the ones needed and applying the font style.
                  calendarStyle: CalendarStyle(
                    //! I set this to false, this checks whether to show days outside of the current month
                    outsideDaysVisible: false,
                    //! Default text style for calendar cells
                    defaultTextStyle: fontProvider.fontstylenotbald(),
                    //! Text style for today's date
                    todayTextStyle: fontProvider.fontstylenotbald(),
                    //! Text style for selected date
                    selectedTextStyle: fontProvider.fontstylenotbald(),
                    //! Text style for weekend days
                    weekendTextStyle: fontProvider.fontstylenotbald(),
                    //! Text style for holiday days
                    holidayTextStyle: fontProvider.fontstylenotbald(),
                    //! Text style for the start of a date range
                    rangeStartTextStyle: fontProvider.fontstylenotbald(),
                    //! Text style for the end of a date range
                    rangeEndTextStyle: fontProvider.fontstylenotbald(),
                    //! Text style for disabled dates
                    disabledTextStyle: fontProvider.fontstylenotbald(),
                    //! Text style for week numbers
                    weekNumberTextStyle: fontProvider.fontstylenotbald(),
                    selectedDecoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  //! This code block defines the style for the calender header.
                  headerStyle: HeaderStyle(
                    //! I set this to false, this checks whether to show the format button
                    formatButtonVisible: false,
                    //! Text style for the title
                    titleTextStyle: fontProvider.fontstylenotbald(),
                    //! Icon for navigating to the previous and next month
                    leftChevronIcon: const Icon(Icons.chevron_left,
                        color: Colors.black, size: 20),
                    rightChevronIcon: const Icon(Icons.chevron_right,
                        color: Colors.black, size: 20),
                    //! Margin for the  chevron icon
                    leftChevronMargin: EdgeInsets.zero,
                    rightChevronMargin: EdgeInsets.zero,
                    titleCentered: true,
                    //! This is a formatter for the title text
                    titleTextFormatter: (date, locale) =>
                        DateFormat.yMMM(locale).format(date),
                  ),
                  //! This code defines the style for the days of the week
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: fontProvider.fontstylenotbald(),
                    weekendStyle: fontProvider.fontstylenotbald(),
                  ),
                  availableCalendarFormats: const {CalendarFormat.month: ''},
                  startingDayOfWeek: StartingDayOfWeek.monday,
                ),
                //! Adding space.
                const SizedBox(height: 20),
                //! Added a row that shows the colour and a piece of text to desribe the circle colour meaning on the calender underneath it.

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Journal entries saved',
                      style: fontProvider.getSubTitleStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'No journal saved today',
                      style: fontProvider.getSubTitleStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
