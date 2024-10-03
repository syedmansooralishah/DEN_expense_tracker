import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final Function onDelete;

  const ExpenseItem({required this.expense, required this.onDelete, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense.category),
      subtitle: Text('\$${expense.amount.toStringAsFixed(2)} on ${expense.date.toLocal()}'),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => onDelete(),
      ),
    );
  }
}

extension on String {
  toLocal() {}
}
