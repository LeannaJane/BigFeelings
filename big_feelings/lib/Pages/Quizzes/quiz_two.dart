import 'package:flutter/material.dart';

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
