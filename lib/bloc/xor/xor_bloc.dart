import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sample_application/presentation/xor.dart' as xor;
part 'xor_event.dart';
part 'xor_state.dart';

class XorBloc extends Bloc<XorEvent, XorState> {
  XorBloc() : super(XorInitial()) {
    on<XorEvent>((event, emit) {
      if (state is XorStart) {
        if (event is XorOperate) {
          xor.xorOperation("2023-02-02T14:16:37.611Z", "8116431079");
          emit(XorEnd());
        }
      }
    });
  }
}
