part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool flashcardExist = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: CustomBar(title: 'homeTitle'.tr()),
          preferredSize: Size.fromHeight(50.0)),
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: WebsafeSvg.asset("assets/bg.svg", fit: BoxFit.fill)),
          SafeArea(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) {
                  FlashcardUser? user = userState is! UserInitial
                      ? (userState as UserLoaded).user
                      : null;
                  return StreamBuilder<List<CardModel>>(
                      stream:
                          FlashcardServices.getStreamFlashcard(user?.id ?? ''),
                      builder: (context, snapshot) {
                        List<CardModel>? notFilteredCards;
                        List<CardModel>? cards;

                        (snapshot.data == null || snapshot.data!.isEmpty)
                            ? flashcardExist = false
                            : flashcardExist = true;

                        notFilteredCards = snapshot.data;

                        int daysBetween(DateTime from, DateTime to) {
                          from = DateTime(from.year, from.month, from.day);
                          to = DateTime(to.year, to.month, to.day);

                          return ((to.difference(from).inHours / 24)).round();
                        }

                        if (flashcardExist) {
                          DateTime dateRightNow = DateTime.now();
                          cards = (notFilteredCards!.where((card) =>
                              daysBetween(card.reviewedDate, dateRightNow) >=
                              card.intervals)).toList();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 2.0,
                                width: double.infinity,
                                color: primaryColor),
                            SizedBox(height: 16),
                            Align(
                                alignment: Alignment.centerRight,
                                child: ChooseLanguage()),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 14),
                            RichText(
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: user?.name == null ? '' : 'hi'.tr(),
                                      style: whiteTextFont.copyWith(
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.w300)),
                                  TextSpan(
                                    text: user?.name ?? '',
                                    style: whiteTextFont.copyWith(
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ])),
                            SizedBox(height: 2),
                            snapshot.connectionState == ConnectionState.waiting
                                ? SizedBox()
                                : flashcardExist && cards!.isNotEmpty
                                    ? RichText(
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        text: TextSpan(
                                            style: lightWhiteTextFont.copyWith(
                                                fontSize: 14.0),
                                            children: [
                                              TextSpan(text: 'youHave'.tr()),
                                              TextSpan(
                                                  text: cards.length.toString(),
                                                  style: whiteTextFont.copyWith(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              TextSpan(
                                                  text:
                                                      'flashcardToReview'.tr())
                                            ]))
                                    : flashcardExist && cards!.isEmpty
                                        ? Text(
                                            'doneToday'.tr(),
                                            style: lightWhiteTextFont.copyWith(
                                                fontSize: 14.0),
                                          )
                                        : Text(
                                            'emptyFlashcard'.tr(),
                                            style: lightWhiteTextFont.copyWith(
                                                fontSize: 14.0),
                                          ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 34),
                            SizedBox(height: 16),
                            Container(
                              height: 45,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(0),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
                                ),
                                onPressed: () {
                                  BlocProvider.of<PageBloc>(context)
                                      .add(GotoStudyPage());
                                },
                                child: Text(
                                  "startStudy",
                                  style: whiteTextFont.copyWith(fontSize: 16),
                                ).tr(),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 45,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(0),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
                                ),
                                onPressed: () {
                                  BlocProvider.of<PageBloc>(context)
                                      .add(GotoAddFlashcardPage());
                                },
                                child: Text(
                                  "addCard",
                                  style: whiteTextFont.copyWith(fontSize: 16),
                                ).tr(),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 45,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(0),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
                                ),
                                onPressed: () {
                                  AuthServices.signOut();
                                  BlocProvider.of<UserBloc>(context)
                                      .add(SignOut());
                                },
                                child: Text(
                                  "signOut".tr(),
                                  style: whiteTextFont.copyWith(fontSize: 16),
                                ),
                              ),
                            ),
                            Spacer()
                          ],
                        );
                      });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
