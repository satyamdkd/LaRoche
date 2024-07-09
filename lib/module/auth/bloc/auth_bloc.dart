import 'package:equatable/equatable.dart';
import '../../../const/common_lib.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<RegisterValidatorEvent>(formValidator);
  }

  var formKeyForAccountsInfo = GlobalKey<FormState>();

  formValidator(RegisterValidatorEvent event, Emitter<AuthState> emit) {
    final isValid = formKeyForAccountsInfo.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKeyForAccountsInfo.currentState!.save();
    emit(RegisterValidatorState(formKeyForAccountsInfo));
  }
}
