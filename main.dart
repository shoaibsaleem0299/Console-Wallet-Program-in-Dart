import 'dart:io';
import 'methods.dart';
import 'classes.dart';
import 'userDatafile.dart';


void main(List<String> args) {
  List<User> users = [];
  Map<String, User> userMap = {};

  User? currentUser = null;
  Directory.current.listSync().whereType<File>().forEach((file) {
    if (file.path.endsWith("_data.txt")) {
      String email = file.uri.pathSegments.last.split('_')[0];
      User? loadedUser = loadFromFile(email);
      if (loadedUser != null) {
        users.add(loadedUser);
        userMap[email] = loadedUser;
      }
    }
  });

  String option;
  String inputEmail;
  String inputPassword;

  do {
    registerMenu();
    stdout.write("Enter Option : ");
    option = stdin.readLineSync()!;
    print("============================");
    switch (option) {
      case '1':
        print("============================");
        stdout.write("Enter Email : ");
        inputEmail = stdin.readLineSync()!;
        stdout.write("Enter Password : ");
        inputPassword = stdin.readLineSync()!;
        users.add(User(inputEmail, inputPassword, 0.0));
        userMap[inputEmail] = users.last;
        saveToFile(users.last);
        print("User registered successfully!");
        print("==============================");
        break;
      case '2':
        do {
          print("============================");
          stdout.write("Enter Email : ");
          inputEmail = stdin.readLineSync()!;
          stdout.write("Enter Password : ");
          inputPassword = stdin.readLineSync()!;
        } while (!userMap.containsKey(inputEmail) ||
            userMap[inputEmail]!.password != inputPassword);
        currentUser = userMap[inputEmail]!;
        print("============================");
        break;
      case '3':
        break;
    }

    if (currentUser != null) {
      do {
        menu();
        stdout.write("Enter Option : ");
        option = stdin.readLineSync()!;
        print("============================");

        switch (option) {
          case '1':
            currentUser?.viewBalance();
            break;
          case '2':
            stdout.write("Enter an Amount: ");
            double amount = double.parse(stdin.readLineSync()!);
            currentUser?.withdraw(amount);
            break;
          case '3':
            stdout.write("Enter an Amount: ");
            double amount = double.parse(stdin.readLineSync()!);
            currentUser?.deposit(amount);
            break;
          case '4':
            currentUser?.viewTransactions();
            break;
          case '5':
            print("Logging out!");
            if (currentUser != null) {
              saveToFile(currentUser);
            }
            currentUser = null;
            break;
          default:
            print("Invalid option");
        }
      } while (option != '5');
    }
  } while (option != '3');
}
