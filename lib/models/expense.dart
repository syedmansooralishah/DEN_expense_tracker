// lib/models/expense.dart
class Expense {
  int? id;
  String category;
  double amount;
  String date; // Store date as String (ISO 8601 format)

  // Constructor
  Expense({
    this.id,
    required this.category,
    required this.amount,
    required this.date,
  });

  // Convert Expense object to Map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'date': date, // Store date as String
    };
  }

  // Convert Map to Expense object
  static Expense fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      category: map['category'],
      amount: map['amount'],
      date: map['date'], // Ensure this is a String
    );
  }

  // Convert date string to DateTime when necessary
  DateTime getDateTime() {
    return DateTime.parse(date); // Convert date String to DateTime
  }
}
