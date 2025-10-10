import 'package:expense_app/chart/chart.dart';
import 'package:expense_app/expense/expense_list.dart';
import 'package:expense_app/expense/new_expense.dart';
import 'package:expense_app/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() {
    return _ExpenseScreenState();
  }
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final List<Expense> registeredExpenses = [
    Expense(
      title: 'Lunch sa Jollibee',
      amount: 300.49,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Team Building',
      amount: 1000.49,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Demon Slayer Movie',
      amount: 450.49,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void openExpenseModal() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(
        addExpense: addExpense,
      ),
    );
  }

  void addExpense(Expense expense) {
    setState(() {
      registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = registeredExpenses.indexOf(expense);

    setState(() {
      registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Text(
        'No expenses found. Try adding one!',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );

    if (registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: registeredExpenses,
        removeExpense: removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: openExpenseModal,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      // body: Column(
      //   children: [
      //     Chart(expenses: registeredExpenses),
      //     Expanded(
      //       child: mainContent,
      //     ),
      //   ],
      // ),
      body: screenWidth < 600
          ? Column(
              children: [
                Chart(expenses: registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(   
                  child: Chart(expenses: registeredExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
