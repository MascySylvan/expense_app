import 'package:flutter/material.dart';
import 'package:expense_app/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

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
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  print(titleController.text);
                  print(amountController.text);
                },
                child: Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
