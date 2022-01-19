part of 'widgets.dart';

class CustomCard extends StatefulWidget {
  const CustomCard(
      {Key? key, required this.cardModel, required this.controller})
      : super(key: key);

  final CardModel cardModel;
  final FlipCardController controller;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      speed: 400,
      controller: widget.controller,
      direction: FlipDirection.HORIZONTAL,
      front: CustomContainer(
        color: primaryColor,
        child: Center(
          child: Text(
            widget.cardModel.question,
            style: whiteTextFont.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      back: RawScrollbar(
        child: CustomContainer(
          color: Colors.green[700]!,
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Text(
                widget.cardModel.answer,
                style: whiteTextFont.copyWith(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
