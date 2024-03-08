import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

final logger = Logger();

class JournalEntriesPage extends StatefulWidget {
  // ignore: use_super_parameters
  const JournalEntriesPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal page'),
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
                    decoration: const InputDecoration(
                      hintText: 'Write your feelings here...',
                      filled: true,
                      hoverColor: Colors.transparent,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              //! When the save buttons pressed, it checks if the user is not null and if there is an authenticated user,
              //! The journal will be saved to firebase with the text and the user Id.
              //! If they're not logged in the console will output the logger exception.
              ElevatedButton(
                onPressed: () {
                  if (_textController.text.isNotEmpty) {
                    if (user != null) {
                      _saveJournalEntry(_textController.text, user.uid);
                      _textController.clear();
                    } else {
                      logger.e('User is not logged in.');
                    }
                  }
                },
                child: const Text(
                  'Save Entry',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              //! Adding space between the save button and calender.
              const SizedBox(height: 60),
              //! This displays a calender with a entry status, so if the user has entried, the selected days will be in a certain
              //! The first date is set to the first date of 2024, as the application does not allow users to submit a date,
              //! and the app has only just been created, so it serves no point adding past years. unless a select date and time is added to the submission of the entries.
              TableCalendar(
                firstDay: DateTime.utc(2024, 01, 01),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return _hasEntryForDate(day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },
                calendarFormat: CalendarFormat.month,
                //! Removing the preformatted weeks from the calender.
                availableCalendarFormats: const {CalendarFormat.month: ''},
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    final isCurrentDay = isSameDay(date, DateTime.now());
                    final hasEntry = _hasEntryForDate(date);
                    if (isCurrentDay) {
                      //! If it is the current day, based off datetime now, if the user has saved an entry today, it'll show blue,
                      //! and if it shows red, it suggests they have not saved a journal today.
                      return Container(
                        decoration: BoxDecoration(
                          color: hasEntry ? Colors.blue : Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            //! Changes the text to white to blend better with the change of colour, this will eventually be changed.
                            date.day.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        //! If it's not the current day, the colour of the marker will be blue if there's an entry, meaning that there is a journal entry on that day,
                        //! and white it will show that there is no entry for that day.
                        decoration: hasEntry
                            ? const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              )
                            : const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                        //! Displays the day number within the marker. The text color is white if there's an entry for that day and will show black text if there is no journal entry.
                        child: Center(
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(
                              color: hasEntry ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
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
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Journal entries saved',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
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
                  const Text(
                    'No journal saved today',
                    style: TextStyle(color: Colors.red, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //! This method saves the journal entry to firebase, by saving the entry (the text) and userId to firestore database.
  void _saveJournalEntry(String entry, String userId) async {
    //! This gets the current time.
    Timestamp currentTime = Timestamp.now();
    //! This saves the user id, current time and the text entry into the firestore collection for the journal entries.
    try {
      await _firestore.collection('JournalEntries').add({
        'entry': entry,
        'time': currentTime,
        'user': userId,
      });
      //! Then if it sucessful it outputs in the console, that it is with the user id.
      logger.i('Journal entry saved to Firestore with userId: $userId');
      retrieveEntries();
      //! Displays error if unsucessful.
    } catch (e) {
      logger.e('Error saving journal entry: $e');
    }
  }
}
