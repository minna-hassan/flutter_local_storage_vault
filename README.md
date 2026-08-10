# ⭐ Secure Vault — Flutter Database Assignment

After practicing different Flutter UIs, I wanted to challenge myself by building a simple **Personal Vault** while exploring how different local storage solutions work together in Flutter.

The main focus of this project was understanding how **three different databases/storage solutions — Hive, SharedPreferences, and Flutter Secure Storage — can be used for different purposes**. Hive is used for the main vault data, SharedPreferences is used for simple settings and preferences, and Flutter Secure Storage is used for sensitive information such as the master password hash.

This project also helped me understand password hashing, master password protection, vault unlocking, secure notes, password storage, settings, and local data persistence while keeping everything offline.

Everything was built using Flutter's core widgets with a focus on keeping the UI simple, reusable, and easy to understand.

If you find this repository helpful or use parts of it in your own work, please consider giving it a ⭐ to show your support!

---

# 🎬 Preview

<video src="https://github.com/minna-hassan/flutter_local_storage_vault/releases/download/untagged-fc4ab65fa2b4fbc4f5f6/vault.mp4" width="100%" controls></video>

---

# 📂 Project Structure

| File / Folder | Description                                                                |
| ------------- | -------------------------------------------------------------------------- |
| `main.dart`   | Application entry point and app configuration.                             |
| `routes/`     | Defines application routes using `go_router`.                              |
| `screens/`    | Contains the main application screens.                                     |
| `dialog/`     | Contains custom dialogs used throughout the application.                   |
| `model/`      | Contains data models and Hive adapters.                                    |
| `services/`   | Contains password hashing, secure storage, and SharedPreferences services. |
| `widget/`     | Contains reusable UI components.                                           |

---

# ✨ Features

## 🔐 Vault Setup

* Create a master password.
* Confirm the master password.
* Basic password validation.
* Hash the master password before storing it.
* Store the password hash securely.

## 🔓 Unlock Vault

* Unlock the vault using the master password.
* Hash the entered password.
* Compare it with the stored password hash.
* Show an error when the password is incorrect.
* Open the vault after successful verification.

## 🏠 Home Screen

* Simple Personal Vault dashboard.
* View recent vault items.
* View password and note information.
* Access the main vault features.

## 🔑 Passwords

* Store account information.
* Store usernames or emails.
* Store passwords.
* Add and manage password entries.

## 📝 Secure Notes

* Create secure notes.
* Store private information inside the vault.
* Manage notes locally using Hive.

## ⚙️ Settings

* Change master password.
* Biometric unlock preference.
* Auto-lock timer.
* Notifications preference.
* Appearance option.
* Application information.

## 🔑 Change Master Password

* Enter the old master password.
* Enter a new master password.
* Verify the old password.
* Hash the new password.
* Save the new password hash securely.

## ⏱ Auto-Lock Timer

* Choose an auto-lock time.
* Immediately.
* 1 minute.
* 5 minutes.
* 15 minutes.
* Save the selected preference locally.

## 🔔 Notifications

* Enable or disable notifications.
* Save the selected preference locally.

---

# 🗄️ Three Storage Solutions

One of the main things I wanted to understand in this project was that **not all data should be stored in the same place**.

The application uses three different local storage solutions, each for a different purpose.

## 📦 Hive

**Hive is used for the main vault data.**

It stores structured information such as:

* Password entries
* Secure notes
* Other vault records

I used Hive because the vault needs to store multiple records that can be added, edited, and retrieved.

---

## 🔐 Flutter Secure Storage

**Flutter Secure Storage is used for sensitive information.**

It is used to store:

* Master password hash
* Other sensitive values

The master password itself is not stored as plain text.

The basic flow is:

```text
Master Password
       ↓
     Hashing
       ↓
 Password Hash
       ↓
Flutter Secure Storage
```

This helped me understand why sensitive information should be handled differently from normal application data.

---

## ⚙️ SharedPreferences

**SharedPreferences is used for simple application settings.**

It stores things such as:

* Biometric preference
* Notification preference
* Auto-lock timer

For example:

```text
Auto-lock Timer
      ↓
   5 minutes
      ↓
SharedPreferences
```

These values are simple preferences and don't need to be stored in the main Hive database or secure storage.

---

# 🔄 How The Three Work Together

The main idea of the project is using the right storage solution for the right type of data.

```text
                 SECURE VAULT
                      │
          ┌───────────┼───────────┐
          │           │           │
          ▼           ▼           ▼
        Hive      Secure Storage  SharedPreferences
          │           │           │
          ▼           ▼           ▼
      Vault Data   Sensitive Data   Settings
          │           │           │
          ├── Passwords  ├── Master  ├── Notifications
          └── Notes      │   Hash    ├── Auto-lock
                         └── Keys    └── Biometric
```

This was the main reason for building the project — to get practical experience with **three different ways of storing local data in Flutter** instead of using one solution for everything.

---

# 🎨 UI & Navigation Highlights

The project also gave me practice with Flutter's UI and navigation system.

Highlights include:

* `go_router` navigation
* `StatefulWidget`
* `SingleChildScrollView`
* `ListView`
* `MediaQuery`
* Custom dialogs
* `TextFormField`
* Reusable widgets
* Responsive layouts
* Material Design components

---

# 🛠 Tech Stack

* Flutter
* Dart
* `hive`
* `hive_flutter`
* `flutter_secure_storage`
* `crypto`
* `shared_preferences`
* `go_router`
* `path_provider`

---

# 🚀 Getting Started

Clone the repository:

```bash
git clone <your-repository-url>
```

Navigate to the project:

```bash
cd flutter_database_assignment
```

Install dependencies:

```bash
flutter pub get
```

Generate Hive adapters if needed:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Run the application:

```bash
flutter run
```

---

# 🧠 What I Learned

Working on this project helped me better understand:

* How local data persistence works in Flutter.
* When to use Hive for structured data.
* When to use SharedPreferences for simple settings.
* When to use Flutter Secure Storage for sensitive information.
* How different storage solutions can work together in one application.
* Password hashing using `crypto`.
* Creating a master password setup flow.
* Creating a vault unlock flow.
* Changing and securely storing a new master password.
* Creating reusable Flutter widgets.
* Working with dialogs and forms.
* Managing navigation using `go_router`.
* Organizing Flutter code into screens, models, services, dialogs, and widgets.

---

# 🎯 Future Improvements

* Complete biometric authentication.
* Implement the actual auto-lock functionality.
* Add password generator.
* Add search functionality.
* Add edit and delete functionality.
* Add categories for passwords and notes.
* Add dark mode.
* Add backup and restore.
* Add database export/import.
* Improve encryption and security.

---

# ⭐ License

This project is free to use for learning and personal projects.

If you find it helpful or use parts of it in your own work, leaving a ⭐ on the repository or giving credit is always appreciated!
