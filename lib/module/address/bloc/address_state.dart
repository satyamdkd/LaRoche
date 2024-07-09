part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();
}

class AddressInitial extends AddressState {
  @override
  List<Object> get props => [];
}
