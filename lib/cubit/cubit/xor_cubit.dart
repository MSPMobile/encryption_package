import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sample_application/Model/xorData.dart';
import 'package:sample_application/Repository/Repository.dart';

part 'xor_state.dart';

class XorCubit extends Cubit<XorState> {
  XorCubit() : super(XorInitial());

  List<xorInput> fetchInput() {
    List<xorInput> inputList = <xorInput>[];

    xorInput input = xorInput("2023-02-02T14:16:37.611Z", "8116431079");
    inputList.add(input);
    return inputList;
  }
}
