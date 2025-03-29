import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(
    BuildContext context,
    String message, {
    IconData icon = Icons.info_outline, // Icône personnalisable
    Color backgroundColor = Colors.black87, // Couleur de fond
    Color textColor = Colors.white, // Couleur du texte
    Duration duration = const Duration(seconds: 3), // Durée d'affichage
  }) {
    OverlayState overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;
    AnimationController? animationController;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return SnackBarWidget(
          message: message,
          icon: icon,
          backgroundColor: backgroundColor,
          textColor: textColor,
          duration: duration,
          onRemove: () {
            overlayEntry.remove();
          },
        );
      },
    );

    overlayState.insert(overlayEntry);
  }

  static void showSuccess(BuildContext context, String message) {
    show(
      context,
      message,
      icon: Icons.check_circle,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  static void showError(BuildContext context, String message) {
    show(
      context,
      message,
      icon: Icons.error_outline,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  static void showInfo(BuildContext context, String message) {
    show(
      context,
      message,
      icon: Icons.info_outline,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }
}

class SnackBarWidget extends StatefulWidget {
  final String message;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Duration duration;
  final VoidCallback onRemove;

  const SnackBarWidget({
    required this.message,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.duration,
    required this.onRemove,
    super.key,
  });

  @override
  _SnackBarWidgetState createState() => _SnackBarWidgetState();
}

class _SnackBarWidgetState extends State<SnackBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    Future.delayed(widget.duration, () {
      _controller.reverse().then((_) {
        widget.onRemove();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top +
          10, // Juste sous la barre de notif
      left: 20,
      right: 20,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, color: widget.textColor),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: TextStyle(color: widget.textColor, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
