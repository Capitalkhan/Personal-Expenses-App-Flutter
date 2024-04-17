import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {

    final Function addTx;
    NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void submitData(){
    if(amountController.text.isEmpty){
      return;
    }
    final inputTitle = titleController.text;
    final inputAmount = double.parse(amountController.text);

    if(inputTitle.isEmpty || inputAmount <= 0 || _selectedDate == null){
      return;
    }
    widget.addTx(inputTitle,inputAmount,_selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2023), lastDate: DateTime.now()).then((picketDate){
      if(picketDate == null){
        return;
      }
      setState(() {
        _selectedDate = picketDate;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                keyboardType: TextInputType.text,

                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: titleController,
                onSubmitted: (val) => submitData(),
                // onChanged: (val){
                //   titleInput = val;
                // },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',

                ),
                controller: amountController,
                onSubmitted: (_) => submitData(),
                // onChanged: (val){
                //   amountInput = val;
                // },
              ),
              Container(
                height: 80,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(child: Text(_selectedDate == null ?'No Data Chosen!': DateFormat.yMd().format(_selectedDate),style: TextStyle(fontSize: 15),)),
                      SizedBox(width: 10,),
                      InkWell(
                          onTap: (){
                            _presentDatePicker();
                          },
                          child: Text('Choose Date', style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,fontSize: 15,fontFamily: 'Quicksand')),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: (){
                    submitData();
                  },
                  child: Text('Add Transaction',style: TextStyle(fontFamily: 'Quicksand'),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
