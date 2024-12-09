import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_example_bloc.dart';
import 'bloc_example_event.dart';
import 'bloc_example_state.dart';

class BlocExamplePage extends StatefulWidget {
  const BlocExamplePage({super.key});

  @override
  State<BlocExamplePage> createState() => _BlocExamplePageState();
}

class _BlocExamplePageState extends State<BlocExamplePage> {
  @override
  Widget build(BuildContext context) {
    /* -------------- BlocBuilder -------------- */
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('BLoC Example'),
    //   ),
    //   body: BlocBuilder<BlocExampleBloc, BlocExampleState>(
    //     // Nếu sử dụng buildWhen thì UI sẽ không cập nhật vì status không thay đổi
    //     // buildWhen: (previous, current) => previous.status != current.status,
    //     builder: (context, state) {
    //       return Center(
    //         child: Text("${state.counter}"),
    //       );
    //     },
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //       onPressed: () {
    //         context.read<BlocExampleBloc>().add(const IncrementCounter());
    //       },
    //       child: const Icon(Icons.add)),
    // );

    /* -------------- BlocListener -------------- */

    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC Example'),
      ),
      body: BlocListener<BlocExampleBloc, BlocExampleState>(
        // Nếu sử dụng listenWhen thì sẽ không show snackbar vì status không thay đổi
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          // Nếu chỉ sử dụng listener thì sẽ show snackbar vì sẽ lắng nghe trạng thái toàn cục
          if (state.counter == 5) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Counter = 10")));
          }
        },
        child: Center(
          child: Text("${context.watch<BlocExampleBloc>().state.counter}"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<BlocExampleBloc>().add(const IncrementCounter());
          },
          child: const Icon(Icons.add)),
    );

    /* -------------- BlocConsumer -------------- */
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('BLoC Example'),
    //   ),
    //   body: BlocConsumer<BlocExampleBloc, BlocExampleState>(
    //     listenWhen: (previous, current) => previous.counter != current.counter,
    //     listener: (context, state) {
    //       if (state.counter == 5) {
    //         ScaffoldMessenger.of(context)
    //             .showSnackBar(const SnackBar(content: Text("Counter = 10")));
    //       }
    //     },
    //     buildWhen: (previous, current) => previous.counter != current.counter,
    //     builder: (context, state) {
    //       return Center(
    //         child: Text("${state.counter}"),
    //       );
    //     },
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //       onPressed: () {
    //         context.read<BlocExampleBloc>().add(const IncrementCounter());
    //       },
    //       child: const Icon(Icons.add)),
    // );

    /* -------------- BlocSelector -------------- */
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('BLoC Example'),
    //   ),
    //   body: BlocSelector<BlocExampleBloc, BlocExampleState, int>(
    //     selector: (state) => state.counter,
    //     builder: (context, counter) {
    //       return Center(
    //         child: Text("$counter")
    //       );
    //     },
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //       onPressed: () {
    //         context.read<BlocExampleBloc>().add(const IncrementCounter());
    //       },
    //       child: const Icon(Icons.add)),
    // );
  }
}
