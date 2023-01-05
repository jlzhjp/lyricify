import 'package:flutter/material.dart';

class OmniboxResult {
  int songId;
  OmniboxResult({
    required this.songId,
  });
}

class Omnibox extends StatefulWidget {
  final void Function(OmniboxResult) onSubmit;
  const Omnibox({super.key, required this.onSubmit});

  @override
  State<Omnibox> createState() => _OmniboxState();
}

class _OmniboxState extends State<Omnibox> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSubmitButtonPressed() {
    widget.onSubmit(OmniboxResult(songId: int.parse(_controller.text)));
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    spreadRadius: -2,
                    blurRadius: 10,
                  )
                ]),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(50)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () => _onSubmitButtonPressed(),
                child: const Icon(Icons.arrow_forward_rounded)),
          )
        ],
      ),
    );
  }
}
