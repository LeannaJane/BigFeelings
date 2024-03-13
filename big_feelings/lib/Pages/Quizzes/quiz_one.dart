// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';

class QuizPage1 extends StatefulWidget {
  const QuizPage1({Key? key}) : super(key: key);

  @override
  _QuizPage1State createState() => _QuizPage1State();
}

class _QuizPage1State extends State<QuizPage1> {
  bool showQuiz = false;

  void _startQuiz() {
    setState(() {
      showQuiz = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz 1'),
      ),
      body: Center(
        child: showQuiz
            ? _buildQuiz()
            : ElevatedButton(
                onPressed: _startQuiz,
                child: const Text(
                  'Start Quiz',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )),
      ),
    );
  }

  Widget _buildQuiz() {
    return const SizedBox(
      child: Text('Quiz Page 1'),
    );
  }
}
