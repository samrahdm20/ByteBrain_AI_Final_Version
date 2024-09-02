import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                const Text(
                  'Generating Quizzes...',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  height: 120,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "lorem",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ...List.generate(4, (index) {
                  Color buttonColor = const Color.fromARGB(255, 198, 197, 197);

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Row(
                        children: [
                          const Padding(padding: EdgeInsets.only(left: 20.0)),
                          Text(
                            '${String.fromCharCode(65 + index)}. ',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                          const Text(
                            "lorem",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                LinearProgressIndicator(
                  value: 2 / 5,
                  backgroundColor: Colors.blue.shade100,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ));
  }
}
