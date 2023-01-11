import 'package:flutter/material.dart';

class LabeledRoundButton extends StatefulWidget {
  const LabeledRoundButton({
    super.key,
    required this.label,
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  final String label;
  final void Function() onPressed;

  @override
  State<LabeledRoundButton> createState() => _LabeledRoundButtonState();
}

class _LabeledRoundButtonState extends State<LabeledRoundButton> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(shape: const CircleBorder()),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: widget.child,
            )),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(widget.label, style: textTheme.labelMedium),
        )
      ],
    );
  }
}
