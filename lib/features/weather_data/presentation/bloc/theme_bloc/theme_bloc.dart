import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeDarkInitial(isDark: false)) {
    on<ThemeChangeToDark>((event, emit) {
      emit(const ThemeState(isDark: true));
    });
    on<ThemeChangeToWhite>((event, emit) {
      emit(const ThemeState(isDark: false));
    });
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState(isDark: json["value"]);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return {'value': state.isDark};
  }
}
