import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_expense_screen.dart';
import 'screens/expense_list_screen.dart';
import 'screens/budget_management_screen.dart';
import 'screens/reports_screen.dart';

void main() {
  runApp(ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primaryColor: Colors.blue, // Primary color
        colorScheme: ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.pink, // Use this for the accent color
        ),
        scaffoldBackgroundColor: Colors.white, // Background color
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
          displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
          labelLarge: TextStyle(fontSize: 16, color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink, // Button color
            textStyle: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
      home: HomeScreen(),
      routes: {
        '/add-expense': (context) => AddExpenseScreen(),
        '/expense-list': (context) => ExpenseListScreen(),
        '/budget-management': (context) => BudgetManagementScreen(),
        '/reports': (context) => ReportScreen(),
      },
    );
  }
}
