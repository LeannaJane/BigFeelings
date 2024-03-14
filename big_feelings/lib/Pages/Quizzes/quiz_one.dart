import 'package:big_feelings/Pages/Login/password_reset.dart';
import 'package:big_feelings/Pages/Quizzes/quiz_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Classes/font_provider.dart';

class StartQuiz1 extends StatefulWidget {
  // ignore: use_super_parameters
  const StartQuiz1({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
      quizData = await QuizFetcher.fetchQuizData('Quiz 1');
      //! Moved the fetchQuiz data to own class to reuse code.
      userAnswers = List<String?>.filled(quizData.length, null);
      setState(() {});
    } catch (error) {
      logger.e('Error submitting quiz', error: error);
    }
  }

  void submitAnswer(String? selectedOption) {
    userAnswers[currentQuestionIndex] = selectedOption;
    setState(() {});
  }

  void submitQuiz() async {
    final List<String?> initialUserAnswers = List<String?>.from(userAnswers);
    final int initialQuestionIndex = currentQuestionIndex;

    bool submissionSuccessful = await QuizSubmitter.submitQuiz(
      'Quiz 1',
      userAnswers,
      showMessage,
      quizData,
    );

    if (submissionSuccessful) {
      setState(() {
        userAnswers = List<String?>.filled(quizData.length, null);
        currentQuestionIndex = 0;
      });
    } else {
      setState(() {
        userAnswers = initialUserAnswers;
        currentQuestionIndex = initialQuestionIndex;
      });
    }
  }

  void showMessage(String message, Color color) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
        ),
      );
    }
  }

  //! This code below is reused and edited from the previous code throughout the program, to be consistent throughout the program.
  //! This code consists of a quiz page for quiz 1. This code presents a button that allows the user to start the quiz,
  //! Then the user can scroll through questions and answer them and finally save them. These questions are retrieved from firebase,
  //! Then the answers are also retrieved to check against the user answers, then a score is collected and saved to firebase.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        Color cursorColor = Provider.of<ThemeNotifier>(context).cursorColor();
        final fontProvider = Provider.of<FontProvider>(context);
        Color getContainerColor =
            Provider.of<ThemeNotifier>(context).getContainerColor();
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
                          color: getContainerColor,
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
                                    activeColor: cursorColor,
                                    onChanged: (value) {
                                      submitAnswer(value);
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
                      //! Back button container, to go back to the previous question.
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
                                color: getContainerColor,
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
                          //! Next button to view the next question.
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
                                  color: getContainerColor,
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
                          //! Save button to save results to firebase.
                          else
                            GestureDetector(
                              onTap: submitQuiz,
                              child: Container(
                                width: 150,
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: getContainerColor,
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
