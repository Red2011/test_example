import 'package:flutter/material.dart';
import 'package:test_example/components/function_card.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ShoppingCard extends StatefulWidget{
  const ShoppingCard({Key? key}) : super(key: key);

  @override
  State<ShoppingCard> createState() => _ShoppingCardState();
}

class _ShoppingCardState extends State<ShoppingCard> {


  @override
  Widget build(BuildContext context) {
    String buttonCard = '';
    if (cardItems == null) {
      return SizedBox();
    }
    else {
      List keys = [];
      for (final key in cardItems.keys){
        keys.add(key);
      }
      num sum = sumCard();
      if (sum == 0) {
        buttonCard = 'Корзина пуста';
      }
      else {
        buttonCard = 'Оплатить ${sum.toString()} ₽';
      }
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(padding: EdgeInsets.only(left: 13, right: 13, top: 13, bottom: 65),
            child: ListView.builder(
                itemCount: keys.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(248, 247, 245, 1),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            alignment: Alignment.center,
                            width: 80,
                            height: 80,
                            child: CachedNetworkImage(
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                    color: Colors.pinkAccent,
                                    backgroundColor: Colors.transparent,
                                  ),
                              height: 60,
                              width: 60,
                              imageUrl:cardItems[keys[index]][1],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cardItems[keys[index]][2],
                                  style: TextStyle(
                                    fontFamily: 'SFProDisplay',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${cardItems[keys[index]][3]} ₽',
                                      style: TextStyle(
                                        fontFamily: 'SFProDisplay',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '· ${cardItems[keys[index]][4]}г',
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.4),
                                        fontFamily: 'SFProDisplay',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          ],
                        ),
                        Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(248, 247, 245, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 35,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Color.fromRGBO(196, 196, 196, 1),
                                      padding: EdgeInsets.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      side: const BorderSide(
                                        width: 0,
                                        color: Color.fromRGBO(248, 247, 245, 1),
                                      ),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                      ),
                                    ),
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontFamily: 'SFProDisplay',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                    onPressed: () => setState(() {
                                      minusInItemCard(cardItems[keys[index]][0]);
                                    }),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${cardItems[keys[index]][5]}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  width: 35,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Color.fromRGBO(196, 196, 196, 1),
                                      padding: EdgeInsets.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      side: const BorderSide(
                                        width: 0,
                                        color: Color.fromRGBO(248, 247, 245, 1),
                                      ),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                      ),
                                    ),
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontFamily: 'SFProDisplay',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                    onPressed: () => setState(() {
                                      plusInItemCard(cardItems[keys[index]][0]);
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                  );
                }
            )
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 50,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              backgroundColor: Color.fromRGBO(51, 100, 224, 1),
              onPressed: () {},
              child: Text(
                buttonCard,
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'SFProDisplay',
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    }
  }
}