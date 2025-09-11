import 'package:flutter/material.dart';
import 'package:OpenBreath/data.dart';
import 'package:OpenBreath/exercise_screen.dart';
import 'package:OpenBreath/l10n/app_localizations.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final BreathingExercise exercise;

  const ExerciseDetailScreen({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              exercise.title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Text(
              exercise.intro,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Pattern: ${exercise.pattern}',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Duration: ${exercise.duration}',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExerciseScreen(exercise: exercise),
                    ),
                  );
                },
                child: Text(AppLocalizations.of(context).start),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
