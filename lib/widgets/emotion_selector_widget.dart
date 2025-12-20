import 'package:flutter/material.dart';
import 'package:BreathSpace/l10n/app_localizations.dart';

enum Emotion {
  tired(Icons.bedtime_rounded, "emotionTired", Colors.blue),
  stressed(Icons.sentiment_very_dissatisfied_rounded, "emotionStressed", Colors.orange),
  angry(Icons.mood_bad_rounded, "emotionAngry", Colors.red),
  sad(Icons.sentiment_dissatisfied_rounded, "emotionSad", Colors.indigo),
  excited(Icons.sentiment_very_satisfied_rounded, "emotionExcited", Colors.green),
  calm(Icons.sentiment_satisfied_rounded, "emotionCalm", Colors.teal);

  const Emotion(this.icon, this.labelKey, this.color);
  final IconData icon;
  final String labelKey;
  final Color color;

  String getLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (labelKey) {
      case "emotionTired":
        return l10n.emotionTired;
      case "emotionStressed":
        return l10n.emotionStressed;
      case "emotionAngry":
        return l10n.emotionAngry;
      case "emotionSad":
        return l10n.emotionSad;
      case "emotionExcited":
        return l10n.emotionExcited;
      case "emotionCalm":
        return l10n.emotionCalm;
      default:
        return labelKey;
    }
  }
}

class EmotionSelectorWidget extends StatefulWidget {
  final Function(Emotion) onEmotionSelected;
  final bool constrainWidth;

  const EmotionSelectorWidget({
    super.key,
    required this.onEmotionSelected,
    this.constrainWidth = true,
  });

  @override
  State<EmotionSelectorWidget> createState() => _EmotionSelectorWidgetState();
}

class _EmotionSelectorWidgetState extends State<EmotionSelectorWidget>
    with TickerProviderStateMixin {
  Emotion? _selectedEmotion;
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _bounceAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  void _onEmotionTap(Emotion emotion) {
    setState(() {
      _selectedEmotion = emotion;
    });
    
    // Small scale animation instead of bounce
    _bounceController.forward().then((_) {
      _bounceController.reverse();
    });
    
    // Immediate callback for more responsive feel
    widget.onEmotionSelected(emotion);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          
          // Emotion selector with larger, more playful design
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive grid that adapts to screen size
                int crossAxisCount;
                double childAspectRatio;
                double cardSize;
                
                if (constraints.maxWidth < 400) {
                  // Small phones: 2 columns
                  crossAxisCount = 2;
                  childAspectRatio = 1.0;
                  cardSize = 90;
                } else if (constraints.maxWidth < 600) {
                  // Large phones: 2 columns, larger cards
                  crossAxisCount = 2;
                  childAspectRatio = 1.0;
                  cardSize = 110;
                } else if (constraints.maxWidth < 900) {
                  // Tablets: 3 columns
                  crossAxisCount = 3;
                  childAspectRatio = 1.0;
                  cardSize = 90;
                } else {
                  // Desktop: 6 columns
                  crossAxisCount = 6;
                  childAspectRatio = 1.0;
                  cardSize = 80;
                }

                // Calculate how many items fit in one row to determine peek
                final itemsPerRow = crossAxisCount;
                final totalItems = Emotion.values.length;
                final rowsNeeded = (totalItems / itemsPerRow).ceil();
                final maxVisibleRows = (constraints.maxHeight / (140 + 16)).floor(); // card height + spacing
                
                // Show peek by setting max height to show slightly more than visible rows
                final showPeek = rowsNeeded > maxVisibleRows;
                final maxGridHeight = showPeek 
                    ? (maxVisibleRows + 0.3) * (140 + 16) // Show 30% of next row
                    : double.infinity;

                return Container(
                  constraints: BoxConstraints(
                    maxHeight: maxGridHeight,
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemCount: Emotion.values.length,
                    itemBuilder: (context, index) {
                      final emotion = Emotion.values[index];
                      final isSelected = _selectedEmotion == emotion;
                      return _buildEmotionCard(emotion, isSelected, cardSize);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionCard(Emotion emotion, bool isSelected, double iconSize) {
    return AnimatedBuilder(
      animation: isSelected ? _bounceAnimation : const AlwaysStoppedAnimation(1.0),
      builder: (context, child) {
        return Transform.scale(
          scale: isSelected ? _bounceAnimation.value : 1.0,
          child: GestureDetector(
            onTap: () => _onEmotionTap(emotion),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isSelected
                      ? [
                          emotion.color.withValues(alpha: 0.3),
                          emotion.color.withValues(alpha: 0.1),
                        ]
                      : [
                          Colors.white.withValues(alpha: 0.9),
                          Colors.white.withValues(alpha: 0.7),
                        ],
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected ? emotion.color : Colors.grey.shade300,
                  width: isSelected ? 4 : 2,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: emotion.color.withValues(alpha: 0.4),
                          blurRadius: 20,
                          spreadRadius: 3,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Large, playful icon with background circle
                  Container(
                    width: iconSize,
                    height: iconSize,
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? emotion.color.withValues(alpha: 0.2)
                          : emotion.color.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? emotion.color : emotion.color.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      emotion.icon,
                      size: iconSize * 0.6,
                      color: emotion.color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    emotion.getLabel(context),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? emotion.color : Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
