// ignore_for_file: library_private_types_in_public_api, use_super_parameters, use_build_context_synchronously

import 'dart:async';

import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

final logger = Logger();

class JournalEntriesPage extends StatefulWidget {
  const JournalEntriesPage({Key? key}) : super(key: key);

  @override
  _JournalEntriesPageState createState() => _JournalEntriesPageState();
}

class _JournalEntriesPageState extends State<JournalEntriesPage> {
  //! Below shows an empty entries list to store journal entries and variables, for currently focused day in the calender and currently
  //! selected day in the calender.
  late List<DocumentSnapshot> _entries = [];
  late DateTime _focusedDay;
  //! This is a controller for a text input field.
  late TextEditingController _textController;
  //! This is a firestore instance for database operations.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  bool isDesktop(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return height > 800;
  }

  //! Checking whether the user is on dekstop or mobile to set sizes.
  bool isDesktop2(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return width > 550;
  }

  int checkssize(BuildContext context) {
    int maxLines;
    if (isDesktop(context)) {
      maxLines = 50;
    } else {
      maxLines = 50;
    }
    return maxLines;
  }
  //! Sets container width and height.

  double _containerSize(BuildContext context) {
    double containerSize;
    if (isDesktop(context)) {
      containerSize = 300;
    } else {
      containerSize = 180;
    }
    return containerSize;
  }

  double _containerSizewidth(BuildContext context) {
    double containerSize;
    if (isDesktop2(context)) {
      containerSize = 550;
    } else {
      containerSize = 350;
    }
    return containerSize;
  }

  //! This method retrieves the current user from firebase. then if the user is not null (is found) it
  //! queries the firestore collection JournalCollection and where the user is equal to the user id saved during the login.
  //! Thne it sets the state and updates the entries.

  void retrieveEntries() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final querySnapshot = await _firestore
          .collection('JournalCollection')
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

  //! Adding a debounce to stop spamming error messages, and to stop spam of sending journals.
  DateTime? _lastjournalEntryTime;
  Timer? _debounceTimer;
  int _journalSelectionCount = 0;

  void _saveJournalEntry(String entry, String userId, FontProvider fontProvider,
      ThemeNotifier themeNotifier, BuildContext context) async {
    _debounceTimer?.cancel();
    if (_lastjournalEntryTime != null) {
      //! Calculate the difference between the current time and the last journal entry time
      Duration difference = DateTime.now().difference(_lastjournalEntryTime!);

      //! Checks if the difference is less than a minute (60 seconds)
      if (difference.inSeconds < 60) {
        //! If journal has been selected more than 2 times within a minute, ignore the touch input
        if (_journalSelectionCount >= 3) {
          return;
        }
        //! Otherwise, increment the mood selection count and display the cooldown message
        _journalSelectionCount++;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please wait for a minute before making another mood entry.',
              textAlign: TextAlign.center,
              style: fontProvider.subheadinglogin(themeNotifier),
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
        //! Set a debounce timer to reset the error message and reset the mood selection count after 2 seconds
        _debounceTimer = Timer(const Duration(seconds: 2), () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          _journalSelectionCount = 0; //! Resets the journal selection count
        });
        return;
      }
    }
    try {
      await FirebaseFirestore.instance.collection('JournalCollection').add({
        'entry': entry,
        'time': Timestamp.now(),
        'user': userId,
      });

      _lastjournalEntryTime = DateTime.now();
      _journalSelectionCount = 0;
      logger.i('Journal entry saved successfully! User ID: $userId');
      retrieveEntries();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Journal entry saved successfully!',
            textAlign: TextAlign.center,
            style: fontProvider.subheadinglogin(themeNotifier),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      logger.e('Error saving journal entry: $e. User ID: $userId');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error saving journal entry. Please try again.',
            textAlign: TextAlign.center,
            style: fontProvider.subheadinglogin(themeNotifier),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  //! Below shows the UI of the Journal page, with some adaptions from the last code, to customise the journal page based on theme.
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final fontProvider = Provider.of<FontProvider>(context);
        Color getContainerColor =
            Provider.of<ThemeNotifier>(context).getContainerColor();
        Color iconColor = themeNotifier.getIconColor();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Write a journal',
              style: fontProvider.getOtherTitleStyle(themeNotifier),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            automaticallyImplyLeading:
                false, //! Creating a return icon button with the selected iconcolour and size.
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
          //! Adding a single scroll view to allow the user to scroll if their device is too small, and to reduce exceptions.
          body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: true),
            child: SingleChildScrollView(
              physics:
                  const ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //! This is the text input for the journal entry journal entry
                          //! I made one whole container for the calender and the text input.
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                padding: EdgeInsets.zero,
                                width: _containerSizewidth(context),
                                height: _containerSize(context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 6,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                  color: getContainerColor,
                                ),
                                child: ClipRRect(
                                  child: TextField(
                                    controller: _textController,
                                    maxLines: checkssize(context),
                                    style: fontProvider
                                        .smalltextfontstyle(themeNotifier),
                                    decoration: InputDecoration(
                                      //! Removed the input border and the hover colour.
                                      border: InputBorder.none,
                                      hintText: 'Write your feelings here...',
                                      fillColor:
                                          themeNotifier.getContainerColor(),
                                      hoverColor: themeNotifier.hoverColour(),
                                      contentPadding:
                                          const EdgeInsets.all(14.0),
                                      hintStyle: fontProvider
                                          .smalltextfontstyle(themeNotifier),
                                    ),
                                    cursorColor: themeNotifier.cursorColor(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_textController.text.isNotEmpty) {
                          if (user != null) {
                            _saveJournalEntry(_textController.text, user.uid,
                                fontProvider, themeNotifier, context);
                            _textController.clear();
                          } else {
                            logger.e('User is not logged in.');
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please type something before saving.',
                                textAlign: TextAlign.center,
                                style:
                                    fontProvider.subheadinglogin(themeNotifier),
                              ),
                              duration: const Duration(seconds: 2),
                              backgroundColor: Colors.red,
                            ),
                          );
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
                            'Save Journal',
                            style: fontProvider.subheadinglogin(themeNotifier),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    //! This displays a calender with a entry status, so if the user has entried, the selected days will be in a certain
                    //! The first date is set to the first date of 2024, as the application does not allow users to submit a date,
                    //! and the app has only just been created, so it serves no point adding past years. unless a select date and time is added to the submission of the entries.
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: _containerSizewidth(context),
                          margin: const EdgeInsets.symmetric(vertical: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            color: getContainerColor,
                          ),
                          child: TableCalendar(
                            firstDay: DateTime.utc(2024, 01, 01),
                            //! The last date of the calender
                            lastDay: DateTime.utc(2030, 3, 14),
                            //! This is the current focused day on the calender
                            focusedDay: _focusedDay,
                            //! If the user entered a journal it will show green if they have not it will go red.
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
                            calendarStyle: CalendarStyle(
                              //! I set this to false, this checks whether to show days outside of the current month
                              outsideDaysVisible: false,
                              //! Default text style for calendar cells
                              defaultTextStyle: fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
                              //! Text style for today's date
                              todayTextStyle: fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
                              selectedTextStyle: fontProvider.fontstylenotbald(
                                //! Text style for selected date
                                themeNotifier: themeNotifier,
                              ),
                              //! Text style for weekend days
                              weekendTextStyle: fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
                              //! Text style for holiday days
                              holidayTextStyle: fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
                              //! Text style for the start of a date range
                              rangeStartTextStyle:
                                  fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
                              //! Text style for the end of a date range
                              rangeEndTextStyle: fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
                              //! Text style for disabled dates
                              disabledTextStyle: fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
                              //! Text style for week numbers
                              weekNumberTextStyle:
                                  fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
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
                              formatButtonVisible: false,
                              //! Text style for the title
                              titleTextStyle: fontProvider.calenderText(
                                themeNotifier: themeNotifier,
                              ),
                              //! Icon for navigating to the previous and next month
                              leftChevronIcon: Icon(
                                Icons.chevron_left,
                                color: iconColor,
                                size: 20,
                              ),
                              rightChevronIcon: Icon(
                                Icons.chevron_right,
                                color: iconColor,
                                size: 20,
                              ),
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
                              weekdayStyle: fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
                              weekendStyle: fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
                            ),
                            availableCalendarFormats: const {
                              CalendarFormat.month: ''
                            },
                            startingDayOfWeek: StartingDayOfWeek.monday,
                          ),
                        ),
                        //! Journal entries status
                        //! Added a row that shows the colour and a piece of text to desribe the circle colour meaning on the calender underneath it.
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                  style: fontProvider.fontstylenotbald(
                                    themeNotifier: themeNotifier,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            //! A status shower to show users what things mean in the calender.
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
                                  'No Journal saved today',
                                  style: fontProvider.fontstylenotbald(
                                    themeNotifier: themeNotifier,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
