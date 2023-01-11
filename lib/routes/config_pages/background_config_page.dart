import 'package:animate_do/animate_do.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pods/editor_pods.dart';
import '../../widgets/editor_config_page.dart';

final _backgroundConfigSections = [
  ConfigSection(
      key: 'none',
      description: '无',
      icon: Icons.broken_image,
      onEnter: (ref) {
        // 将背景设为无
        final notifier = ref.read(backgroundConfigPod.notifier);
        notifier.update((state) => state.copyWith(showBackground: false));
      }),
  ConfigSection(
    key: 'color',
    description: '颜色',
    icon: Icons.colorize,
    onEnter: (ref) {
      // 设置背景的颜色
      final notifier = ref.read(backgroundConfigPod.notifier);
      notifier.update((state) => state.copyWith(showBackground: true));
    },
    builder: (context) => FadeIn(child: const ColorConfigPage()),
  ),
  ConfigSection(
    key: 'image',
    description: '图片',
    icon: Icons.image,
    onEnter: (ref) {
      // 设置背景的颜色
      final notifier = ref.read(backgroundConfigPod.notifier);
      notifier.update((state) => state.copyWith(showBackground: true));
    },
    builder: (context) => FadeIn(child: const ImageConfigPage()),
  ),
];

class BackgroundConfigPage extends StatelessWidget {
  const BackgroundConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EditorConfigPage(sections: _backgroundConfigSections);
  }
}

class ColorConfigPage extends ConsumerWidget {
  const ColorConfigPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(backgroundConfigPod.select((pod) => pod.backgroundColor));
    final notifier = ref.watch(backgroundConfigPod.notifier);

    void updateBackgroundColor(color) {
      notifier.update((oldState) => oldState.copyWith(backgroundColor: color));
    }

    return ColorPicker(color: color, onColorChanged: updateBackgroundColor);
  }
}

class ImageConfigPage extends ConsumerWidget {
  const ImageConfigPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final config = ref.watch(backgroundConfigPod);
    final notifier = ref.watch(backgroundConfigPod.notifier);

    void updateSigma(double sigma) {
      notifier.update((prev) => prev.copyWith(imageBlurSigma: sigma));
    }

    void updateOpacity(double opacity) {
      notifier.update((prev) => prev.copyWith(imageOpacity: opacity));
    }

    return Column(children: [
      Row(
        children: [
          Text(
            '模糊',
            style: textTheme.labelLarge,
          ),
          Expanded(
              child: Slider(
                  value: config.imageBlurSigma,
                  min: 0,
                  max: 100,
                  onChanged: updateSigma))
        ],
      ),
      Row(
        children: [
          Text('透明度', style: textTheme.labelLarge),
          Expanded(
              child: Slider(
                  value: config.imageOpacity,
                  min: 0,
                  max: 1,
                  onChanged: updateOpacity))
        ],
      ),
    ]);
  }
}
