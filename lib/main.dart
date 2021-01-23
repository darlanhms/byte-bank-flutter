import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary),
      ),
      home: TransferList(),
    );
  }
}

class TransferForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TransferFormState();
}

class TransferFormState extends State<TransferForm> {
  final TextEditingController _controllerAccountNumber =
      TextEditingController();
  final TextEditingController _controllerValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TransferInput(
              controller: _controllerAccountNumber,
              label: "Número da conta",
              hint: "0000",
              inputType: TextInputType.number,
            ),
            TransferInput(
              controller: _controllerValue,
              label: "Valor",
              hint: "0.00",
              icon: Icons.monetization_on,
              inputType: TextInputType.number,
            ),
            RaisedButton(
              child: Text("Confirmar"),
              onPressed: () => _createTransfer(context),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Criando transferência"),
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final int accountNumber = int.tryParse(_controllerAccountNumber.text);
    final double value = double.tryParse(_controllerValue.text);

    if (accountNumber != null && value != null) {
      final transfer = Transfer(value, accountNumber);

      Navigator.pop(context, transfer);
    }
  }
}

class TransferInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType inputType;
  final IconData icon;

  TransferInput({
    this.controller,
    this.label,
    this.hint,
    this.inputType = TextInputType.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          icon: icon != null ? Icon(icon) : null,
        ),
        keyboardType: inputType,
      ),
    );
  }
}

class TransferList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TransferListState();
}

class TransferListState extends State<TransferList> {
  final List<Transfer> _transfers = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _transfers.length,
        itemBuilder: (context, index) {
          final transfer = _transfers[index];
          return TransferItem(transfer);
        },
      ),
      appBar: AppBar(
        title: Text("Tranferências"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transfer> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransferForm(),
            ),
          );

          future.then((receivedTransfer) {
            if (receivedTransfer != null) {
              setState(() {
                _transfers.add(receivedTransfer);
              });
            }
          });
        },
      ),
    );
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

class Transfer {
  final double value;
  final int accountNumber;

  Transfer(this.value, this.accountNumber);

  @override
  String toString() {
    return 'Transferencia{ value: $value, account: $accountNumber }';
  }
}
