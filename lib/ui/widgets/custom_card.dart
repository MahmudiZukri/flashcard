part of 'widgets.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, required this.question, required this.answer})
      : super(key: key);

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        front: CustomContainer(
          color: greyColor,
          child: Center(
            child: Text(
              question,
              style: whiteTextFont.copyWith(fontSize: 14),
            ),
          ),
        ),
        back: CustomContainer(
          color: Colors.green,
          child: Center(
            child: Text(
              answer,
              style: whiteTextFont.copyWith(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
