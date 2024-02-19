part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.isDark});
  final bool isDark;

  @override
  List<Object> get props => [isDark];
}

final class ThemeDarkInitial extends ThemeState {
  const ThemeDarkInitial({required super.isDark});
}
