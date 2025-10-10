import 'package:flutter/material.dart';
import 'package:expense_app/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpense});

  final void Function(Expense expense) addExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? dateSelected;
  Category selectedCategory = Category.food;

  void submitExpenseData() {
    double? enteredAmount = double.tryParse(amountController.text);

    //validate
    if (titleController.text.trim().isEmpty ||
        enteredAmount == null ||
        enteredAmount <= 0 ||
        dateSelected == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Invalid Data',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: Text(
            'Please fill out all fields with valid data.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      );

      return;
    }

    Expense newExpense = Expense(
      title: titleController.text.trim(),
      amount: enteredAmount,
      date: dateSelected!,
      category: selectedCategory,
    );

    widget.addExpense(newExpense);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Expense successfully saved',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Text(
          'Expense was saved with the following data.'
          '\nTitle: ${newExpense.title}'
          '\nAmount: \$${newExpense.amount}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }

  void openDatePicker() async {
    final initialDate = DateTime.now();
    final firstDate = DateTime(
      initialDate.year - 1,
      initialDate.month,
      initialDate.day,
    );

    final datePicked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: initialDate,
    );
    //...
    setState(() {
      dateSelected = datePicked;
    });

    return;
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            style: Theme.of(context).textTheme.titleMedium,
            controller: titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: TextField(
                  style: Theme.of(context).textTheme.titleMedium,
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Amount'),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      dateSelected == null
                          ? 'No Date Selected'
                          : formatter.format(dateSelected!),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                      onPressed: openDatePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            spacing: 10,
            children: [
              DropdownButton(
                value: selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Row(
                          spacing: 10,
                          children: [
                            Icon(categoryIcons[category]),
                            Text(category.name.toString().toUpperCase()),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ElevatedButton(
                onPressed: submitExpenseData,
                child: Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
