part of 'xor_bloc.dart';

abstract class XorEvent extends Equatable {
  const XorEvent();

  @override
  List<Object> get props => [];
}

class XorOperate extends XorEvent {
  late String timestamp;
  late String transactionId;
}
