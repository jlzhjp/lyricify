import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class MiniTabView<T> extends StatefulWidget {
  final List<T> tabs;

  final Widget Function(T tab, BuildContext context) itemBuilder;
  final Widget Function(T tab, BuildContext context) pageBuilder;

  static MiniTabViewState of(BuildContext context) {
    final miniTabViewState =
        context.findAncestorStateOfType<MiniTabViewState>();
    if (miniTabViewState != null) {
      return miniTabViewState;
    }
    throw FlutterError('can not find MiniTabView in the tree.');
  }

  const MiniTabView(
      {super.key,
      required this.tabs,
      required this.pageBuilder,
      required this.itemBuilder});

  @override
  State<MiniTabView<T>> createState() => MiniTabViewState<T>();
}

class MiniTabViewState<T> extends State<MiniTabView<T>> {
  T? _selectedTab;
  bool _showNavigationBar = false;
  void Function()? _onBack;

  void showNavigationBar(void Function()? onBack) {
    setState(() {
      _showNavigationBar = true;
      _onBack = onBack;
    });
  }

  void _onTabItemPressed(T tab, BuildContext context) {
    if (_selectedTab == tab) {
      setState(() {
        _selectedTab = null;
      });
    } else {
      setState(() {
        _selectedTab = tab;
      });
    }
  }

  void _onBackButtonPressed() {
    _onBack?.call();
    setState(() {
      _showNavigationBar = false;
      _onBack = null;
    });
  }

  Widget _buildCurrentPage(BuildContext context) {
    if (_selectedTab == null) {
      return const SizedBox.shrink();
    }
    return widget.pageBuilder(_selectedTab as T, context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Builder(key: Key(_selectedTab.toString()), builder: _buildCurrentPage),
        const Divider(height: 0, thickness: 1),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _showNavigationBar
              ? FadeIn(
                  key: const Key('nav'),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: _onBackButtonPressed,
                    ),
                  ),
                )
              : FadeIn(
                  key: const Key('tabs'),
                  child: MiniTabs(
                    tabs: widget.tabs,
                    selectedTab: _selectedTab,
                    itemBuilder: widget.itemBuilder,
                    onItemPressed: _onTabItemPressed,
                  ),
                ),
        )
      ],
    );
  }
}

class MiniTabs<T> extends StatefulWidget {
  final List<T> tabs;
  final T? selectedTab;

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
  State<MiniTabs<T>> createState() => _MiniTabsState<T>();
}

class _MiniTabsState<T> extends State<MiniTabs<T>> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (final tab in widget.tabs)
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Material(
                color: widget.selectedTab == tab ? theme.splashColor : null,
                child: InkResponse(
                  onTap: () => widget.onItemPressed(tab, context),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Builder(
                        builder: (context) => widget.itemBuilder(tab, context)),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
