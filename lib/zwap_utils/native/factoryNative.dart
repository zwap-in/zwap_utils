/// IMPORTING LOCAL PACKAGES
import 'package:zwap_utils/zwap_utils/interface/currentState.dart';
import 'package:zwap_utils/zwap_utils/native/currentState.dart';

/// It builds a CurrentState instance based on native devices
CurrentState getCurrentState(){
  return CurrentStateNative();
}