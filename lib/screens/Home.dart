import 'package:expenses_planner/models/Transaction.dart';
import 'package:expenses_planner/widgets/chart.dart';
import 'package:expenses_planner/widgets/transaction_list.dart';

import '../widgets/new_transaction.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addnewTransactions(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        amount: amount,
        date: chosenDate,
        title: title);
    setState(() {
      _userTransactions.add(newTx);
      // print(newTx.amount);
    });
  }

  void _startAddnewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addnewTransactions);
        });
  }

  void _deleteTransactions(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  bool _switchval = false;
  @override
  Widget build(BuildContext context) {
    final bool _isLandsape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Expensess Planner'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _startAddnewTransaction(context);
          },
          splashRadius: 20,
          splashColor: Colors.deepPurpleAccent,
        )
      ],
    );
    final txChartview = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            (_isLandsape ? 0.7 : 0.35),
        child: Chart(_recentTransactions));
    final txListview = Container(
        height: MediaQuery.of(context).size.height * 0.55,
        child: TransactionList(_userTransactions, _deleteTransactions));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (_isLandsape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Show Chart'),
                    Switch(
                        value: _switchval,
                        onChanged: (val) {
                          setState(() {
                            _switchval = val;
                          });
                        })
                  ],
                ),if (_isLandsape) 
                  _switchval
                  ? txChartview
                  : txListview,
                if(!_isLandsape)txChartview,if(!_isLandsape)txListview
              
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddnewTransaction(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
