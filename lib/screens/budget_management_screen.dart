// lib/screens/budget_management_screen.dart

import 'package:flutter/material.dart';
import '../models/budget.dart'; // Import the Budget class

class BudgetManagementScreen extends StatefulWidget {
  @override
  _BudgetManagementScreenState createState() => _BudgetManagementScreenState();
}

class _BudgetManagementScreenState extends State<BudgetManagementScreen> {
  final _budgetController = TextEditingController();
  final Budget _budget = Budget(totalBudget: 100.0); // Initial budget

  // Set budget
  void _setBudget() {
    final double newBudget = double.tryParse(_budgetController.text) ?? 0.0;
    setState(() {
      _budget.totalBudget = newBudget;
      _budget.spent = 0.0; // reset the spent amount when setting a new budget
    });
  }

  // Add expense
  void _addExpense() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController expenseController = TextEditingController();
        return AlertDialog(
          title: Text('Add Expense'),
          content: TextField(
            controller: expenseController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Expense Amount'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final double expense = double.tryParse(expenseController.text) ?? 0.0;
                if (expense > 0.0) {
                  setState(() {
                    _budget.addExpense(expense);
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set Your Monthly Budget',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _budgetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Budget Amount'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _setBudget,
              child: Text('Set Budget'),
            ),
            SizedBox(height: 30),
            Text(
              'Budget: \$${_budget.totalBudget.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Spent: \$${_budget.spent.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.orange),
            ),
            Text(
              'Remaining: \$${_budget.remainingBudget.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: _budget.isBudgetExceeded() ? Colors.red : Colors.green),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _addExpense,
              child: Text('Add Expense'),
            ),
            if (_budget.isBudgetExceeded())
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Warning: You have exceeded your budget!',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
