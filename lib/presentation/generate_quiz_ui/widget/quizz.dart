import 'package:bytebrain_project_akhir/presentation/generate_quiz_ui/result_screen.dart';
import 'package:flutter/material.dart';

class QuizzWidget extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const QuizzWidget({super.key, required this.data});

  @override
  State<QuizzWidget> createState() => _QuizzWidgetState();
}

class _QuizzWidgetState extends State<QuizzWidget> {
  int _currentQuestionIndex = 0;
  int _selectedAnswerIndex = -1;
  int _score = 0;
  void _selectAnswer(int index) {
    setState(() {
      if (_selectedAnswerIndex == -1) {
        _selectedAnswerIndex = index;
      }
    });
  }

  void _nextQuestion(questions) {
    if ((questions[_currentQuestionIndex]['answers']
        as List)[_selectedAnswerIndex]['isCorrect'] as bool) {
      _score++;
    }

    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswerIndex = -1;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: _score,
            totalQuestions: questions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.indigo,
                  child: Text(
                    '${_currentQuestionIndex + 1}',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Question ${_currentQuestionIndex + 1}/${widget.data.length}',
                  style: const TextStyle(fontSize: 18, color: Colors.indigo),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.data[_currentQuestionIndex]['questionText'] as String,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(
              (widget.data[_currentQuestionIndex]['answers'] as List).length,
              (index) {
                final answer = (widget.data[_currentQuestionIndex]['answers']
                    as List)[index];
                Color borderColor = Colors.grey.shade300;
                Color textColor = Colors.black;

                if (_selectedAnswerIndex != -1) {
                  if (index == _selectedAnswerIndex) {
                    borderColor = (widget.data[_currentQuestionIndex]['answers']
                            as List)[index]['isCorrect'] as bool
                        ? Colors.blue
                        : Colors.red;
                    textColor = (widget.data[_currentQuestionIndex]['answers']
                            as List)[index]['isCorrect'] as bool
                        ? Colors.blue
                        : Colors.red;
                  } else if ((widget.data[_currentQuestionIndex]['answers']
                      as List)[index]['isCorrect'] as bool) {
                    textColor = Colors.blue;
                    borderColor = Colors.blue;
                  }
                }

                return GestureDetector(
                  onTap: () => _selectAnswer(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: borderColor,
                          child: Text(
                            String.fromCharCode(65 + index),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            answer['label'] as String,
                            style: TextStyle(fontSize: 18, color: textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 60.0,
            ),
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / widget.data.length,
              backgroundColor: Colors.blue.shade100,
              color: Colors.indigo,
            ),
            const SizedBox(
              height: 60.0,
            ),
            ElevatedButton(
              onPressed: () {
                _nextQuestion(widget.data);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                _currentQuestionIndex < widget.data.length - 1
                    ? 'Selanjutnya'
                    : 'Finish',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
