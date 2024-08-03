import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

//mein us expense list ko show kar raha hun jo ki Expense type ka he

//just to output the list of data and here we are not managing the data
class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    //when we use COloumn, all the childrens will be created BTS by flutter whenever this build method will be called
    //problem is it could be 1000, and it could be scrollable but initially it would be invisible and creating all the invisible items BTS at beginning
    //is really redundant and costs a lots of performance,
    //thus we shouldn't use coloumn where we don't know the length but we might have big list of items

    //if you create like this "ListView(children: [],)" then its still BTS create all the children widgets and the only thing
    //that we gain extraa from coloumn is that it is now scrollable

    //this builder method creates a scrollable list and also tells show items only when they are about to be visible
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        //dismissible allows us to add the swipe delete options
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          margin: const EdgeInsets.symmetric(horizontal: 16),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}

//the key mechanisms exist to make widgets uniquely identifiable