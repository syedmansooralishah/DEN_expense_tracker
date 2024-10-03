class Budget {
  String category;
  double amount;
  double spent;
  String timeframe; // "Weekly", "Monthly", "Custom"

  Budget({
    required this.category,
    required this.amount,
    required this.spent,
    required this.timeframe,
  });

  double get remaining => amount - spent;
}
