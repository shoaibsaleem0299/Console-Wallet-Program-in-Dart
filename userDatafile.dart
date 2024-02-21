import 'classes.dart';
import 'dart:io';

void saveToFile(User user) {
  String data = user.toFileString();
  File file = File('${user.email}_data.txt');

  try {
    file.writeAsStringSync(data);
    print('User data saved successfully.');
  } catch (e) {
    print('Error saving user data: $e');
  }
}

User? loadFromFile(String email) {
  File file = File('${email}_data.txt');

  try {
    String data = file.readAsStringSync();
    List<String> parts = data.split('|');

    User loadedUser = User(
      parts[0], // email
      parts[1], // password
      double.parse(parts[2]), // balance
    );

    loadedUser.transactions = parts[3].split(';'); // transactions

    print('User data loaded successfully.');
    return loadedUser;
  } catch (e) {
    print('Error loading user data: $e');
    return null;
  }
}