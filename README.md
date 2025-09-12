# OpenBreath

This app uses Flutter's gen-l10n for localization. Existing languages: English (`en`), Dutch (`nl`).

Files live in `lib/l10n/`:

- `lib/l10n/app_en.arb`
- `lib/l10n/app_nl.arb`

### Add a new language

1. Create a new ARB file in `lib/l10n/`, e.g. `app_es.arb` for Spanish.
2. Copy all keys from `app_en.arb` and translate the values.
3. Run:

   ```bash
   flutter pub get
   flutter gen-l10n
   ```

4. Rebuild the app. The new locale will be included automatically in `supportedLocales`.
5. To expose the language in Settings, add an entry to the language dropdown in `lib/settings_screen.dart` and the enum in `lib/settings_provider.dart`.

### Changing the app language at runtime

Use the Settings screen (`Settings > Language`) to choose:

- System default
- English
- Dutch

The choice is persisted with `shared_preferences` and applied on startup.

## Exercises content localization

Exercise data is stored in a single JSON file: `assets/exercises.json`.
This file contains all the exercises with translations for all supported languages.

The structure of an exercise is as follows:
```json
[
  {
    "id": "box-breathing",
    "pattern": "4-4-4-4",
    "duration": "4 min",
    "title": {
      "en": "Box Breathing",
      "nl": "Box Ademhaling"
    },
    "intro": {
      "en": "A simple technique to calm your mind and body.",
      "nl": "Een eenvoudige techniek om je geest en lichaam te kalmeren."
    }
  }
]
```

### Add or update exercise translations

1.  Open `assets/exercises.json`.
2.  For each exercise, add a new key-value pair to the `title` and `intro` objects with the language code as the key and the translation as the value.
3.  If you are adding a new language to the app, you also need to:
    - Add the language to the settings UI and enum in `lib/settings_provider.dart` and `lib/settings_screen.dart`.
4.  Rebuild the app.
