import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pods/editor_pods.dart';
import '../../pods/states/background_config_state.dart';

class BackgroundConfigPage extends StatefulWidget {
  const BackgroundConfigPage({super.key});

  @override
  State<BackgroundConfigPage> createState() => _BackgroundConfigPageState();
}

class _BackgroundConfigPageState extends State<BackgroundConfigPage> {
  List<bool> _generateTypeIsSelected(WidgetRef ref) {
    final backgroundState = ref.watch(backgroundConfigPod);
    return BackgroundType.values.map((value) {
      if (value == backgroundState.type) {
        return true;
      }
      return false;
    }).toList();
  }

  void _onTypeToggleButtonClick(int index, WidgetRef ref) {
    final backgroundStateNotifier = ref.read(backgroundConfigPod.notifier);
    backgroundStateNotifier
        .update((state) => state.copyWith(type: BackgroundType.values[index]));
  }

  Widget _buildBackgroundTypeButtonGroup(
      BuildContext context, WidgetRef ref, Widget? child) {
    return ToggleButtons(
        isSelected: _generateTypeIsSelected(ref),
        onPressed: (index) => _onTypeToggleButtonClick(index, ref),
        children: [for (final type in BackgroundType.values) Icon(type.icon)]);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text("类型:", style: textTheme.labelLarge),
                ),
                Consumer(builder: _buildBackgroundTypeButtonGroup),
              ],
            ),
          )
        ],
      ),
    );
  }
}
