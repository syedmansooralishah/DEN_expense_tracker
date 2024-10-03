// lib/screens/add_expense_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import to format the date

import '../models/expense.dart';
import '../services/database_helper.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _category;
  double? _amount;
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense', style: Theme.of(context).textTheme.displayLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _category = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => _amount = double.tryParse(value ?? ''),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final expense = Expense(
                      category: _category!,
                      amount: _amount!,
                      date: _date.toIso8601String(), // Convert DateTime to String
                    );

                    try {
                      await DatabaseHelper().insertExpense(expense);
                      Navigator.pop(context);
                    } catch (e) {
                      print('Error inserting expense: $e');
                    }
                  }
                },
                child: Text('Save Expense', style: Theme.of(context).textTheme.labelLarge),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
