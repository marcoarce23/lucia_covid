
import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Util/Validator.dart' as validator;


class InputTextState extends StatefulWidget {

  String objectValue ;
  final String text;
  final Icon icon;

  InputTextState(this.icon, this.text, this.objectValue);

  @override
  _InputTextStateState createState() => _InputTextStateState();
}

class _InputTextStateState extends State<InputTextState> {
  @override
  Widget build(BuildContext context) {
     return getWidget();
  }

  Widget getWidget() {
    return Padding(
    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
    child: TextFormField(
      initialValue: widget.objectValue,
      textCapitalization: TextCapitalization.sentences,
      enableInteractiveSelection: true,

      enableSuggestions: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        focusColor: Colors.blue,
        hintText: widget.text,
        labelText: widget.text,
        icon: widget.icon,
      ),
      onChanged: (value){
          setState(() {
            widget.objectValue = value;
          });
      },
      validator: (value) => validator.validateTextfieldEmpty(value),
      onSaved: (value) => widget.objectValue = value,
    ),
  );
  }
}