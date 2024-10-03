// lib/models/budget.dart

class Budget {
  int? id;  // Optional field to store the database ID (for persistence)
  double totalBudget;
  double spent;

  // Constructor that allows for an optional id (for database) and a required totalBudget.
  Budget({
    this.id,  // The id is optional when creating a new instance
    required this.totalBudget,
    this.spent = 0.0,  // Default value for spent is 0
  });

  // Method to calculate the remaining budget
  double get remainingBudget => totalBudget - spent;

  // Method to check if the budget is exceeded
  bool isBudgetExceeded() {
    return spent > totalBudget;
  }

  // Method to add an expense
  void addExpense(double expenseAmount) {
    spent += expenseAmount;
  }

  // Convert a Budget object to a Map for SQLite insert/update
  Map<String, dynamic> toMap() {
    return {
      'id': id,  // Include id if it's available
      'totalBudget': totalBudget,
      'spent': spent,
    };
  }

  // Create a Budget object from a Map (usually used when reading from the database)
  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'],  // The id is retrieved from the database
      totalBudget: map['totalBudget'],
      spent: map['spent'],
    );
  }
}
