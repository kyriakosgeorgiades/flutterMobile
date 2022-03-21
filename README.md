# Table of contents

- [General info](#general-info)
- [Setup](#setup)
- [Important](#important)

## General Info

This is the frontned for the mobile development course using flutter. The app can be run in both phone and web.

## Setup

git clone <https://github.coventry.ac.uk/7052CEM-2122/georgiadek-sem2-flutter.git>
Install the plugins on Visual studio code "Dart" and "Flutter"
Change the name of the directory from

```
georgiadek-sem2-flutter to georgiadek_sem2_flutter
```

After the directory is updated follow this commands:

```powershell
cd georgiadek_sem2_flutter
flutter pub get
flutter create .
flutter run
```

Select the web options either `2` or `3`.
You can run the project throught visual studio codio to trigger running it with an android emulator if you have it set it up.

## Important

Do not forget to change the name of the directory from `-` to `_` otherwise the project will not run.
Since the app is hosted on a free service due to the inactivity the request will be a bit slow the first time untill it changes state from sleep to active. Please give it a few seconds to change a state when making the first request in a while!
