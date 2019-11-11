import 'package:flutter/material.dart';

typedef Null ValueChangeCallback(String value);

class TextFormFieldValidation extends StatefulWidget {
  final ValueChangeCallback onValueChanged;
  final String hint;
  final TextEditingController controller;
  final Function validator;
  final Color containerColor;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final FormFieldSetter<String> onSaved;
  final bool enabled;
  final String initialValue;
  final bool obscureText;

  TextFormFieldValidation({
    Key key,
    @required this.hint,
    this.controller,
    @required this.onValueChanged,
    this.enabled = true,
    this.onSaved,
    this.keyboardType,
    this.textCapitalization,
    this.validator,
    this.containerColor,
    this.initialValue,
    this.obscureText,
  }) : super(key: key);

  @override
  _TextFormFieldValidationState createState() => _TextFormFieldValidationState();
}

class _TextFormFieldValidationState extends State<TextFormFieldValidation> {
  TextEditingController valueController;
  @override
  void initState() {
    super.initState();
    valueController = widget.controller ?? TextEditingController.fromValue(TextEditingValue(text: widget.initialValue ?? ""));
    valueController.addListener(() {
      widget.onValueChanged(valueController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextFormField(
        maxLines: null,
        enabled: widget.enabled ?? true,
        onSaved: widget.onSaved ?? (String value) {},
        keyboardType: widget.keyboardType ?? TextInputType.text,
        textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
        obscureText: widget.obscureText ?? false,
        controller: valueController,
        validator: widget.validator ??
            (String value) {
              if (value.isEmpty) {
                return 'This field is required';
              }
              if (value.length < 2) {
                return 'Characters must be a min of 2';
              }
              return null;
            },
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).backgroundColor,
          labelText: widget.hint,
          labelStyle: Theme.of(context).textTheme.caption.copyWith(fontSize: 14),
          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).accentColor.withOpacity(.5))),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).accentColor.withOpacity(.5))),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).accentColor.withOpacity(.8))),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).accentColor.withOpacity(.5))),
        ),
      ),
    );
  }
}
