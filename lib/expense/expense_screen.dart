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
      builder: (ctx) => NewExpense(),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Text('Chart Area'),
          Expanded(
            child: ExpenseList(expenses: registeredExpenses),
          ),
        ],
      ),
    );
  }
}
