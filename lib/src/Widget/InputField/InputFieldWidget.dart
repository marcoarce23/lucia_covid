import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Util/Validator.dart' as validator;

class InputTextField extends StatefulWidget {
  String objectValue;
  final String text;
  final Icon icon;
  final String hint;

  InputTextField(this.icon, this.text, this.objectValue, this.hint);

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
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
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: widget.hint,
          labelText: widget.text,
          icon: widget.icon,
        ),
        onChanged: (value) {
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


class InputTextPassword extends StatefulWidget {
  String objectValue;
  final String text;
  final Icon icon;
  final String hint;

  InputTextPassword(this.icon, this.text, this.objectValue, this.hint);

  @override
  _InputTextPasswordState createState() => _InputTextPasswordState();
}

class _InputTextPasswordState extends State<InputTextPassword> {
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
   
   return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: widget.objectValue,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        maxLength: 10,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: widget.hint,
          labelText: widget.text,
          icon: widget.icon,
        ),
        validator: (value) => validator.validateTextfieldLength(value, 6),
        onSaved: (value) => widget.objectValue = value,
      ),
    );
  }
}


class InputEmailField extends StatefulWidget {
  String objectValue;
  final String text;
  final Icon icon;
  final String hint;
  final String helperText;

  InputEmailField(this.icon, this.text, this.objectValue, this.hint, this.helperText);

  @override
  _InputEmailFielddState createState() => _InputEmailFielddState();
}

class _InputEmailFielddState extends State<InputEmailField> {
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: widget.objectValue,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: widget.hint,
          labelText: widget.text,
          helperText: widget.helperText,
          errorMaxLines: 6,
          icon: widget.icon,
        ),
        onChanged: (value) {
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




class InputPhoneField extends StatefulWidget {
  String objectValue;
  final String text;
  final Icon icon;
  final String hint;

  InputPhoneField(this.icon, this.text, this.objectValue, this.hint);

  @override
  _InputPhoneFieldState createState() => _InputPhoneFieldState();
}

class _InputPhoneFieldState extends State<InputPhoneField> {
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: widget.objectValue,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: widget.hint,
          labelText: widget.text,
          icon: widget.icon,
        ),
        onChanged: (value) {
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

class InputUrlField extends StatefulWidget {
  String objectValue;
  final String text;
  final Icon icon;
  final String hint;

  InputUrlField(this.icon, this.text, this.objectValue, this.hint);

  @override
  _InputUrlState createState() => _InputUrlState();
}

class _InputUrlState extends State<InputUrlField> {
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: widget.objectValue,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.url,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: widget.hint,
          labelText: widget.text,
          icon: widget.icon,
        ),
        onChanged: (value) {
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


class InputNumberField extends StatefulWidget {
  String objectValue;
  final String text;
  final Icon icon;
  final String hint;

  InputNumberField(this.icon, this.text, this.objectValue, this.hint);

  @override
  _InputNumberFieldState createState() => _InputNumberFieldState();
}

class _InputNumberFieldState extends State<InputNumberField> {
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: widget.objectValue,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: widget.hint,
          labelText: widget.text,
          icon: widget.icon,
        ),
        onChanged: (value) {
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

class InputMultilineField extends StatefulWidget {
  String objectValue;
  final String text;
  final Icon icon;
  final String hint;

  InputMultilineField(this.icon, this.text, this.objectValue, this.hint);

  @override
  _InputMultilineFieldState createState() => _InputMultilineFieldState();
}

class _InputMultilineFieldState extends State<InputMultilineField> {
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: TextFormField(
        initialValue: widget.objectValue,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          focusColor: Colors.blue,
          hintText: widget.hint,
          labelText: widget.text,
          icon: widget.icon,
        ),
        onChanged: (value) {
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



class InputSexo extends StatefulWidget {

  InputSexo( );

  @override
  _InputSexoState createState() => _InputSexoState();
}

class _InputSexoState extends State<InputSexo> {
    int _selectedRadio = 0;
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
   
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Masculino'),
          leading: Radio(
            value: 0,
            activeColor: Colors.orangeAccent,
            groupValue: _selectedRadio,
            onChanged: (value) {
              setSelectedRadio(value);
            },
          ),
        ),
        ListTile(
          title: Text('Femenino'),
          leading: Radio(
            value: 1,
            activeColor: Colors.orangeAccent,
            groupValue: _selectedRadio,
            onChanged: (value) {
              setSelectedRadio(value);
            },
          ),
        ),
      ],
    );
  }
   setSelectedRadio(int value) {
    setState(() {
      _selectedRadio = value;
    });
  }
}




class InputCheckBox extends StatefulWidget {
  final String text;
  
  InputCheckBox(this.text );

  @override
  _InputCheckBoxState createState() => _InputCheckBoxState();
}

class _InputCheckBoxState extends State<InputCheckBox> {
  bool  _selected = false;
  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
   
    return CheckboxListTile(
        title: new Text(widget.text), 
        value: _selected, 
        onChanged: (value) {
          setState(() {
             _selected = value;
          });
        }
    );
  }
}

