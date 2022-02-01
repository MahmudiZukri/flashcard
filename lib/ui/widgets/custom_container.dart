part of 'widgets.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({Key? key, required this.child, required this.color})
      : super(key: key);

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(21.2),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(10.0)),
      child: child,
    );
  }
}
