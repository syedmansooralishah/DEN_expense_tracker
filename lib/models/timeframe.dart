class Budget {
  String category;
  double amount;
  double spent;
  String timeframe;  // Add timeframe

  Budget({
    required this.category,
    required this.amount,
    required this.spent,
    required this.timeframe,  // Add timeframe here
  });

  double get remaining => amount - spent;
}
