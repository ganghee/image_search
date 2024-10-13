part of 'main.dart';

class _FavoriteIconView extends StatefulWidget {
  final bool isFavorite;
  final Function() onTap;

  const _FavoriteIconView({
    required this.isFavorite,
    required this.onTap,
  });

  @override
  State<_FavoriteIconView> createState() => _FavoriteIconViewState();
}

class _FavoriteIconViewState extends State<_FavoriteIconView>
    with TickerProviderStateMixin {
  bool isPressed = false;
  late bool isFavorite = widget.isFavorite;
  late final AnimationController _favoriteAnimationController;
  late final CurvedAnimation _favoriteCurvedAnimation;

  @override
  void initState() {
    _favoriteAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.5,
      upperBound: 1,
      vsync: this,
    );
    _favoriteAnimationController.forward();

    _favoriteCurvedAnimation = CurvedAnimation(
      parent: _favoriteAnimationController,
      curve: Curves.bounceOut,
    );

    super.initState();
  }

  @override
  void dispose() {
    _favoriteAnimationController.dispose();
    _favoriteCurvedAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _favoriteCurvedAnimation.curve = Curves.linear;
          _favoriteAnimationController.reverse();
        });
      },
      onTapUp: (_) {
        _favoriteAnimationController.reset();
        setState(() {
          _favoriteCurvedAnimation.curve = Curves.bounceOut;
          isFavorite = !isFavorite;
        });
        _favoriteAnimationController.forward();
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _favoriteCurvedAnimation,
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
