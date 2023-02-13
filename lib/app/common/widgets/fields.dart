import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_project/app/common/extensions/string_extension.dart';
import 'package:google_fonts/google_fonts.dart';

import '../enums/user_gender_enum.dart';
import '../styles/colors.dart';

class TextInput extends Container {
  TextInput({
    required String hintText,
    String? helperText = '',
    String? errorText,
    TextEditingController? controller,
    TextInputAction? textInputAction,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.sentences,
    FormFieldValidator<String>? validator,
    IconButton? suffixIcon,
    FocusNode? focusNode,
    bool? enabled,
    Function(String value)? onFieldSubmitted,
    Function(String value)? onChanged,
    int? minLines,
    int? maxLines,
    bool autofocus = false,
    EdgeInsets? margin,
    List<TextInputFormatter>? inputFormatters,
  }) : super(
          margin: margin ?? EdgeInsets.only(top: 16, bottom: 8),
          child: TextFormField(
            autofocus: autofocus,
            autovalidateMode: AutovalidateMode.always,
            controller: controller,
            textInputAction: textInputAction,
            textCapitalization: textCapitalization,
            keyboardType: keyboardType,
            validator: validator,
            style: _textStyle(fontSize: 16, color: AppColor.slate, height: .9),
            cursorColor: AppColor.midBlue,
            cursorWidth: 1,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              suffixIcon: suffixIcon,
              errorText: errorText,
              labelStyle: _textStyle(fontSize: 16, color: AppColor.slate),
              hintText: hintText,
              hintStyle: _textStyle(color: AppColor.slate),
              helperText: helperText,
              helperMaxLines: 5,
              helperStyle: _textStyle(color: AppColor.slate.withOpacity(.5), height: .9),
              enabledBorder: _border(color: AppColor.slate.withOpacity(.5), width: 1),
              disabledBorder: _border(color: AppColor.slate.withOpacity(.3), width: 1),
              focusedBorder: _border(color: AppColor.midBlue),
              focusedErrorBorder: _border(color: AppColor.darkPeach),
              errorStyle: _textStyle(color: AppColor.darkPeach, height: .9),
              errorMaxLines: 5,
              errorBorder: _border(color: AppColor.darkPeach),
            ),
            enabled: enabled,
            focusNode: focusNode,
            onEditingComplete: focusNode == null ? null : () => focusNode.unfocus(),
            onFieldSubmitted: onFieldSubmitted ?? (_) {},
            minLines: minLines,
            maxLines: maxLines,
            onChanged: onChanged ?? (_) {},
          ),
        );

  static TextStyle _textStyle({
    double fontSize = 12,
    Color color = AppColor.darkPeach,
    double height = 1,
  }) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      height: height,
      color: color,
    );
  }

  static OutlineInputBorder _border({required Color color, double width = 2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }
}

class GenderInput extends StatefulWidget {
  final Function(UserGender? value) onChanged;
  final String? errorText;

  GenderInput({
    required this.onChanged,
    this.errorText,
  });

  @override
  State<StatefulWidget> createState() => GenderInputState();
}

class GenderInputState extends State<GenderInput> {
  UserGender? _value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Listener(
                onPointerDown: (_) => FocusScope.of(context).unfocus(),
                child: Container(
                  padding: EdgeInsets.only(top: 2, left: 11, right: 7, bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: !widget.errorText.isNullOrEmpty ? AppColor.darkPeach : AppColor.slate.withOpacity(.5),
                      width: !widget.errorText.isNullOrEmpty ? 2 : 1,
                    ),
                  ),
                  child: DropdownButton<UserGender>(
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: AppColor.slate,
                    ),
                    hint: Text('Select your gender'),
                    isExpanded: true,
                    value: _value,
                    onChanged: (UserGender? value) {
                      setState(() => _value = value);
                      widget.onChanged(value);
                    },
                    items: <UserGender>[
                      UserGender.female,
                      UserGender.male,
                      UserGender.preferNotToSay,
                    ].map<DropdownMenuItem<UserGender>>(
                      (UserGender value) {
                        String? text;
                        text = value.getString;
                        return DropdownMenuItem<UserGender>(
                          value: value,
                          child: Text(text),
                        );
                      },
                    ).toList(),
                    underline: Container(),
                  ),
                ),
              ),
            ),
            !widget.errorText.isNullOrEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Text(widget.errorText!, style: GoogleFonts.roboto(fontSize: 12, color: AppColor.darkPeach)),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
