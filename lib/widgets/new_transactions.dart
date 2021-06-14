import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;

  NewTransactions(this.addTx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleControler = TextEditingController();

  final _amountControler = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {


    if(_amountControler.text.isEmpty){


      return;
    }
    final enteredTitle = _titleControler.text;
    final enteredAmount = double.parse(_amountControler.text);

    //If i do not give any value in title InputText and if the amount is less than 0 then it will not added any transaction.

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate==null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    //   showDatePicker(
    //       context: context,
    //       initialDate: DateTime.now(),
    //       firstDate: DateTime(2019),
    //       lastDate: DateTime.now());

    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),

              controller: _titleControler,
              onSubmitted: (_) => _submitData,

              // onChanged: (val){

              //   titleInput=val;
              //  },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountControler,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData,

              //   onChanged: (val){
              //   amountInput=val;

              // },
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text(_selectedDate == null
                      ? 'No Date Chose!'
                      : DateFormat.yMd().format(_selectedDate)),
                  FlatButton(
                    child: Text(
                      'Choose A Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: _submitData
                //  print(titleInput);
                //  print(amountInput);

                ),
          ],
        ),
      ),
    );
  }
}
