import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final void Function(String) onRemove;

  TransactionItem({this.transaction, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text('R\$${transaction.value.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          '${transaction.title}',
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? FlatButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                textColor: Colors.purple[200],
                onPressed: () => onRemove(transaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.purple[100],
                onPressed: () => onRemove(transaction.id),
              ),
      ),
    );
  }
}
