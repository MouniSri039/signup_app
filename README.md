# MAD 4360 — In-Class Activity 10
## Flutter Signup Form Quest

### Student Information
- **Student:** Mouni Sri Nallapaneni
- **Track:** Graduate
- **Task A:** Local Signup Coach Simulation
- **Task C:** Confirm & Celebrate
- **Platform:** Flutter / Dart / Android

### Project Overview
This application demonstrates a signup form with input validation, a local preset-tip feature, and password confirmation. It is a demonstration application only; it does not create or store user accounts.

### Features
- Full name, email, password, and confirm-password fields.
- Form validation with helpful error messages.
- Password confirmation prevents submission when passwords do not match.
- Personalized success feedback after valid form submission.
- Local Signup Coach using preset password tips.
- Loading, result, error, and retry states for the tip feature.
- A local error-test toggle for demonstrating failure and recovery.
- No network requests or live AI service are used by the Signup Coach.

### How to Run
1. Install Flutter and configure an Android emulator or device.
2. Open the project directory in VS Code.
3. Run `flutter pub get`.
4. Run `flutter run`.

### Tests Performed
- Empty form submission displays validation errors.
- Invalid email displays an error.
- Password shorter than six characters is rejected.
- Mismatched passwords prevent signup.
- Matching passwords and valid fields display personalized success feedback.
- The Signup Coach displays a preset tip.
- Local error mode displays an error message.
- Disabling error mode and retrying displays the preset tip again.

### Graduate Reflection Questions

#### 1. Privacy Boundary
The Signup Coach selects a preset tip using the fixed `password_help` category. It does not use the user's name, email, or password to select the tip. This keeps personal form information separate from the tip feature. The feature runs locally and does not send form data to an external AI service.

#### 2. Evaluating Tip Quality and Safety
I would test the preset tips against a small checklist covering usefulness, clarity, safety, and consistency. I would verify that every tip is short, understandable, and does not ask users to reveal their passwords. I would also test that the feature handles missing or empty tip data. One useful failure metric would be the percentage of test cases in which the app fails to display a valid tip or the expected error message.

#### 3. Design Trade-off
Preset tips make the feature predictable, private, and usable without an internet connection. However, they offer limited variety and cannot adapt to a user's specific question. A practical improvement would be to add more carefully reviewed preset tips and test their clarity and accessibility. Any future AI integration would need a separate privacy review and should remain independent of signup validation.

### Limitations
- This is a demo signup form and does not create a real account.
- Signup tips are predefined examples, not live AI-generated responses.
- Password validation provides basic input checks and is not a security guarantee.

### Individual Contribution
I implemented the signup form, input validation, local Signup Coach simulation, error/retry behavior, and confirm-password flow. I tested valid and invalid form submissions and the local tip success and recovery scenarios.

### Build APK
Build a release APK with:

`flutter build apk --release`

The generated file is located at:

`build/app/outputs/flutter-apk/app-release.apk`
