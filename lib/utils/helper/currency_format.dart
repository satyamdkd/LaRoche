import 'package:intl/intl.dart';

final _formatCurrency =
    NumberFormat.simpleCurrency(name: "", decimalDigits: 2);

String rupee(double? amount) {
  return _formatCurrency.format(amount);
}
