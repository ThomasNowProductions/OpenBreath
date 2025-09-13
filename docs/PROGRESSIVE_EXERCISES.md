# Progressive Breathing Exercises

Progressive breathing exercises allow users to gradually increase the difficulty of their breathing practice by moving through different stages with varying patterns and durations.

## Table of Contents

- [Structure](#structure)
- [JSON Format](#json-format)
- [Properties](#properties)
- [Pattern Format](#pattern-format)
- [Duration](#duration)
- [Best Practices](#best-practices)
- [Examples](#examples)

## Structure

A progressive breathing exercise consists of multiple stages, each with:
- `title`: A descriptive name for the stage
- `pattern`: The breathing pattern (e.g., "4-4-4-4")
- `duration`: The duration of the stage in seconds

## JSON Format

To create a progressive breathing exercise, use the following JSON structure:

```json
{
  "title": "Progressive Breathing Exercise",
  "stages": [
    {
      "title": "Beginner Stage",
      "pattern": "4-4-4-4",
      "duration": 120
    },
    {
      "title": "Intermediate Stage",
      "pattern": "5-5-5-5",
      "duration": 180
    },
    {
      "title": "Advanced Stage",
      "pattern": "4-5-6-7",
      "duration": 300
    }
  ],
  "intro": "A progressive breathing exercise that gradually increases in difficulty."
}
```

## Properties

### Exercise Properties
- `title`: The name of the exercise (required)
- `stages`: An array of stage objects (required for progressive exercises)
- `intro`: A brief description of the exercise (required)

### Stage Properties
- `title`: The name of the stage (required)
- `pattern`: The breathing pattern in the format "inhale-hold-exhale-hold" (required)
- `duration`: The duration of the stage in seconds (required)

## Pattern Format

The pattern format follows the structure: `inhale-hold-exhale-hold`

Examples:
- `4-4-4-4`: Inhale for 4 seconds, hold for 4 seconds, exhale for 4 seconds, hold for 4 seconds
- `4-7-8`: Inhale for 4 seconds, hold for 7 seconds, exhale for 8 seconds (no final hold)
- `5-5`: Inhale for 5 seconds, exhale for 5 seconds (no holds)

## Duration

The duration is specified in seconds. Here are some common conversions:
- 1 minute = 60 seconds
- 2 minutes = 120 seconds
- 3 minutes = 180 seconds
- 5 minutes = 300 seconds
- 10 minutes = 600 seconds

## Best Practices

1. **Gradual Progression**: Start with simpler patterns and shorter durations, then gradually increase complexity
2. **Consistent Timing**: Keep the total exercise time reasonable (typically 5-15 minutes total)
3. **Clear Titles**: Use descriptive titles that indicate the difficulty level or purpose of each stage
4. **Logical Flow**: Ensure each stage builds naturally on the previous one

## Examples

### Example 1: Progressive Relaxation

```json
{
  "title": "Progressive Relaxation",
  "stages": [
    {
      "title": "Easy Start",
      "pattern": "4-4-4-4",
      "duration": 120
    },
    {
      "title": "Deeper Breathing",
      "pattern": "5-5-5-5",
      "duration": 180
    },
    {
      "title": "Advanced Relaxation",
      "pattern": "6-6-6-6",
      "duration": 240
    }
  ],
  "intro": "Start with simple breathing and gradually increase the depth and duration."
}
```

This exercise will:
1. Begin with 2 minutes of 4-4-4-4 breathing
2. Progress to 3 minutes of 5-5-5-5 breathing
3. Finish with 4 minutes of 6-6-6-6 breathing

### Example 2: 4-7-8 Relaxation Technique

```json
{
  "title": "4-7-8 Breathing",
  "stages": [
    {
      "title": "Introduction",
      "pattern": "4-4-4-4",
      "duration": 60
    },
    {
      "title": "4-7-8 Technique",
      "pattern": "4-7-8",
      "duration": 180
    },
    {
      "title": "Extended Practice",
      "pattern": "4-7-8",
      "duration": 300
    }
  ],
  "intro": "The 4-7-8 technique is a powerful relaxation method that can help reduce anxiety and improve sleep."
}
```

This exercise will:
1. Begin with 1 minute of familiar 4-4-4-4 breathing
2. Progress to 3 minutes of 4-7-8 breathing
3. Finish with 5 minutes of extended 4-7-8 practice

### Example 3: Box Breathing Progression

```json
{
  "title": "Box Breathing Progression",
  "stages": [
    {
      "title": "Basic Box Breathing",
      "pattern": "4-4-4-4",
      "duration": 120
    },
    {
      "title": "Extended Box Breathing",
      "pattern": "6-6-6-6",
      "duration": 180
    },
    {
      "title": "Advanced Box Breathing",
      "pattern": "8-8-8-8",
      "duration": 240
    }
  ],
  "intro": "Box breathing is a technique where you inhale, hold, exhale, and hold again for equal counts, creating a \"box\" pattern."
}
```

This exercise will:
1. Begin with 2 minutes of basic 4-count box breathing
2. Progress to 3 minutes of 6-count box breathing
3. Finish with 4 minutes of advanced 8-count box breathing