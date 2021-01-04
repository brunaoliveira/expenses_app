import 'package:expenses/components/adaptive_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:expenses/components/adaptive_button.dart';
import 'package:expenses/components/adaptive_text_field.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
              left: 10,
              right: 10,
              top: 10,
            ),
            child: Column(
              children: <Widget>[
                AdaptiveTextField(
                  label: 'Title',
                  keyboard: TextInputType.emailAddress,
                  controller: _titleController,
                  autofocus: true,
                  onSubmited: (_) => _submitForm(),
                ),
                AdaptiveTextField(
                  label: 'Value (R\$)',
                  keyboard: TextInputType.numberWithOptions(decimal: true),
                  controller: _valueController,
                  autofocus: false,
                  onSubmited: (_) => _submitForm(),
                ),
                AdaptiveDatePicker(
                  selectedDate: _selectedDate,
                  onDateChange: (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    AdaptiveButton(
                      label: 'New transaction',
                      onPressed: _submitForm,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
