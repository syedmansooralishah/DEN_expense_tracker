// lib/screens/reports_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';  // Import fl_chart for charts
import '../models/budget.dart';  // Import the Budget model
import '../services/database_helper.dart';  // Import the database helper

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<Budget> _budgets = [];
  double totalBudget = 0.0;
  double totalSpent = 0.0;
  double totalRemaining = 0.0;

  @override
  void initState() {
    super.initState();
    _loadBudgets();  // Load the budgets from the database
  }

  Future<void> _loadBudgets() async {
    // Fetch the list of budgets from the database
    final budgets = await DatabaseHelper().getBudgets();
    setState(() {
      _budgets = budgets;

      // Calculate totals
      totalBudget = _budgets.fold(0.0, (sum, item) => sum + item.totalBudget);  // Use totalBudget instead of amount
      totalSpent = _budgets.fold(0.0, (sum, item) => sum + item.spent);  // Use spent instead of amount
      totalRemaining = totalBudget - totalSpent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Reports'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Displaying total statistics
            Text('Total Budget: \$${totalBudget.toStringAsFixed(2)}'),
            Text('Total Spent: \$${totalSpent.toStringAsFixed(2)}'),
            Text('Total Remaining: \$${totalRemaining.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            Text(
              'Expense Breakdown',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Pie chart widget
            _buildPieChart(),

            SizedBox(height: 20),

            // Back button to go back to the budget management screen
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the main budget screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
              ),
              child: Text('Back to Budget Management'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build the Pie Chart using fl_chart
  Widget _buildPieChart() {
    // Handle the case where totalBudget is zero to avoid division by zero errors
    if (totalBudget == 0) {
      return Center(
        child: Text(
          'No Budget Data Available',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    // Total spent percentage and remaining percentage for the Pie chart
    double spentPercentage = (totalSpent / totalBudget) * 100;
    double remainingPercentage = (totalRemaining / totalBudget) * 100;

    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: spentPercentage,
            color: Colors.red,
            title: '${spentPercentage.toStringAsFixed(1)}%',
            radius: 50,
            titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            value: remainingPercentage,
            color: Colors.green,
            title: '${remainingPercentage.toStringAsFixed(1)}%',
            radius: 50,
            titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
        centerSpaceRadius: 40, // Space in the center of the pie chart
        borderData: FlBorderData(show: false),  // Remove border from the chart
        sectionsSpace: 4,  // Add space between pie chart sections
      ),
    );
  }
}
