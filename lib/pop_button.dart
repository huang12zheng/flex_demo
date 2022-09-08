import 'package:flex_demo/main.dart';
import 'package:flutter/material.dart';

/// An about icon button used on the example's app app bar.
class PopButton extends StatefulWidget {
  const PopButton({super.key, this.color});

  /// The color used on the icon button.
  ///
  /// If null, default to Icon() class default color.
  final Color? color;

  @override
  State<PopButton> createState() => _PopButtonState();
}

class _PopButtonState extends State<PopButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.exit_to_app, color: widget.color),
      onPressed: () {
        // Navigator.of(context).pop();
        ShowWidget.of(context).showController.toggle();
      },
    );
  }
}

class ShowController with ChangeNotifier {
  bool _showFlag = false;
  toggle() {
    _showFlag = !_showFlag;
    notifyListeners();
  }

  get value => _showFlag;
}
