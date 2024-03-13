import 'package:flutter/material.dart';

class QuizzesPage extends StatefulWidget {
  const QuizzesPage({Key? key}) : super(key: key);

  @override
  _QuizzesPageState createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  final List<Map<String, dynamic>> _quizData = [
    {
      'question': 'Question 1',
      'options': ['1', '2', '3', '4'],
      'correctAnswer': '1',
    },
    {
      'question': 'Question 2',
      'options': ['1', '2', '3', '4'],
      'correctAnswer': '2',
    },
    {
      'question': 'Question 3',
      'options': ['1', '2', '3', '4'],
      'correctAnswer': '3',
    },
    {
      'question': 'Question 4',
      'options': ['1', '2', '3', '4'],
      'correctAnswer': '4',
    },
  ];

  void _answerQuestion(String selectedAnswer) {
    String correctAnswer = _quizData[_currentQuestionIndex]['correctAnswer'];
    if (selectedAnswer == correctAnswer) {
      setState(() {
        _score++;
      });
    }
    _nextQuestion();
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= _quizData.length) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Result'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You completed the quiz!'),
              Text('Your score: $_score out of ${_quizData.length}'),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentQuestionIndex = 0;
                    _score = 0;
                  });
                },
                child: const Text('Restart Quiz'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Question ${_currentQuestionIndex + 1}:',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _quizData[_currentQuestionIndex]['question'],
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          ...(_quizData[_currentQuestionIndex]['options'] as List<String>)
              .map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue:
                  null, // You can use this to keep track of selected answer
              onChanged: (value) {
                _answerQuestion(value!);
              },
            );
          }),
          const SizedBox(height: 16.0),
          Center(
            child: ElevatedButton(
              onPressed: _nextQuestion,
              child: Text(_currentQuestionIndex == _quizData.length - 1
                  ? 'Submit'
                  : 'Next'),
            ),
          ),
        ],
      ),
    );
  }
}
