class User {
  final String email;
  final String password;
  double balance;
  List<String> transactions;

  User(this.email, this.password, this.balance) : transactions = [];

  void deposit(double amount) {
    balance += amount;
    transactions.add("=> Deposit: $amount <=");
  }

  void withdraw(double amount) {
    if (balance >= amount) {
      balance -= amount;
      transactions.add("=> Withdrawal: $amount <=");
    } else {
      print("=> Insufficient funds for withdrawal. <=");
    }
  }

  void viewBalance() {
    print("=> Your balance is: $balance <=");
  }

  void viewTransactions() {
    print("=> Transactions:");
    for (var transaction in transactions) {
      print(transaction);
    }
    print('==================================');
  }

  // Method to convert user data to a string for saving to a file.
  String toFileString() {
    return "$email|$password|$balance|${transactions.join(';')}";
  }
}

