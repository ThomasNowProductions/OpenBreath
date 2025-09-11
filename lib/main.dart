import 'package:flutter/material.dart';
import 'exercise_screen.dart';
import 'settings_screen.dart'; // Import the new settings screen
import 'package:provider/provider.dart';
import 'package:OpenBreath/theme_provider.dart';
import 'package:OpenBreath/data.dart'; // Import the data file
import 'package:OpenBreath/search_screen.dart'; // Import the search screen

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const OpenBreathApp(),
    ),
  );
}

class OpenBreathApp extends StatelessWidget {
  const OpenBreathApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.black,
      fontFamily: 'GFS Didot',
      cardColor: Colors.grey[200], // Card color for light mode
      colorScheme: const ColorScheme.light(
        primary: Colors.black,
        secondary: Colors.black, // A color for the bubble in light mode
        onSurface: Colors.black,
      ),
    );

    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.white,
      fontFamily: 'GFS Didot',
      cardColor: Colors.grey[900], // Card color for dark mode
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        secondary: Colors.white, // A color for the bubble in dark mode
        onSurface: Colors.white,
      ),
    );

    return MaterialApp(
      title: 'OpenBreath',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
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
    _pageController = PageController(initialPage: 10000 * breathingExercises.length);
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
        children: <Widget>[
          PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              final exercise = breathingExercises[index % breathingExercises.length];
              return Center(
                child: SizedBox(
                  height: 500.0, // Fixed height for the card
                  width: 500.0, // Fixed width for the card
                  child: Card(
                    color: Theme.of(context).cardColor, // Theme-aware card background
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute content vertically
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                exercise.title,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                exercise.pattern,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Theme.of(context).colorScheme.onSurface.withAlpha((255 * 0.87).round()),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                exercise.duration,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Theme.of(context).colorScheme.onSurface.withAlpha((255 * 0.87).round()),
                                ),
                              ),
                              const SizedBox(height: 40),
                              Text(
                                exercise.intro,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.onSurface.withAlpha((255 * 0.87).round()),
                                ),
                              ),
                            ],
                          ),
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
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
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
                ),
              );
            },
          ),
          Positioned(
            top: 20,
            left: 20, // Positioned at top-left
            child: IconButton(
              icon: Icon(Icons.search, size: 30, color: Theme.of(context).colorScheme.onSurface),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
            ),
          ),
          Positioned(
            top: 20,
            right: 20, // Changed from left to right
            child: IconButton(
              icon: Icon(Icons.settings, size: 30, color: Theme.of(context).colorScheme.onSurface),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.onSurface, size: 50),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                ),
                const SizedBox(width: 50), // Space between buttons
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.onSurface, size: 50),
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}