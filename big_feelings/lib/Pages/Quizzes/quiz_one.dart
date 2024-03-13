import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Classes/font_provider.dart';

class StartQuiz1 extends StatefulWidget {
  const StartQuiz1({Key? key}) : super(key: key);

  @override
  _StartQuiz1State createState() => _StartQuiz1State();
}

class _StartQuiz1State extends State<StartQuiz1> {
  List<Map<String, dynamic>> quizData = [];
  int currentQuestionIndex = 0;
  List<String?> userAnswers = [];

  @override
  void initState() {
    super.initState();
    fetchQuizData();
  }

  Future<void> fetchQuizData() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentSnapshot quizSnapshot =
          await firestore.collection('QuizCollection').doc('Quiz 1').get();

      Map<String, dynamic> data = quizSnapshot.data() as Map<String, dynamic>;

      for (int i = 1; i <= 3; i++) {
        String questionKey = 'Q${i}_question';
        String optionsKey = 'Q${i}_options';

        String question = data[questionKey].toString().replaceAll('"', '');
        List<String> options = List<String>.from(data[optionsKey])
            .map((option) => option.toString().replaceAll('"', ''))
            .toList();

        quizData.add({
          'question': question,
          'options': options,
        });
      }

      userAnswers = List<String?>.filled(quizData.length, null);

      setState(() {});
    } catch (error) {
      print('Error fetching quiz data: $error');
    }
  }

  void submitAnswer(String? selectedOption) {
    userAnswers[currentQuestionIndex] = selectedOption;
    setState(() {});
  }

  void submitQuiz() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final currentTheme = themeNotifier.currentTheme;
        final fontProvider = Provider.of<FontProvider>(context);
        Color backgroundColor = currentTheme == ThemeNotifier.darkTheme
            ? Colors.grey[800]!
            : Colors.white;
        final User? user = FirebaseAuth.instance.currentUser;
        Color iconColor = themeNotifier.getIconColor();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Welcome to Quiz 1',
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
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: quizData.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 12,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Question ${currentQuestionIndex + 1}: ${quizData[currentQuestionIndex]['question']}',
                              style: fontProvider.calenderText(
                                themeNotifier: themeNotifier,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Expanded(
                              child: ListView.builder(
                                itemCount: quizData[currentQuestionIndex]
                                        ['options']
                                    .length,
                                itemBuilder: (context, index) {
                                  String option = quizData[currentQuestionIndex]
                                      ['options'][index];
                                  return RadioListTile(
                                    title: Text(
                                      option,
                                      style: fontProvider.calenderText(
                                        themeNotifier: themeNotifier,
                                      ),
                                    ),
                                    value: option,
                                    groupValue:
                                        userAnswers[currentQuestionIndex],
                                    activeColor: Colors.black,
                                    onChanged: (value) {
                                      submitAnswer(value as String?);
                                    },
                                    contentPadding:
                                        const EdgeInsets.only(left: 0),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (currentQuestionIndex > 0) {
                                setState(() {
                                  currentQuestionIndex--;
                                });
                              }
                            },
                            child: Container(
                              width: 150,
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Back',
                                  style: fontProvider.subheading(themeNotifier),
                                ),
                              ),
                            ),
                          ),
                          if (currentQuestionIndex < quizData.length - 1)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentQuestionIndex++;
                                });
                              },
                              child: Container(
                                width: 150,
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  'Next',
                                  style: fontProvider.subheading(themeNotifier),
                                )),
                              ),
                            )
                          else
                            GestureDetector(
                              onTap: submitQuiz,
                              child: Container(
                                width: 150,
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  'Save',
                                  style: fontProvider.subheading(themeNotifier),
                                )),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
