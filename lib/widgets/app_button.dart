import 'package:flutter/material.dart';
import 'package:wow_shopping/app/theme.dart';
import 'package:wow_shopping/widgets/app_icon.dart';
import 'package:wow_shopping/widgets/common.dart';

enum AppButtonStyle {
  regular,
  highlighted,
}

@immutable
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onPressed,
    required this.label,
    this.iconAsset,
    this.style = AppButtonStyle.regular,
  });

  final VoidCallback? onPressed;
  final String label;
  final String? iconAsset;
  final AppButtonStyle style;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        customBorder: const RoundedRectangleBorder(
          borderRadius: appButtonRadius,
        ),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: appButtonRadius,
            color: style == AppButtonStyle.regular //
                ? AppTheme.of(context).appBarColor
                : null,
            gradient: style == AppButtonStyle.highlighted //
                ? appHorizontalGradientHighlight
                : null,
          ),
          child: Padding(
            padding: horizontalPadding16 + verticalPadding8,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    label,
                    textAlign: iconAsset != null //
                        ? TextAlign.start
                        : TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (iconAsset != null)
                  AppIcon(iconAsset: iconAsset!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
