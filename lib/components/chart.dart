import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/components/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        bool isSameDay = recentTransactions[i].date.day == weekDay.day;
        bool isSameMonth = recentTransactions[i].date.month == weekDay.month;
        bool isSameYear = recentTransactions[i].date.year == weekDay.year;

        if (isSameDay && isSameMonth && isSameYear) {
          totalSum += recentTransactions[i].value;
        }
      }
      return {
        // vai pegar a primeira letra do dia da semana
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, transaction) {
      return sum + transaction['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.fromLTRB(5, 20, 5, 20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((transaction) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: transaction['day'],
                value: transaction['value'],
                percentage: _weekTotalValue == 0
                    ? 0
                    : (transaction['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
