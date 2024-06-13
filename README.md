# cavity3

# Must do
Directly edit the dependency tflite_flutter_helper
Path android/build.gradle
Change (line 5) to ext.kotlin_version = '1.5.20'

In VSCode, you can click on the "DEPENDENCIES" tab and scroll to the "direct dependency," navigate to tflite_flutter_helper/andriod/build.gradle and change to 
buildscript {<br>
    ***<br>
    ext.kotlin_version = '1.5.20'<br>
    ***<br>
} 


# Table of Contents:
- Purpose
- Audience
- Features
- Usage
- AI
- Database Schema
- Database Synchronization
- Firebase Rules
- File System Explanation
- Model Classes
- Packages

# Purpose: 
A portable dentist. 
Ever tried searching online with your symptoms and getting overwhelmed with the list of diseases?
Now you can take a picture of your teeth, and let AI do the work for you by classifying which dental disease you have. 

# Audience: 
Generally adults with dental issues. 

# Features:
Take a photo of your teeth -> upload to app to get AI detection of diseases
Teachable Machine -> TFLite
Firebase
User Login
Realtime Database
Store date and which disease was recorded at that time
PDF Report generator
Download to device
Share 
Profile data

# Usage:
Follow the login process
Then, select from any of the 3 features, or change your profile
Photo AI
Take picture or upload photo
History
Can swipe to delete entries
PDF Generator
Automatically generates

# AI:
I used Teachable Machine.
Dataset: https://www.kaggle.com/datasets/salmansajid05/oral-diseases 
Labels:
0 calculus
1 caries
2 gingivitis
3 hypodontia
4 ulcer
5 discoloration
There is a lack of “No disease” label as I couldn’t find that dataset.

# Database Schema:
- Records
- - UID
- - - [GENERATED INDEX]
- - - - Timestamp (MillisSinceEpoch format)
- - - - Disease
- Users
- - UID
- - - FirstName
- - - LastName
- - - DOB (Date of birth, ISO8601 format)

# Database Synchronization:
```
Records:
final listener1 = ref.onChildAdded.listen((event) {
      log('on child database added');
      String? key = event.snapshot.key;
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      final record = MyRecord.fromJson(data);
      record.key = key;


      //check if it exists, b/c it will trigger twice with both child nodes
      for (int i = 0; i < records!.length; i++) {
        if (records![i].key! == key) {
          records![i] = record;
          return;
        }
      }
      records!.insert(0, record);
    });


    final listener2 = ref.onChildRemoved.listen((event) {
      String? key = event.snapshot.key;
      for (int i = 0; i < records!.length; i++) {
        if (records![i].key! == key) {
          records!.removeAt(i);
          break;
        }
      }
    });

Users:
final listener1 = ref.onChildChanged.listen((event) {
      String field = event.snapshot.key!;
      Object value = event.snapshot.value!;


      print(event.snapshot.value);
      if (field == 'firstName') {
        user = MyUser(
            firstName: value as String, lastName: user.lastName, DOB: user.DOB);
      } else if (field == 'lastName') {
        user = MyUser(
            firstName: user.firstName,
            lastName: value as String,
            DOB: user.DOB);
      } else if (field == 'DOB') {
        user = MyUser(
            firstName: user.firstName,
            lastName: user.lastName,
            DOB: DateTime.parse(value as String));
      }
    });
    listeners.add(listener1);
```

# Firebase Rules:
Access only allowed if you are the one who created the entries.
```
{
  "rules": {
    "records": {
      "$uid": {
        ".write": "$uid === auth.uid",
        ".read": "$uid === auth.uid"
      }
    },
    
    "users": {
      "$uid": {
        ".write": "$uid === auth.uid",
        ".read": "$uid === auth.uid"
      }
    }
  }
}
```

# File System Explanation:
flutter_tflite_helper misc. helper classes
- Content
- - The “body/pages” of each screen
- Login
- - Holds the “body/pages” of login screens
- Navigation
- - MyNavigator handles StatefulShellRouter.indexedStack and the calcNavigation() method, which is - automatically called upon UserState changes.
- - Other pages are the “frame,” including the bottom navigation bar.
- PDF
- - The PDF generation if there weren’t dependency conflicts
- Providers
- - Handles automatic state changes
- - - Database()
- - - Singleton class holding List records and handles automatic synchronization
- UserDatabase()
- - Singleton class holding MyUser and handles automatic synchronization
- providers/model_classes:
- Widget
- - flutter utility widgets
