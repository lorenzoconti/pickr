# Pickr

### Introduction

Pickr: an app to play cards with friends.
This project is carried out for the testing course of the University of Bergamo.

### Folder structure

- pickr: contains a Flutter project of the app.

- pickr-java: contains a Java project with a reproduction of the Dart classes in order to test them with Junit, using the eclipse's Code Coverage tool and applying the MCDC        criteria.

- pickr-dbc: contains a Java project where the DbC paradigm is used. It is not possible to use KeY to verify the contracts.

- pickr-key: contains a KeY project with re-designed classes in order to verify their contracts.

- pickr-asmeta: contains an ASMETA project. There are multiple files, with different purposes, more details in the report.

- yakindu: contains an eclipse project with a Yakindu State Charts file.

- Pickr.ctw: a CTWEdge file used for combinatorial testing.

### Additional info

- To run the app
```
flutter pub get
flutter run
```

- To run the unit tests, run the following command in the Flutter project folder.
```
flutter test
```
- Inside the pickr-asmeta folder, to run the model advisor, run the following command.
```
java -jar .\AsmetaMA.jar -mpAll .\Pickr_NuSMV.asm
```

