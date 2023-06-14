import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_example/components/function_card.dart';
import 'package:test_example/controllers/controller.dart';
import 'package:test_example/models/tags.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class TagPage extends StatefulWidget {
  const TagPage({Key? key}) : super(key: key);

  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends StateMVC {
  tagController? _controller;
  String image = '';
  List nameTags = [];
  List<Widget> nameTagsText = [];
  double thisWidth = 0;
  double thisHeight = 0;

  _TagPageState(): super(tagController()) {
    _controller = controller as tagController;
  }

  @override
  void initState() {
    super.initState();
    _controller?.init();
  }

  @override
  Widget build(BuildContext context) {
    thisWidth = MediaQuery.of(context).size.width;
    thisHeight = MediaQuery.of(context).size.height;
    final state = _controller?.currentState;
    if (state is TagsResultLoading) {
      return const Center(
        child: CircularProgressIndicator(
            color: Colors.pinkAccent,
            backgroundColor: Colors.transparent,
        )
      );
    }
    else if (state is TagsResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    }
    else {
      final tag = (state as TagsResultSuccess).tagsList.tags;
      for (var element in tag) {
        buildTagsList(element);
      }
      return DefaultTabController(
        length: nameTagsText.length,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ButtonsTabBar(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                height: 43,
                duration: 300,
                unselectedLabelStyle: const TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  color: Colors.black
                ),
                labelStyle: const TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(248, 247, 245, 1),
                ),
                backgroundColor: Color.fromRGBO(51, 100, 224, 1),
                unselectedBackgroundColor: Color.fromRGBO(248, 247, 245, 1),
                radius: 10,
                splashColor: Color.fromRGBO(137, 168, 245, 1.0),
                buttonMargin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
                tabs: nameTagsText,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    for (var listTagItem in nameTags)
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        // decoration: BoxDecoration(
                        //   border: Border.all()
                        // ),
                          child: _buildTabBarView(tag, listTagItem)
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }
  //общий тэг и имя тега одного
  Widget _buildTabBarView (List tag, String tagName) {
    int count = tagCountContains(tag, tagName);
    List<int> indicesId = indicesNowTagInMapTag(tag, tagName);
    List<Tags> NowTags = fetchingCardsWithDesiredIndices(indicesId, tag);
    return GridView.count(
        childAspectRatio: 5.0/7.0,
        crossAxisCount: 3,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 6.0,
      children: List.generate(count, (index) {
        return _buildTagsItem(NowTags[index]);
      })
    );
  }

  //составляет список всех возможных тэгов у блюд
  void buildTagsList(Tags tags) {
    for (var nameTag in tags.tegs) {
      if (nameTags.contains(nameTag) == false) {
        nameTags.add(nameTag);
        nameTagsText.add(Tab(text: nameTag));
      }
    }
  }


  //количество вхождения названия тэга во все карточки товаров
  int tagCountContains(List tag, String tagName) {
    int count = 0;
    for (Tags tags in tag) {
      if (tags.tegs.contains(tagName) == true){
        count += 1;
      }
    }
    return count;
  }

  //возвращает индексы выбранных по тэгу блюд
  List<int> indicesNowTagInMapTag(List tag, String tagName) {
    List<int> indices = [];
    for (Tags tags in tag) {
      if (tags.tegs.contains(tagName) == true) {
        indices.add(tags.id);
      }
    }
    return indices;
  }


  //возвращает список блюд на основе выбранных индексов
  List<Tags> fetchingCardsWithDesiredIndices(List<int> indices, List tag) {
    List<Tags> tagsId = [];
    for (Tags tags in tag) {
      if (indices.contains(tags.id) == true) {
        tagsId.add(tags);
      }
    }
    return tagsId;
  }


  Widget _buildTagsItem(Tags tags) {
      String thisDescription = '';
      if (tags.image_url == null) {
        image = tags.description;
        thisDescription = 'Описание отсутствует 😞';
      }
      else {
        image = tags.image_url!;
        thisDescription = tags.description;
      }


      String thisImage = image;
      List tag = [
        tags.id,
        image,
        tags.name,
        tags.price,
        tags.weight,
        1,
        tags.tegs
      ];
      return GestureDetector(
        onTap: () => setState(() {
          showGeneralDialog(
              barrierColor: Color.fromRGBO(0, 0, 0, 0.4),
              transitionBuilder:(BuildContext context, Animation first, Animation second, widget)  {
              return Transform.scale(
                scale: first.value,
                child: Opacity(
                  opacity: first.value,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        width: thisWidth*0.89,
                        height: thisHeight*0.56,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(248, 247, 245, 1)
                                  ),
                                  width: thisWidth*0.89*0.9,
                                  height: thisHeight*0.56*0.52,
                                  alignment: Alignment.center,
                                  child: CachedNetworkImage(
                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                          color: Colors.pinkAccent,
                                          backgroundColor: Colors.transparent,
                                        ),
                                    imageUrl: thisImage,
                                    width: thisWidth*0.89*0.58,
                                    height: thisHeight*0.56*0.52*0.88,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 7, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Colors.white
                                          ),
                                          child: Icon(Icons.favorite_border_outlined)
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(left: 8)),
                                      GestureDetector(
                                        onTap: (){Navigator.pop(context);},
                                        child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                color: Colors.white
                                            ),
                                            child: Icon(Icons.close)
                                        ),
                                      )
                                    ]
                                  ),
                                )
                              ]
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5, top: 5),
                              alignment: Alignment.topLeft,
                              child: Text(
                                tags.name,
                                softWrap: true,
                                style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontFamily: 'SFProDisplay',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5, top: 5),
                              alignment: Alignment.topLeft,
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontFamily: 'SFProDisplay',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${tags.price} ₽'
                                    ),
                                    TextSpan(
                                      text: ' · ${tags.weight}г',
                                      style: const TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.4)
                                      )
                                    )
                                  ]
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5, top: 5),
                              alignment: Alignment.topLeft,
                              height: thisHeight*0.56*0.17,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  thisDescription,
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Color.fromRGBO(0, 0, 0, 0.65),
                                    fontFamily: 'SFProDisplay',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              width: double.infinity,
                              height: 60,
                              child: FloatingActionButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                backgroundColor: Color.fromRGBO(51, 100, 224, 1),
                                onPressed: () => setState(() {
                                  addCard(tag, tags.id);
                                }),
                                child: Text(
                                  'Добавить в корзину',
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontFamily: 'SFProDisplay',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
              },
              transitionDuration: const Duration(milliseconds: 250),
              barrierDismissible: false,
              barrierLabel: '',
              context: context,
              pageBuilder: (context, first, second) => Container()
          );
          }),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(248, 247, 245, 1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(
                          color: Colors.pinkAccent,
                          backgroundColor: Colors.transparent,
                        ),
                    height: 100,
                    width: 100,
                    imageUrl: image,
                  ),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 5, left: 4),
                  child: Text(
                    tags.name,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: const TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          )
      );
  }
}