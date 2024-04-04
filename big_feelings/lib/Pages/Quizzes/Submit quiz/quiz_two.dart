import 'package:big_feelings/Pages/Auth/Login/login_logic.dart';
import 'package:big_feelings/Pages/Quizzes/Submit%20quiz/quiz_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Classes/font_provider.dart';

class StartQuiz2 extends StatefulWidget {
  // ignore: use_super_parameters
  const StartQuiz2({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _StartQuiz2State createState() => _StartQuiz2State();
}

class _StartQuiz2State extends State<StartQuiz2> {
  List<Map<String, dynamic>> quizData = [];
  int currentQuestionIndex = 0;
  List<String?> userAnswers = [];
  //! Adding a score to the page to view see the score right after submitting.
  bool showScore = false;
  int score = 0;

  @override
  void initState() {
    super.initState();
    fetchQuizData();
  }

  Future<void> fetchQuizData() async {
    try {
      quizData = await QuizFetcher.fetchQuizData('Quiz 2');
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
    FontProvider fontProvider = FontProvider();
    ThemeNotifier themeNotifier = ThemeNotifier(ThemeNotifier.lightTheme);

    bool submissionSuccessful = await QuizSubmitter.submitQuiz(
      'Quiz 2',
      userAnswers,
      context,
      quizData,
      fontProvider,
      themeNotifier,
    );

    if (submissionSuccessful) {
      score = calculateScore();
      setState(() {
        showScore = true;
      });
      //! Calculating score when the submission is sucessful, for 5 seconds.

      await Future.delayed(const Duration(seconds: 5));

      setState(() {
        showScore = false;
      });

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

  //! A method to calculate the score by checking the quiz answers against the user answers based on the array.
  int calculateScore() {
    int score = 0;
    for (int i = 0; i < quizData.length; i++) {
      if (userAnswers[i] == quizData[i]['answer']) {
        score++;
      }
    }
    return score;
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
              'Healthy Habits',
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
          body: Stack(
            children: [
              quizData.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
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
                                      style: fontProvider.quiztextquestion(
                                        themeNotifier,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: quizData[currentQuestionIndex]
                                              ['options']
                                          .length,
                                      itemBuilder: (context, index) {
                                        String option =
                                            quizData[currentQuestionIndex]
                                                ['options'][index];
                                        return RadioListTile(
                                          title: Text(
                                            option,
                                            style: fontProvider.quiztext(
                                              themeNotifier,
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          //! Back button container, to go back to the previous question.
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
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
                                        style: fontProvider
                                            .subheading(themeNotifier),
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
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 6,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Next',
                                          style: fontProvider
                                              .subheading(themeNotifier),
                                        ),
                                      ),
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
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 6,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Save',
                                          style: fontProvider
                                              .subheading(themeNotifier),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              //! Adding a animated opacity in the center of the page, presenting the score.
              Center(
                child: AnimatedOpacity(
                  opacity: showScore ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: Visibility(
                    visible: showScore,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      color: Colors.green.withOpacity(0.8),
                      child: Center(
                        child: Text(
                          'Your score: $score/10',
                          style: fontProvider.smalltextalert(themeNotifier),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
