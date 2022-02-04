import 'package:flutter/widgets.dart';
import 'package:photo_gallery/utils/delay_tween.dart';

class FadingFour extends StatefulWidget {
  const FadingFour({
    Key? key,
    this.color,
    this.shape = BoxShape.circle,
    this.size = 50.0,
    required this.itemBuilder,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  })  : assert(
            !(itemBuilder is IndexedWidgetBuilder && color is Color) &&
                !(itemBuilder == null && color == null),
            'You should specify either a itemBuilder or a color'),
        super(key: key);

  final Color? color;
  final BoxShape shape;
  final double size;
  final IndexedWidgetBuilder itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  _FadingFourState createState() => _FadingFourState();
}

class _FadingFourState extends State<FadingFour>
    with SingleTickerProviderStateMixin {
  final List<double> delays = [.0, -0.9, -0.6, -0.3];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..repeat();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size.square(widget.size),
        child: Stack(
          children: List.generate(4, (i) {
            final _position = widget.size * .5;
            return Positioned.fill(
              left: _position,
              top: _position,
              child: Transform(
                transform: Matrix4.rotationZ(30.0 * (i * 3) * 0.0174533),
                child: Align(
                  alignment: Alignment.center,
                  child: FadeTransition(
                    opacity: DelayTween(begin: 0.0, end: 1.0, delay: delays[i])
                        .animate(_controller),
                    child: SizedBox.fromSize(
                        size: Size.square(widget.size * 0.25),
                        child: _itemBuilder(i)),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder(context, index)
      : DecoratedBox(
          decoration: BoxDecoration(color: widget.color, shape: widget.shape));
}
