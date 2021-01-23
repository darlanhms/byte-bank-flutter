import 'package:bytebankflutter/components/CustomInput.dart';
import 'package:bytebankflutter/models/Transfer.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text("Criando transferência"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomInput(
              controller: _controllerAccountNumber,
              label: "Número da conta",
              hint: "0000",
              inputType: TextInputType.number,
            ),
            CustomInput(
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
