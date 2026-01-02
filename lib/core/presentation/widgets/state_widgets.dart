import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spotify_downloader/core/icons/vectors_icon.dart';
import 'package:spotify_downloader/core/presentation/widgets/svg_icon.dart';

class StateWidgets {
  final BuildContext context;

  StateWidgets(this.context);
  Future<void> showLoader() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (context) {
        return Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: _ZoomLoader(svgPath: kluatIcon),
          ),
        );
      },
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrroSnackbar(
    String message,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessSnackbar(
    String message,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }
}

class _ZoomLoader extends StatefulWidget {
  final String svgPath;

  const _ZoomLoader({required this.svgPath});

  @override
  State<_ZoomLoader> createState() => _ZoomLoaderState();
}

class _ZoomLoaderState extends State<_ZoomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _scale = Tween<double>(
      begin: 0.92,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: SvgIcon(svgPath: widget.svgPath, size: 82),
    );
  }
}

enum ToastType { success, error }

class AppToast {
  static void show(
    BuildContext context, {
    required String message,
    required ToastType type,
  }) {
    _showToast(context, message: message, type: type);
  }

  static void _showToast(
    BuildContext context, {
    required String message,
    required ToastType type,
  }) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    // Style per toast type
    Color background;
    IconData icon;
    Color iconColor;

    switch (type) {
      case ToastType.success:
        background = const Color(0xFFCFFFE1); // soft mint green
        icon = Icons.check_circle;
        iconColor = const Color(0xFF2E8B57);
        break;

      case ToastType.error:
        background = const Color(0xFFFFD6D6); // soft red/pink
        icon = Icons.error;
        iconColor = const Color(0xFFD32F2F);
        break;
    }

    overlayEntry = OverlayEntry(
      builder: (_) => Positioned(
        top: kToolbarHeight + MediaQuery.of(context).padding.top,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 250),
            offset: const Offset(0, 0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(icon, size: 16, color: iconColor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3)).then((_) {
      overlayEntry.remove();
    });
  }
}
