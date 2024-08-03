import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd(); //year-month-date

// mera kaam he overlay build karna, matlab ye wala screen user ko open hoga jab bhi wo apna expense add karna chahega

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //this creates an object that is used for handling user input
  final _titleController = TextEditingController(); //always dispose it
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.lesiure;

  //dispose is part of a statefulwidgets lifecycle. it's called automatically by flutter when the widget and its state are about to be destroyed
  //only state classes can implement this "dispose" method (statelesswidget can't). that's also why you must use a statefulwidget here

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  final List<Expense> expenseItems = [];

  //this function is there for showing invalid input
  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text(
                    'Please Make sure of valid title, amount, date & category was entered'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(
                            ctx); //here in this case the context is connected by dialog
                      },
                      child: const Text('Okay'))
                ],
              ));
      return;
    }
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    //this controller tells the flutter that it isn't needed anymore otherwise it could live forevere and could take all the memory
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        //to make sure it gets as much space as it can get
        height: double.infinity,
        child: SingleChildScrollView(
          //to make it scrollable in landscape mode
          child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text('Title'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _amountController,
                            //to add label we need to add decoration as Textfield don't have internal title built
                            decoration: const InputDecoration(
                              prefixText:
                                  '\$ ', //you have to escape special characters as it has a special meaning
                              label: Text('Amount'),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      //to add label we need to add decoration as Textfield don't have internal title built
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                            value: _selectedCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category.name.toUpperCase(),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                _selectedCategory = value;
                              });
                            }),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_selectedDate == null
                                  ? 'No date Selected'
                                  : formatter.format(
                                      _selectedDate!)), //exclamation mark to ensure dart that this won't be null so it's okay
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  else
                    Row(
                      children: [
                        //we are wrapping the textfield with expanded because textfield automatically takes up all the space and row() don't manage it
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _amountController,
                            //to add label we need to add decoration as Textfield don't have internal title built
                            decoration: const InputDecoration(
                              prefixText:
                                  '\$ ', //you have to escape special characters as it has a special meaning
                              label: Text('Amount'),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        //since here we have a row inside a row hence we have to use expanded
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_selectedDate == null
                                  ? 'No date Selected'
                                  : formatter.format(
                                      _selectedDate!)), //exclamation mark to ensure dart that this won't be null so it's okay
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            //context of build method
                            //pop simply removes the overlay on the screen
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _submitExpenseData();
                          },
                          child: const Text("Save Expense"),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        //map is used to transform one type of value to another type of value
                        DropdownButton(
                            value: _selectedCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category.name.toUpperCase(),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                _selectedCategory = value;
                              });
                            }),

                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            //context of build method
                            //pop simply removes the overlay on the screen
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _submitExpenseData();
                          },
                          child: const Text("Save Expense"),
                        ),
                      ],
                    )
                ],
              )),
        ),
      );
    });
  }
}

//to storing the input values - add another parameters in textfield - onChangeds
