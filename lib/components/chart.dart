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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactions.map((transaction) {
          return ChartBar(
            label: transaction['day'],
            value: transaction['value'],
            percentage: 0.3,
          );
          // return Text('${transaction['day']}: ${transaction['value']}');
        }).toList(),
      ),
    );
  }
}
