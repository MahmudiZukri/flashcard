part of 'widgets.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270.0,
      width: double.infinity,
      child: Card(
        color: greyColor,
        child: Center(
            child: Text(
          'Test',
          style: whiteTextFont.copyWith(fontSize: 14),
        )),
      ),
    );
  }
}
