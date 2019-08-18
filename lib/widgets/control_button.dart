import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {
  ControlButton(this._iconPath, this._onPressed);

  final Function _onPressed;
  final String _iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        shape: CircleBorder(
          side: BorderSide(
            width: 2,
            color: Theme.of(context).textTheme.button.color,
          ),
        ),
        color: Colors.white,
        child: Image.asset(
          _iconPath,
          scale: 15,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: _onPressed,
      ),
    );
  }
}
