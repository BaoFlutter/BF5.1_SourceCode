import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_bloc/bloc/timer_event.dart';
import 'package:timer_bloc/bloc/timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static int _initDuration = 60;
  TimerBloc() : super(TimerInitial(_initDuration));

  StreamSubscription<int> _timerSubcription;

  @override
  void onTransition(Transition<TimerEvent, TimerState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is TimerStarted) {
      yield TimerInProgress(event.duration);
      _timerSubcription?.cancel();
      _timerSubcription = tick(event.duration)
          .listen((duration) => add(TimerStepRun(duration)));
    } else if (event is TimerStepRun) {
      yield event.duration > 0
          ? TimerInProgress(event.duration)
          : TimerCompleted();
    } else if (event is TimerPause) {
      if (state is TimerInProgress) {
        _timerSubcription?.pause();
        yield TimerStatePaused(state.duration);
      }
    } else if (event is TimerResume) {
      if (state is TimerStatePaused) {
        _timerSubcription?.resume();
        yield TimerInProgress(state.duration);
      }
    } else if (event is TimerReset) {
      _timerSubcription?.cancel();
      yield TimerInitial(_initDuration);
    }
  }

  Stream<int> tick(int ticks) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }

  @override
  Future<void> close() {
    _timerSubcription?.cancel();
    return super.close();
  }
}
