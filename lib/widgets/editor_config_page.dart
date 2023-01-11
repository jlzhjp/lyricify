import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/labeled_round_button.dart';
import 'mini_tab_view.dart';

class ConfigSection {
  String key;
  String description;
  IconData icon;
  void Function(WidgetRef ref)? onEnter;
  WidgetBuilder? builder;

  ConfigSection({
    required this.key,
    required this.description,
    required this.icon,
    this.onEnter,
    this.builder,
  });
}

class EditorConfigPage extends StatefulWidget {
  final List<ConfigSection> sections;
  const EditorConfigPage({super.key, required this.sections});

  @override
  State<EditorConfigPage> createState() => _EditorConfigPageState();
}

class _EditorConfigPageState extends State<EditorConfigPage> {
  ConfigSection? _currentSection;

  void _onSectionSelectButtonClick(
      ConfigSection section, BuildContext context, WidgetRef ref) {
    if (section.builder != null) {
      MiniTabView.of(context).showNavigationBar(() {
        setState(() {
          _currentSection = null;
        });
      });
    }
    section.onEnter?.call(ref);
    setState(() {
      _currentSection = section;
    });
  }

  Widget _buildSectionButtonGroup(
      BuildContext context, WidgetRef ref, Widget? child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final section in widget.sections)
          LabeledRoundButton(
              label: section.description,
              onPressed: () =>
                  _onSectionSelectButtonClick(section, context, ref),
              child: Icon(section.icon))
      ],
    );
  }

  Widget _buildView(BuildContext context) {
    if (_currentSection == null || _currentSection!.builder == null) {
      return Consumer(builder: _buildSectionButtonGroup);
    } else {
      return Builder(builder: _currentSection!.builder!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Builder(builder: _buildView)),
    );
  }
}
