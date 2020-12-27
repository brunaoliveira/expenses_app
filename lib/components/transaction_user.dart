import 'package:flutter/material.dart';
import 'dart:math';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Running shoes',
      value: 310.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Power bill',
      value: 121.35,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Power bill',
      value: 121.35,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Power bill',
      value: 121.35,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Power bill',
      value: 121.35,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Power bill',
      value: 121.35,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Power bill',
      value: 121.35,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Power bill',
      value: 121.35,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Power bill',
      value: 121.35,
      date: DateTime.now(),
    ),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionForm(_addTransaction),
        TransactionList(_transactions),
      ],
    );
  }
}