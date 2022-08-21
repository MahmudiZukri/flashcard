part of 'widgets.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key, required this.icon, required this.text, required this.onTap})
      : super(key: key);

  final IconData icon;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 26),
              Text(text, style: whiteTextFont.copyWith(fontSize: 18))
            ],
          )),
    );
  }
}
