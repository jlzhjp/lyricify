import 'package:flutter/material.dart';

class MiniTabView<T> extends StatefulWidget {
  final List<T> tabs;

  final Widget Function(T tab, BuildContext context) itemBuilder;
  final Widget Function(T tab, BuildContext context) pageBuilder;

  const MiniTabView(
      {super.key,
      required this.tabs,
      required this.pageBuilder,
      required this.itemBuilder});

  @override
  MiniTabViewState<T> createState() => MiniTabViewState<T>();
}

class MiniTabViewState<T> extends State<MiniTabView<T>> {
  late T _selectedTab = widget.tabs.first;

  void _onTabItemPressed(T tab, BuildContext context) {
    setState(() {
      _selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(child: widget.pageBuilder(_selectedTab, context)),
        const Divider(),
        MiniTabs(
          tabs: widget.tabs,
          selectedTab: _selectedTab,
          itemBuilder: widget.itemBuilder,
          onItemPressed: _onTabItemPressed,
        )
      ],
    );
  }
}

class MiniTabs<T> extends StatefulWidget {
  final List<T> tabs;
  final T selectedTab;

  final Widget Function(T tab, BuildContext context) itemBuilder;
  final void Function(T tab, BuildContext context) onItemPressed;

  const MiniTabs({
    super.key,
    required this.tabs,
    required this.selectedTab,
    required this.itemBuilder,
    required this.onItemPressed,
  });

  @override
  MiniTabsState<T> createState() => MiniTabsState<T>();
}

class MiniTabsState<T> extends State<MiniTabs<T>> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (final tab in widget.tabs)
          InkWell(
            onTap: () {
              widget.onItemPressed(tab, context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: theme.cardColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                child: Builder(
                    builder: (context) => widget.itemBuilder(tab, context)),
              ),
            ),
          )
      ],
    );
  }
}
