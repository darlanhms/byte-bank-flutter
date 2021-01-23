import 'package:bytebankflutter/models/Transfer.dart';
import 'package:bytebankflutter/screens/Form.dart';
import 'package:flutter/material.dart';

class TransferList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TransferListState();
}

class TransferListState extends State<TransferList> {
  final List<Transfer> _transfers = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tranferências"),
      ),
      body: ListView.builder(
        itemCount: _transfers.length,
        itemBuilder: (context, index) {
          final transfer = _transfers[index];
          return TransferItem(transfer);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push<Transfer>(
            context,
            MaterialPageRoute(
              builder: (context) => TransferForm(),
            ),
          ).then(
            (receivedTransfer) => _handleTransferReceived(receivedTransfer),
          );
        },
      ),
    );
  }

  void _handleTransferReceived(Transfer receivedTransfer) {
    if (receivedTransfer != null) {
      setState(() {
        _transfers.add(receivedTransfer);
      });
    }
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer;

  TransferItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}
