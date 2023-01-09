import 'package:flutter/material.dart';

import '../model/lyrics.dart';
// 2003496927

class LyricItem extends StatefulWidget {
  final TranslatedLyric lyric;
  final bool isSelected;
  final void Function(bool isSelected, TranslatedLyric lyric) onSelectChange;

  const LyricItem(
      {super.key,
      required this.lyric,
      this.isSelected = false,
      required this.onSelectChange});

  @override
  State<LyricItem> createState() => _LyricItemState();
}

class _LyricItemState extends State<LyricItem> {
  void _onSelectChange(bool isSelected) {
    widget.onSelectChange(isSelected, widget.lyric);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: widget.isSelected,
        onChanged: (value) => _onSelectChange(value!),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(widget.lyric.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              if (widget.lyric.tranlation != null)
                Opacity(
                  opacity: 0.7,
                  child: Text(
                    widget.lyric.tranlation!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
