import 'dart:js_util';

import 'package:expense_app/widgets/chart/chart.dart';
import 'package:expense_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {

  final List<Expense> _registeredExpenses = [
    Expense(title: 'Flutter Course', amount: 19.99, date: DateTime.now(), category: Category.work),
    Expense(title: 'Cinema', amount: 15, date: DateTime.now(), category: Category.leisure)
  ];


  void _openAddExpenseOverlay() {
    // Modal
    /**
     * isScrollControlled true makes full screen
     */
    showModalBottomSheet(
      useSafeArea: true, // Take Notification bar and Camera into consideration
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
      isScrollControlled: true
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
      Navigator.pop(context);
    });
  }

  void _removeExpense(Expense expense) {

    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Undo functionality
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }
          ),
      )
    );
  }


  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );
    
    if(_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }

    /**
     * Scaffold does not occupy full height and width but available empty space after App Bar space.
     */
    return Scaffold(
      // Column height is unconstrained
      // Expanded takes avaiable height of the screen.
      body: width < 600 ? Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent)
        ],
      ): Row(
        children: [
          // As Expanded takes child content, thats why wrapped expanded to both
          Expanded(child: Chart(expenses: _registeredExpenses)),
          Expanded(child: mainContent)
        ],
      ),
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}