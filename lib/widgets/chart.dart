import '../models/Transaction.dart';
import '../widgets/chart-bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupTransactinoValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalsum=0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalsum += recentTransactions[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekday).substring(0,2), 'amount': totalsum};
    });
  }
  double get totalspending{
    return groupTransactinoValues.fold(0.0, (sum, element) => sum+element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    //print(groupTransactinoValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: groupTransactinoValues.map((e){
           return Flexible(fit: FlexFit.tight,child: ChartBar(e['day'],e['amount'],totalspending==0.0?0.0:(e['amount'] as double)/totalspending));
         } ).toList(),
        ),
      ),
    );
  }
}
