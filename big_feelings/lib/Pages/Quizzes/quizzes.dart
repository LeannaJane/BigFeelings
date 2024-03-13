// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';

class QuizPage1 extends StatefulWidget {
  const QuizPage1({Key? key}) : super(key: key);

  @override
  _QuizPage1State createState() => _QuizPage1State();
}

class _QuizPage1State extends State<QuizPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz 1'),
      ),
      body: const Center(
        child: Text('Quiz Page 1'),
      ),
    );
  }
}

class QuizPage2 extends StatefulWidget {
  const QuizPage2({Key? key}) : super(key: key);

  @override
  _QuizPage2State createState() => _QuizPage2State();
}

class _QuizPage2State extends State<QuizPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz 2'),
      ),
      body: const Center(
        child: Text('Quiz Page 2'),
      ),
    );
  }
}
