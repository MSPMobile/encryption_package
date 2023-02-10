part of 'xor_cubit.dart';

abstract class XorState extends Equatable {
  const XorState();

  @override
  List<Object> get props => [];
}

class XorInitial extends XorState {}

class XorProcessing extends XorState {}

class XorComplete extends XorState {}
