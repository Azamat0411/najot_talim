import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBloc<T extends Bloc<dynamic, dynamic>> extends StatelessWidget {
  const CustomBloc(
      {super.key,
      required this.create,
      required this.builder,
      required this.listener});

  final T Function(BuildContext context) create;
  final Widget Function(BuildContext context, dynamic state) builder;
  final Function(BuildContext context, dynamic state) listener;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: create,
      child: BlocConsumer<T, dynamic>(
        builder: builder,
        listener: listener,
      ),
    );
  }
}
