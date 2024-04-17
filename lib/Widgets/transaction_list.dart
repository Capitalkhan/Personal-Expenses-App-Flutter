import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';


class TransactionList extends StatelessWidget {

  final List<Transaction> transactionList;
  final Function deleteTx;

  TransactionList(this.transactionList,this.deleteTx);



  @override
  Widget build(BuildContext context) {
    return transactionList.isEmpty ? LayoutBuilder(builder: (ctx,constraints){
      return Column(
        children: [
          Text('!No transaction added yet', style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 20,),
          Container(
              height: constraints.maxHeight * 0.6,
              child: Image.asset('assets/image/waiting.png')

          ),
        ],
      );
    })  : ListView.builder(

      itemBuilder: (ctx,index){
        return Card(

          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(6),
                  child: FittedBox(child: Text("\$${transactionList[index].amount}"))),
            ),
            title: Text(transactionList[index].title,style: Theme.of(context).textTheme.titleMedium,),
            subtitle: Text(DateFormat.yMMMd().format(transactionList[index].date)),
            trailing: MediaQuery.of(context).size.width > 460
              ? ElevatedButton.icon(

                icon: Icon(Icons.delete, color: Colors.red,),
                label: Text('Delete' ,),


              onPressed: () {deleteTx(transactionList[index].id);},
            )
                : IconButton(icon: Icon(Icons.delete), color: Colors.red,
            onPressed: () {
              deleteTx(transactionList[index].id);
            },
            ),
          ),
        );

        //   Card(
        //   child: Row(
        //     children: [
        //       Container(
        //         margin: const EdgeInsets.symmetric(
        //           vertical: 10,
        //           horizontal: 15,
        //         ),
        //         padding: EdgeInsets.all(10),
        //         decoration: BoxDecoration(
        //             border: Border.all(color: Theme.of(context).primaryColor, width: 3)),
        //         child: Text(
        //           '\$${transactionList[index].amount.toStringAsFixed(2)}',
        //           style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               fontSize: 20,
        //               color: Colors.purple,
        //
        //           ),
        //         ),
        //       ),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             transactionList[index].title,
        //             style: Theme.of(context).textTheme.titleMedium,
        //           ),
        //           Text(
        //             DateFormat.yMMMd().format(transactionList[index].date)
        //              ,
        //             style: TextStyle(color: Colors.grey),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // );
      },
      itemCount: transactionList.length,
    );
  }
}
