import 'package:flutter/material.dart';
import 'package:flutter_reference/models/expense.dart';
import 'package:flutter_reference/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          direction: DismissDirection.endToStart,
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(.8),
            margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),
          key: ValueKey(
            expenses[index],
          ),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          child: ExpenseItem(
            expense: expenses[index],
          ),
        );
      },
    );
  }
}
