import '../../const/common_lib.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.labelText,
    this.controller,
    this.onTap,
    this.validator,
    this.readOnly = false,
    this.keyboardType,
    this.decoration,
  });
  final String? labelText;
  final void Function()? onTap;
  final bool readOnly;
  final InputDecoration? decoration;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    var bodySmall2 = theme.textTheme.bodySmall?.copyWith(
        color: appColors.gray500, fontWeight: FontWeight.w500, fontSize: 12.sp);
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      validator: validator,
      onTap: onTap,
      cursorColor: appColors.gray500,
      keyboardType: keyboardType,
      decoration: decoration ??
          InputDecoration(
            label: labelText != null ? Text(labelText!) : null,
            labelStyle: bodySmall2,
          ),
    );
  }
}
