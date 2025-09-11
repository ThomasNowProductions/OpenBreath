import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'exercise_screen.dart';

class BreathingExercise {
  final String title;
  final String pattern;
  final String duration;
  final String intro;

  const BreathingExercise({
    required this.title,
    required this.pattern,
    required this.duration,
    required this.intro,
  });
}

const List<BreathingExercise> breathingExercises = [
  BreathingExercise(
    title: 'Box Breathing',
    pattern: '4-4-4-4',
    duration: '4 min',
    intro: 'A simple technique to calm your mind and body.',
  ),
  BreathingExercise(
    title: '4-7-8 Breathing',
    pattern: '4-7-8',
    duration: '3 min',
    intro: 'Helps to relax and fall asleep faster.',
  ),
  BreathingExercise(
    title: 'Coherent Breathing',
    pattern: '5-5',
    duration: '5 min',
    intro: 'Balances the nervous system and promotes relaxation.',
  ),
  BreathingExercise(
    title: 'Calm Focus',
    pattern: '6-2-4',
    duration: '3 min',
    intro: 'Improve concentration and mental clarity.',
  ),
  BreathingExercise(
    title: 'Stress Release',
    pattern: '4-0-6-0',
    duration: '2 min',
    intro: 'Release tension and promote relaxation.',
  ),
];

void main() {
  runApp(const OpenBreathApp());
}

class OpenBreathApp extends StatelessWidget {
  const OpenBreathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenBreath',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.white,
      ),
      home: const BreathingExerciseScreen(),
    );
  }
}

class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({super.key});

  @override
  State<BreathingExerciseScreen> createState() => _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: breathingExercises.length,
            itemBuilder: (context, index) {
              final exercise = breathingExercises[index];
              return Center(
                child: Card(
                  color: Colors.grey[800], // Grey card background
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          exercise.title,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          exercise.pattern,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          exercise.duration,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          exercise.intro,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 60),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExerciseScreen(pattern: exercise.pattern)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(40),
                          ),
                          child: const Text(
                            'START',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          if (defaultTargetPlatform == TargetPlatform.windows ||
              defaultTargetPlatform == TargetPlatform.linux ||
              defaultTargetPlatform == TargetPlatform.macOS) ...[
            Positioned(
              left: 10,
              top: 0,
              bottom: 0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 50),
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
              ),
            ),
            Positioned(
              right: 10,
              top: 0,
              bottom: 0,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 50),
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}