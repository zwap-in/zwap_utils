/// IMPORTING LOCAL PACKAGES
import 'package:zwap_utils/zwap_utils/interface/currentState.dart';
import 'package:zwap_utils/zwap_utils/web/currentState.dart';

/// It manages the current state for the web devices
CurrentState getCurrentState(){
  return CurrentStateWeb();
}