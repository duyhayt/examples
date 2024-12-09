import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testkey/bloc/pages/bloc_example_event.dart';
import 'package:testkey/bloc/pages/bloc_example_state.dart';

class BlocExampleBloc extends Bloc<BlocExampleEvent, BlocExampleState> {
  BlocExampleBloc()
      : super(const BlocExampleState(counter: 0, status: Status.initial)) {
    on<IncrementCounter>(_incrementCounter);
  }

  Future<void> _incrementCounter(
      IncrementCounter event, Emitter<BlocExampleState> emit) async {
    emit(state.copyWith(counter: state.counter + 1));
  }
}
