import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:laroch/utils/theme_helper.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    Key? key,
    required this.selectedValue,
    required this.dropDownList,
    required this.onChanged,
    required this.tag,
  }) : super(key: key);

  final String selectedValue;
  final String tag;
  final List<String> dropDownList;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(".\n\n\n\n\n\ndropdown value : $selectedValue.\n\n\n\n\n\n.");
    }

    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
        iconEnabledColor: appColors.gray500,
        value: selectedValue,
        hint: Text(
          "Select $tag",
          style:
              theme.textTheme.bodyMedium?.copyWith(color: appColors.black900),
        ),
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.black54),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.zero),
            borderSide: BorderSide(
                color: appColors.black900.withOpacity(0.5), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.zero),
            borderSide: BorderSide(
                color: appColors.black900.withOpacity(0.5), width: 1.0),
          ),
        ),
        onChanged: onChanged,
        items: dropDownList
            .map(
              (value) => DropdownMenuItem(
                value: value,
                child: SizedBox(
                  width: 120,
                  child: Text(
                    value,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: appColors.black900),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
