import 'package:flutter/material.dart';
import '../services/input_parser.dart';

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
  String? _inputError;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() => _inputError = null);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSubmitButtonPressed() {
    final content = _controller.text;
    int? id = int.tryParse(content);
    id ??= tryGetIdfromInput(content);
    if (id == null) {
      setState(() => _inputError = '无法解析输入的内容');
    } else {
      widget.onSubmit(OmniboxResult(songId: id));
    }
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
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  errorText: _inputError,
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(50)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: _onSubmitButtonPressed,
                child: const Icon(Icons.arrow_forward_rounded)),
          )
        ],
      ),
    );
  }
}
