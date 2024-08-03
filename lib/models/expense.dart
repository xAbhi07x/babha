import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd(); //year-month-date

//allow us to create custom type that supports these possible values
enum Category { food, travel, lesiure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.lesiure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work
};

//definition of our expense value objects
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  //initializer list feature is dart feature
  //uuid is 3rd party feature
  //generates a unique string id and assign the id into inital id property

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  //getters are basically "computed properties" => properties that are dynamically derived, based on other class properties
  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((expense) => expense.category == category).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
