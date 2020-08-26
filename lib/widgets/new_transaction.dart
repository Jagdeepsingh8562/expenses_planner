import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final amtController = TextEditingController();
  final titleController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmt = double.parse(amtController.text);
    if (enteredTitle.isEmpty) {
      return print('cfxgnv');
    }
    if (enteredTitle.isEmpty || enteredAmt <= 0 ||_selectedDate==null) {
      return print('cfxgnv');
    }
    widget.addTx(enteredTitle, enteredAmt,_selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()).then((value) {
          if (value==null) {
            return;
          }setState(() {
            _selectedDate=value;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                controller: amtController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                onSubmitted: (_) => submitData(),
              ),
              SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedDate==null?'No Date Choosen!':'Picked date${DateFormat.yMMMd().format(_selectedDate)}'),
                  FlatButton(
                      onPressed: () => _presentDatePicker(),
                      child: Text(
                        'Pick Date',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ))
                ],
              ),
              RaisedButton(
                onPressed: () => submitData(),
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
