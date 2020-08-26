import 'package:intl/intl.dart';

import '../models/Transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final deleteTx;
  TransactionList(this.transactions,this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      padding: EdgeInsets.all(8),
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx,constraints){
            return Column(
              children: [
                FittedBox(
                    child: Text(
                    'No Transactions added yet!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                  height: constraints.maxHeight*0.7,
                )
              ],
            );})
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      child: FittedBox(
                        child: Text(
                            '₹${transactions[index].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                    title: Text(transactions[index].title.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                        style: TextStyle(color: Colors.grey[600])),
                  trailing: IconButton(icon: Icon(Icons.delete,color: Colors.redAccent,), onPressed: ()=>deleteTx(transactions[index].id),splashRadius: 20),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
