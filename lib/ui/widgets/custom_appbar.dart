part of 'widgets.dart';

class CustomBar extends StatelessWidget {
  const CustomBar({Key? key, required this.title, this.actions})
      : super(key: key);

  final String title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      actions: actions,
      centerTitle: true,
      title: Text(title,
          style: whiteTextFont.copyWith(
              fontSize: 30.0, fontWeight: FontWeight.bold, letterSpacing: 4.0)),
      foregroundColor: whiteColor,
      backgroundColor: Colors.transparent,
    );
  }
}
