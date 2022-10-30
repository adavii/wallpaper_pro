// import 'package:a_wallet/utils/validation.dart';
import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String? title;
  final Function callback;
  final Function onsubmit;
  final IconData? icon;
  final TextInputType? inputType;
  final String? errorText;
  final TextAlign? align;
  final String? hindText;
  final String? value;
  final bool? enabled;
  final TextEditingController? controller;
  final bool autofocus;
  final Widget? suffixWidget;
  final double? fontSIze;

  const TextInput({
    Key? key,
    this.title,
    required this.callback,
    required this.onsubmit,
    this.inputType = TextInputType.text,
    this.errorText = "This Field is required",
    this.hindText = "",
    this.value = "",
    this.enabled = true,
    this.icon,
    this.align,
    this.controller,
    this.autofocus = false,
    this.suffixWidget,
    this.fontSIze,
  }) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (value) => widget.onsubmit(value),
      onChanged: (value) => widget.callback(value),
      autofocus: widget.autofocus,
      controller: widget.controller,
      keyboardType: widget.inputType,
      initialValue: widget.controller == null ? widget.value : null,
      enabled: widget.enabled,
      style: TextStyle(
        color: widget.enabled! ? null : Colors.grey,
        fontSize: widget.fontSIze,
      ),
      textAlign: widget.align ?? TextAlign.left,
      obscureText:
          widget.inputType == TextInputType.visiblePassword && !passwordVisible,
      decoration: InputDecoration(
        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon,
              )
            : null,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0),
        ),
        labelText: widget.title,
        hintText: widget.hindText,
        suffixIcon: widget.inputType == TextInputType.visiblePassword
            ? IconButton(
                icon: Icon(
                  passwordVisible
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              )
            : widget.suffixWidget,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.errorText;
          // } else if (widget.inputType == TextInputType.emailAddress &&
          //     !isValidEmail(value.trim())) {
          //   return "Enter valid email address";
          // } else if (widget.inputType == TextInputType.visiblePassword &&
          //     !validateLength(value.trim(), min: 8)) {
          //   return "Password should be contain minimum 8 characters";
        }
        return null;
      },
    );
  }
}
