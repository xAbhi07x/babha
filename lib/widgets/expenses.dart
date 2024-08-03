import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "FLutter Course",
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Cinema",
        amount: 15.89,
        date: DateTime.now(),
        category: Category.lesiure),
  ];

  //context basically contains widget meta information, an object fulll of metadata managed by flutter that belongs to a specific widget
  //so every widget has its own context that contains metadata information related to the widget and
  //and vvi related to thte widget position in the overall widget tree

  void _openAddExpenseOverlay() {
    //this built in function will dynamically add overlay
    //since any class that extends stateclass provides context automatically hence
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true, //takes the entire length
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
    //normally when you see builder that means you must provide function as a value
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    // this object
    ScaffoldMessenger.of(context)
        .clearSnackBars(); //to instantly remove the undo options of previous snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  //build method executes again if we rotate the device
  @override
  Widget build(BuildContext context) {
    //BuildContext is: A handle to the location of a widget in the widget tree.
    //context is a BuildContext instance that gets passed to the builder of a widget in order to let it know where it is inside the Widget Tree of your app.

    //to access the information about the environment
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No Expenses found, Add some'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            //we are passing _openAddExpenseOverlay as value not as function because we don't want to execute the function here
            // we want to set it dynamic so that flutter can call this function by itself
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                //we used expanded and didn't passed it directly because it's like return other column inside of a coloumn
                //flutter doesn't know how to size and restrict coloumns thus we use expanded
                Expanded(
                  child: mainContent,
                )
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(
                  child: mainContent,
                )
              ],
            ),
    );
  }
}
