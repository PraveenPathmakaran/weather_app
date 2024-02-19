
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme_bloc/theme_bloc.dart';

class ThemeSwitchWidget extends StatelessWidget {
  const ThemeSwitchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Switch(
            value: state.isDark,
            onChanged: (value) {
              value
                  ? context.read<ThemeBloc>().add(ThemeChangeToDark())
                  : context.read<ThemeBloc>().add(ThemeChangeToWhite());
            });
      },
    );
  }
}