part of 'widgets.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({Key? key, required this.child, required this.color})
      : super(key: key);

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.66,
      width: double.infinity,
      padding: EdgeInsets.all(18.0),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(10.0)),
      child: child,
    );
  }
}
