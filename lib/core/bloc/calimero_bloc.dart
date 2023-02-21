import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calimero_event.dart';
part 'calimero_state.dart';

class CalimeroBloc extends Bloc<CalimeroEvent, CalimeroState> {
  CalimeroBloc() : super(CalimeroInitial()) {
    on<CalimeroEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
