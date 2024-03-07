import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class JournalEntriesPage extends StatefulWidget {
  const JournalEntriesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JournalEntriesPageState createState() => _JournalEntriesPageState();
}

class _JournalEntriesPageState extends State<JournalEntriesPage> {
  late TextEditingController _textController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _saveJournalEntry(String entry, String userId) async {
    Timestamp currentTime = Timestamp.now();

    try {
      await _firestore.collection('JournalEntries').add({
        'entry': entry,
        'time': currentTime,
        'user': userId,
      });
      logger.i('Journal entry saved to Firestore with userId: $userId');
    } catch (e) {
      logger.e('Error saving journal entry: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
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
                    offset: const Offset(0, 3),
                  ),
                ],
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
            const SizedBox(height: 20),
            SizedBox(height: 20),
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
          ],
        ),
      ),
    );
  }
}
