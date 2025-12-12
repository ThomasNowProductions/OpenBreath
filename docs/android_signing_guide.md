# Android App Signing Guide

This document explains how to officially sign the Android app for production releases.

## Why Sign Your App?

App signing is required to publish your app on Google Play Store. It ensures:
- App authenticity and integrity
- Ability to update your app on the store
- Security against tampering

## Setting Up Release Signing

### Step 1: Generate a Keystore

Create a keystore file that contains your private key for signing:

```bash
keytool -genkey -v -keystore breathspace-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias breathspace
```

> **Note:** Store this keystore file securely, as losing it means you won't be able to update your app!

### Step 2: Store the Keystore File

Place your `breathspace-keystore.jks` file in the `android/app/` directory of your project.

### Step 3: Configure Environment Variables

Create a `key.properties` file in your project's `android/` directory with the following content:

```properties
storeFile=../app/breathspace-keystore.jks
storePassword=*****
keyAlias=breathspace
keyPassword=*****
```

**Security Note:** The passwords should be kept secure and should not be committed to version control.

Add the following to your `.gitignore` file to ensure the `key.properties` file is not committed:

```
# Android
key.properties
*.jks
```

### Step 4: Verify Configuration

Your app's `android/app/build.gradle.kts` should contain the following signing configuration:

```kotlin
android {
    // ... other configurations

    signingConfigs {
        create("release") {
            val keystorePropertiesFile = rootProject.file("key.properties")
            val keystoreProperties = Properties()
            if (keystorePropertiesFile.exists()) {
                keystoreProperties.load(FileInputStream(keystorePropertiesFile))
            }

            storeFile = file(keystoreProperties.getProperty("storeFile") ?: "breathspace-keystore.jks")
            storePassword = keystoreProperties.getProperty("storePassword")
            keyAlias = keystoreProperties.getProperty("keyAlias")
            keyPassword = keystoreProperties.getProperty("keyPassword")
        }
    }

    buildTypes {
        release {
            val keystorePropertiesFile = rootProject.file("key.properties")
            signingConfig = if (keystorePropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
}
```

## Building a Signed APK

To build a signed APK, run:

```bash
flutter build apk --release
```

## Building a Signed App Bundle (Recommended for Play Store)

To build a signed app bundle:

```bash
flutter build appbundle --release
```

## Troubleshooting

### Issue: Keystore file not found
**Solution:** Ensure your `breathspace-keystore.jks` file is placed in the `android/app/` directory and the path in `gradle.properties` is correct.

### Issue: Invalid password
**Solution:** Double-check the passwords in your `gradle.properties` file.

### Issue: Key alias not found
**Solution:** Verify the key alias matches what you used when creating the keystore (should be `breathspace` if following the example).

## Security Best Practices

1. **Keep your keystore secure**: Store it in a secure location, preferably separate from your code repository.
2. **Use strong passwords**: Ensure your keystore password and key password are strong and unique.
3. **Backup your keystore**: Make multiple secure backups of your keystore file and store them separately.
4. **Don't commit sensitive info**: Never commit your keystore file or `gradle.properties` with passwords to version control.

## Important Notes

- Once you publish your app using a certain signing key, you must use the same key for all future updates.
- If you lose your signing key, you won't be able to publish updates to the Play Store - you would need to publish as a new app.
- Consider using Google Play Console's App Signing by Google Play to enhance security and allow key rotation.