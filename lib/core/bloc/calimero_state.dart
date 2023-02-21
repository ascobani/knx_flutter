part of 'calimero_bloc.dart';

abstract class CalimeroState extends Equatable {
  const CalimeroState();
}

class CalimeroInitial extends CalimeroState {
  @override
  List<Object> get props => [];
}
