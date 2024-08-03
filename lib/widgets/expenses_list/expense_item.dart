import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

// mein ek-ek item le raha hun and usko present kar raha hun
// ye item mein expenses_list se le raha hun

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title, style: const TextStyle(color: Colors.black),),
            const SizedBox(height: 4),
            Row(
              children: [
                //escaping the character by using backward slash
                Text('\$${expense.amount.toStringAsFixed(2)}'), //12.3433 => 12.34
                const Spacer(), 
                //can be used in any coloumn or row between 2 widgets that says any remaining space
                //between these widgets will be taken by me. hence i will push one to the left and the other to the right

                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8,),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
