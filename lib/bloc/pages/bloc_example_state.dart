import 'package:equatable/equatable.dart';

enum Status { initial, loading, success, failure }

class BlocExampleState extends Equatable {
  final int counter;
  final Status status;

  const BlocExampleState({required this.counter, required this.status});

  BlocExampleState copyWith({
    int? counter,
    Status? status,
  }) {
    return BlocExampleState(
        counter: counter ?? this.counter, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [counter, status];
}
