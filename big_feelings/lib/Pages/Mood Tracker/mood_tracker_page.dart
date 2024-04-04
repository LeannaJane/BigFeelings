// ignore_for_file: library_private_types_in_public_api, use_super_parameters, use_build_context_synchronously

import 'dart:async';

import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Mood%20Tracker/moods.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

final logger = Logger();

class MoodTrackerPage extends StatefulWidget {
  const MoodTrackerPage({Key? key}) : super(key: key);

  @override
  _MoodTrackerPageState createState() => _MoodTrackerPageState();
}

class _MoodTrackerPageState extends State<MoodTrackerPage> {
  late int selectedEmotionIndex;

  bool showImage = true;
  bool showDescription = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late DateTime _focusedDay;

  bool isDesktop2(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return width > 550;
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

  @override
  void initState() {
    super.initState();
    selectedEmotionIndex = 0;
    _focusedDay = DateTime.now();
    retrieveEntries();
  }

  void _navigateForward() {
    setState(() {
      selectedEmotionIndex = (selectedEmotionIndex + 1) % moods.length;
      showDescription = false;
    });
  }

  void _navigateBackward() {
    setState(() {
      selectedEmotionIndex =
          (selectedEmotionIndex - 1 + moods.length) % moods.length;
      showDescription = false;
    });
  }

  late List<DocumentSnapshot> _moods = [];

  void retrieveEntries() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final querySnapshot = await _firestore
            .collection('MoodsCollection')
            .where('user', isEqualTo: user.uid)
            .get();
        setState(() {
          _moods = querySnapshot.docs;
        });
      } catch (e) {
        logger.e('Error retrieving mood entries: $e');
      }
    } else {
      logger.e('User is not logged in.');
    }
  }

  bool _hasEntryForDate(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    final dateString = formatter.format(date);

    return _moods.any((mood) {
      final entryDate = (mood['time'] as Timestamp).toDate();
      final entryDateString = formatter.format(entryDate);
      return entryDateString == dateString;
    });
  }

  DateTime? _lastMoodEntryTime;
  Timer? _debounceTimer;
  int _moodSelectionCount = 0;

  void _saveMoodToFirestore(
    String mood,
    String userId,
    FontProvider fontProvider,
    ThemeNotifier themeNotifier,
    BuildContext context,
  ) async {
    //! Cancel the previous debounce timer
    _debounceTimer?.cancel();

    if (_lastMoodEntryTime != null) {
      //! Calculate the difference between the current time and the last mood entry time
      Duration difference = DateTime.now().difference(_lastMoodEntryTime!);

      //! Checks if the difference is less than a minute (60 seconds)
      if (difference.inSeconds < 60) {
        //! If mood has been selected more than 2 times within a minute, ignore the touch input
        if (_moodSelectionCount >= 3) {
          return;
        }
        //! Otherwise, increment the mood selection count and display the cooldown message
        _moodSelectionCount++;
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
          _moodSelectionCount = 0; //! Resets the mood selection count
        });
        return;
      }
    }

    //! If there's no cooldown save the mood entry
    Timestamp currentTime = Timestamp.now();
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('MoodsCollection').add({
        'mood': mood,
        'time': currentTime,
        'user': userId,
      });

      //! Update the time of the last mood entry and reset the mood selection count
      _lastMoodEntryTime = DateTime.now();
      _moodSelectionCount = 0;

      logger.i('Mood saved to Firestore with userId: $userId');
      retrieveEntries();
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
      logger.e('Error saving mood: $e');
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
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
                                          30, 20, 30, 30),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: getContainerColor,
                                      ),
                                      child: showDescription
                                          ? Center(
                                              child: Text(
                                                moodDescriptions[moods[
                                                        selectedEmotionIndex]] ??
                                                    '',
                                                style: fontProvider
                                                    .subheadinglogin(
                                                        themeNotifier),
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
                                    child: Text(
                                      moods[selectedEmotionIndex],
                                      style: fontProvider
                                          .subheadinglogin(themeNotifier),
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
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        User? user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          _saveMoodToFirestore(moods[selectedEmotionIndex],
                              user.uid, fontProvider, themeNotifier, context);
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
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: _focusedDay,
                            selectedDayPredicate: (DateTime date) {
                              return _hasEntryForDate(date);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                _focusedDay = focusedDay;
                              });
                            },
                            calendarFormat: CalendarFormat.month,
                            calendarStyle: CalendarStyle(
                              outsideDaysVisible: false,
                              defaultTextStyle: fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
                              todayTextStyle: fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
                              selectedTextStyle: fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
                              weekendTextStyle: fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
                              holidayTextStyle: fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
                              rangeStartTextStyle:
                                  fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
                              rangeEndTextStyle: fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
                              disabledTextStyle: fontProvider.fontstylenotbald(
                                themeNotifier: themeNotifier,
                              ),
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
                            headerStyle: HeaderStyle(
                              formatButtonVisible: false,
                              titleTextStyle: fontProvider.calenderText(
                                themeNotifier: themeNotifier,
                              ),
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
                              leftChevronMargin: EdgeInsets.zero,
                              rightChevronMargin: EdgeInsets.zero,
                              titleCentered: true,
                              titleTextFormatter: (date, locale) =>
                                  DateFormat.yMMM(locale).format(date),
                            ),
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
                                  'Mood entries saved',
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
                                  'No Mood entry saved today',
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
