import 'package:equatable/equatable.dart';

sealed class BlocExampleEvent extends Equatable {
  const BlocExampleEvent();

  @override
  List<Object> get props => [];
}

class IncrementCounter extends BlocExampleEvent {
  const IncrementCounter();

  @override
  List<Object> get props => [];
}
