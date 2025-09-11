import 'package:flutter/material.dart';
import 'package:OpenBreath/data.dart';
import 'package:OpenBreath/exercise_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<BreathingExercise> _filteredExercises = [];

  @override
  void initState() {
    super.initState();
    _filteredExercises = breathingExercises; // Initially show all exercises
    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredExercises = breathingExercises.where((exercise) {
        return exercise.title.toLowerCase().contains(query) ||
            exercise.pattern.toLowerCase().contains(query) ||
            exercise.intro.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search exercises...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withAlpha((255 * 0.5).round())),
          ),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 18),
          cursorColor: Theme.of(context).colorScheme.onSurface,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
      ),
      body: ListView.builder(
        itemCount: _filteredExercises.length,
        itemBuilder: (context, index) {
          final exercise = _filteredExercises[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text(exercise.title, style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
              subtitle: Text(
                '${exercise.pattern} - ${exercise.duration}\n${exercise.intro}',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withAlpha((255 * 0.7).round())),
              ),
              isThreeLine: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseScreen(pattern: exercise.pattern),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
