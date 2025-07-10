import 'package:diario_de_sono/designer_system/designer_system.dart';
import 'package:flutter/material.dart';

export 'toggle_lable.dart';

class ToggleSwitch extends StatefulWidget {
  final List<ToggleLable> labels;
  final int initialIndex;

  const ToggleSwitch({super.key, required this.labels, this.initialIndex = 0})
    : assert(labels.length >= 2);

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  late int _currentIndex;
  final List<GlobalKey> _buttonKeys = [];

  double _thumbLeft = 0;
  double _thumbWidth = 0;
  double _thumbHeight = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _initKeys();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _calculateThumbPosition(),
    );
  }

  @override
  void didUpdateWidget(covariant ToggleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.labels.length != oldWidget.labels.length) {
      _initKeys();
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _calculateThumbPosition(),
      );
    }
  }

  void _initKeys() {
    _buttonKeys.clear();
    for (var i = 0; i < widget.labels.length; i++) {
      _buttonKeys.add(GlobalKey());
    }
  }

  void _calculateThumbPosition() {
    if (!mounted ||
        _buttonKeys.isEmpty ||
        _currentIndex >= _buttonKeys.length) {
      return;
    }

    final selectedKey = _buttonKeys[_currentIndex];
    final buttonContext = selectedKey.currentContext;

    if (buttonContext == null) return;

    final RenderBox selectedButtonBox =
        buttonContext.findRenderObject() as RenderBox;

    double leftOffset = 0;
    for (int i = 0; i < _currentIndex; i++) {
      final key = _buttonKeys[i];
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        leftOffset += box.size.width;
      }
    }

    if (mounted) {
      setState(() {
        _thumbLeft = leftOffset;
        _thumbWidth = selectedButtonBox.size.width;
        _thumbHeight = selectedButtonBox.size.height;
      });
    }
  }

  void _onTap(int index) {
    if (_currentIndex != index) {
      setState(() => _currentIndex = index);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _calculateThumbPosition();
        widget.labels[index].onPressed();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.spaces.xs),
        border: Border.all(color: context.colors.light600),
      ),
      child: IntrinsicWidth(
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            if (_thumbHeight > 0)
              AnimatedPositioned(
                left: _thumbLeft,
                width: _thumbWidth,
                height: _thumbHeight,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colors.dark,
                    borderRadius: BorderRadius.circular(context.spaces.xs),
                  ),
                ),
              ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(widget.labels.length, (i) {
                final isSelected = i == _currentIndex;
                return ButtonDS.small(
                  key: _buttonKeys[i],
                  style: isSelected
                      ? ButtonDSStyle.primary
                      : ButtonDSStyle.textBlue,
                  label: widget.labels[i].label,
                  onPressed: () => _onTap(i),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
