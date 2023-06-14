import 'package:flutter/material.dart';
import 'package:test_example/controllers/controller.dart';
import 'package:test_example/models/categories.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:test_example/pages/tag_page.dart';
import 'package:test_example/pages/navigation_bar_pages/account_page.dart';
import 'package:test_example/pages/navigation_bar_pages/search_page.dart';
import 'package:test_example/pages/navigation_bar_pages/shopping_card.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';


const List<TabItem> items = [
  TabItem(
    icon: Icons.home_outlined,
    title: 'Главная',
  ),
  TabItem(
    icon: Icons.search,
    title: 'Поиск',
  ),
  TabItem(
    icon: Icons.shopping_cart_outlined,
    title: 'Корзина',
  ),
  TabItem(
    icon: Icons.account_circle_outlined,
    title: 'Аккаунт',
  ),
];

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends StateMVC {
  categoryController? _controller;
  int index_bottom_bar = 0;
  int index = 0;
  String title = '';

  _MainPageState(): super(categoryController()) {
    _controller = controller as categoryController;
  }

  @override
  void initState() {
    super.initState();
    _controller?.init();
  }


  @override
  Widget build(BuildContext context) {
    int red = 5;
    final pages = [
      _buildContentSelect(),
      SearchPage(),
      ShoppingCard(),
      AccountPage()
    ];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildMainTitle(),
        body: Container(
            child: pages[index_bottom_bar]),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(
                  color: Colors.grey[700],
                  size: 30
              ),
            //textTheme:
          ),
          child: BottomBarDefault(
            items: items,
            backgroundColor: Colors.white,
            color: Color.fromRGBO(165, 169, 178, 1),
            colorSelected: Color.fromRGBO(51, 100, 224, 1),
            indexSelected: index_bottom_bar,
            onTap: (int indexTab) => setState(() {
              this.index_bottom_bar = indexTab;
              index = 0;
            }),
          ),
        )
    );
    }
  Widget _buildContentSelect() {
    if (index == 1) {
      return TagPage();
    }
    else {
      return _buildContent();
    }
  }

  Widget _buildContent() {
    final state = _controller?.currentState;
    if (state is CategoryResultLoading) {
      return const Center(
        child: CircularProgressIndicator(
            color: Colors.pinkAccent,
            backgroundColor: Colors.transparent,
        )
      );
    }
    else if (state is CategoryResultFailure) {
      return Center(
        child: Text(
          state.error,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    }
    else {
      final category = (state as CategoryResultSuccess).categoryList.categories;
      return Padding(padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: category.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: _buildCategoryItem(category[index]));
        },
      ),
      );
    }
  }
   AppBar _buildMainTitle(){
     DateTime datetime = DateTime.now();
     String mounth_name = DateFormat.MMMM().format(datetime);

     if (index == 0) {
       return AppBar(
         //toolbarHeight: 60,
           backgroundColor: Colors.white,
           elevation: 0,
           //bottom: PreferredSize(child: Text('222'), preferredSize: Size(50, 60)),
           title: Row(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const Icon(
                 Icons.location_on_outlined,
                 size: 30,
                 color: Colors.black,
               ),
               Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   GestureDetector(
                     onTap: () {
                       //index_address = 1;
                       Navigator.pushNamed(
                           context,
                           '/tag',
                           //arguments: MasterPage(masterList[index]['name'].toString())
                       );
                     },
                     child: const Text(
                       "Санкт-Петербург",
                       style: TextStyle(
                         fontSize: 18,
                         fontFamily: 'SFProDisplay',
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ),
                   Padding(padding: EdgeInsets.only(bottom: 4)),
                   Text(
                     '${datetime.day} ${mounth_name}, ${datetime.year}',
                     style: const TextStyle(
                       color: Color.fromRGBO(0, 0, 0, 0.5),
                       fontSize: 14,
                       fontFamily: 'SFProDisplay',
                       fontWeight: FontWeight.w400,
                     ),
                   )
                 ],
               ),
             ],
           ),
           actions: const [
             Padding(
               padding: EdgeInsets.only(right: 10),
               child: SizedBox(
                 width: 44,
                 height: 44,
                 child: CircleAvatar(
                     radius: 30.0,
                     backgroundColor: Colors.transparent,
                     backgroundImage: NetworkImage("https://s3-alpha-sig.figma.com/img/738e/6e77/a92971e6075b85d18be0de93205d90cb?Expires=1687132800&Signature=FCndYJlBm8TzTblrx4DM7V0imqSpU9dyyIVL2LpAf6P1W4xO0gsuJp53OVqWc1A-qzsUHRK8NKhJnfmZOybn7AV7~OQGYAeKe7dnvh2ywbE6k5ojSxoesLjHn1f6bUAAF66dpBswZxD4M-hegplqKA0FCK5IrU99uIQQ33w0~UfrGOvaIJexw4h1emgUoNYpE6wdlpHgVx~6C1mc-K-YqSqGBr8dIcQa90ZnWL~mDWtPq67oJBWVUFrelJGlHKgsekVmYdVzbf9sYZdEj5279pqdinp2ps66tsgNJk3p3VG0Uew9WviJ8Bp2VacU8Czs4Bg5nzCOI2yHLGP6LTkm1g__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4")
                 ),
               ),
             ),
           ],
           bottom: PreferredSize(
       preferredSize: Size(MediaQuery.of(context).size.width,5),
     child: SizedBox()
           )
       );
     }
     else {
       return AppBar(
         backgroundColor: Colors.white,
         elevation: 0,
         title: GestureDetector(
           child: Text(
             title,
             style: TextStyle(
               fontSize: 18,
               fontFamily: 'SFProDisplay',
               fontWeight: FontWeight.w500,
             ),
           ),
         ),
         centerTitle: true,
         actions: const [
           Padding(
             padding: EdgeInsets.only(right: 10),
             child: SizedBox(
               width: 44,
               height: 44,
               child: CircleAvatar(
                   radius: 30.0,
                   backgroundColor: Colors.transparent,
                   backgroundImage: NetworkImage("https://s3-alpha-sig.figma.com/img/738e/6e77/a92971e6075b85d18be0de93205d90cb?Expires=1687132800&Signature=FCndYJlBm8TzTblrx4DM7V0imqSpU9dyyIVL2LpAf6P1W4xO0gsuJp53OVqWc1A-qzsUHRK8NKhJnfmZOybn7AV7~OQGYAeKe7dnvh2ywbE6k5ojSxoesLjHn1f6bUAAF66dpBswZxD4M-hegplqKA0FCK5IrU99uIQQ33w0~UfrGOvaIJexw4h1emgUoNYpE6wdlpHgVx~6C1mc-K-YqSqGBr8dIcQa90ZnWL~mDWtPq67oJBWVUFrelJGlHKgsekVmYdVzbf9sYZdEj5279pqdinp2ps66tsgNJk3p3VG0Uew9WviJ8Bp2VacU8Czs4Bg5nzCOI2yHLGP6LTkm1g__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4")
               ),
             ),
           ),
         ],
         leading:IconButton(
           icon: const Icon(
               Icons.arrow_back_ios_new_outlined
           ),
           color: Colors.black,
           onPressed: () => setState(() {
             index = 0;
           }),
         ),
         bottom: PreferredSize(
     preferredSize: Size(MediaQuery.of(context).size.width,5),
     child: SizedBox()
     )
     );
     }
   }

  Widget _buildCategoryItem(Categories categories) {
      return GestureDetector(
        onTap: () =>
            setState(() {
              title = categories.name;
              index = 1;
            }),
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(

                image: CachedNetworkImageProvider(categories.image_url),
                fit: BoxFit.fill,
              )
          ),
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 13, top: 10),
          child: Container(
            width: 150,
            child: Text(
              categories.name,
              textAlign: TextAlign.left,
              softWrap: true,
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
  }
}