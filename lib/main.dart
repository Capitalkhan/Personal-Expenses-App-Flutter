import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/new_transactions.dart';
import './models/transaction.dart';
import './Widgets/transaction_list.dart';
import 'Widgets/chart.dart';
// import 'package:flutter/services.dart';

void main() {
  // code for restrict land scope mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',

      theme: ThemeData(
        primarySwatch: Colors.purple,
        hintColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: const TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18
          )
        ),
        appBarTheme: AppBarTheme(
        )

      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Transaction> _transactionList = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'New Groceries',
    //   amount: 16.57,
    //   date: DateTime.now(),
    // )
  ];

  bool _showSwitch = false;
  
  List<Transaction> get _recentTransaction{
    return _transactionList.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNewTransaction(String title,double amount,DateTime chosenDate){
    final newTx = Transaction(id: '${DateTime.now()}', title: title, amount: amount, date: chosenDate);
    setState(() {
      _transactionList.add(newTx);
    });
  }
  void _startTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return NewTransaction(addNewTransaction);
    },);
  }

  void _deleteTransaction(String id){
    setState(() {
      _transactionList.removeWhere((tx) => tx.id == id);
    });
  }




  // String titleInput = '';
  @override
  Widget build(BuildContext context) {

    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

     final appBar = AppBar(
      backgroundColor: Colors.purple,
      title: Text('Personal Expenses',style: TextStyle(fontFamily: 'Open Sans',fontSize: 20, fontWeight: FontWeight.bold),),
      actions: [
        InkWell(
          onTap: () => _startTransaction(context),
          child: Container(
            margin: const EdgeInsets.only(right: 22),
            child: const Icon(
              Icons.add,
              size: 27,
            ),
          ),
        )
      ],
    );

    final txListWidget = Container(
        height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,

        child: TransactionList(_transactionList,_deleteTransaction));

    final pageBody = SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          if(isLandscape) Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Show Chart'),
              Switch.adaptive(
                  value: _showSwitch, onChanged: (val){
                setState(() {
                  _showSwitch = val;
                });
              })
            ],),
          if(!isLandscape) Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.3,
              child: Chart(_recentTransaction)
          ),
          if(!isLandscape) txListWidget,
          if(isLandscape) _showSwitch ? Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
              child: Chart(_recentTransaction)
          ) : txListWidget,

        ],
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: pageBody,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        child: Icon(Icons.add,color: Colors.black,),
        backgroundColor: Theme.of(context).hintColor,

        onPressed: ()=> _startTransaction(context),
      ),
    );
  }
}


