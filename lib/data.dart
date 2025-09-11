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
