part of 'widgets.dart';

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage(
      {Key? key,
      this.heightCard = 32.0,
      this.widthCard = 64.0,
      this.iconSize = 11.0})
      : super(key: key);

  final double? heightCard;
  final double? widthCard;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (_) => Container(
                  height: 182.0,
                  padding: EdgeInsets.symmetric(horizontal: edge),
                  decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12.0),
                        Center(
                            child: Container(
                                height: 2.0,
                                width: 38.0,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius:
                                        BorderRadius.circular(20.0)))),
                        SizedBox(height: 18.0),
                        Text('chooseLang',
                                style: whiteTextFont.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: whiteColor))
                            .tr(),
                        SizedBox(height: 8.0),
                        Container(
                            height: 1.0,
                            width: double.infinity,
                            color: primaryColor),
                        GestureDetector(
                          onTap: () {
                            context.setLocale('id'.toLocale());
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    iconSize: 14.0,
                                    onPressed: () {},
                                    icon: Image.asset('assets/indonesia.png')),
                                SizedBox(width: 10.0),
                                Text('Indonesia',
                                    style: whiteTextFont.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: whiteColor)),
                                Spacer(),
                                'isID'.tr() == 'true'
                                    ? Icon(Icons.check, color: Colors.green)
                                    : SizedBox()
                              ],
                            ),
                          ),
                        ),
                        Container(
                            height: 1.0,
                            width: double.infinity,
                            color: primaryColor),
                        GestureDetector(
                          onTap: () {
                            context.setLocale('en_US'.toLocale());
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    iconSize: 14.0,
                                    onPressed: () {},
                                    icon: Image.asset(
                                        'assets/united-states.png')),
                                SizedBox(width: 10.0),
                                Text('English',
                                    style: whiteTextFont.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: whiteColor)),
                                Spacer(),
                                'isID'.tr() == 'false'
                                    ? Icon(Icons.check, color: Colors.green)
                                    : SizedBox()
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                      ]),
                ),
            backgroundColor: Colors.transparent);
      },
      child: Container(
          height: heightCard,
          width: widthCard,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: whiteColor,
              gradient: primaryGradient),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('flag'.tr()),
              SizedBox(width: 6.0),
              Text('lang',
                      style: whiteTextFont.copyWith(
                          fontSize: 11.0, fontWeight: FontWeight.bold))
                  .tr(),
              Spacer(),
              Icon(Icons.arrow_forward_ios, size: iconSize, color: whiteColor)
            ],
          )),
    );
  }
}
