import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/components/chart.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);

    return MaterialApp(
      home: MyHomePage(),
      builder: (context, child) {
        return Theme(
          child: child,
          data: ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: 'Quicksand',
            highlightColor: Colors.amber,
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20 * MediaQuery.of(context).textScaleFactor,
                    fontWeight: FontWeight.bold,
                  ),
                  button: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.purple[400],
              foregroundColor: Colors.white,
            ),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20 * MediaQuery.of(context).textScaleFactor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
            accentColor: Colors.amber,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => TransactionForm(_addTransaction),
    );
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        'Personal Expenses',
      ),
      actions: <Widget>[
        if (isLandscape)
          IconButton(
            icon: Icon(
                _showChart ? Icons.format_list_bulleted : Icons.insert_chart),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
      ],
    );
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_showChart || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 0.8 : 0.3),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
