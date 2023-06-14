
Map cardItems = {};

Future<void> addCard(List itemCard, int id) async {
  cardItems[id] = itemCard;
}

Future<void> delCard(int id) async {
  cardItems.remove(id);
}

void plusInItemCard(int id) {
  for (final key in cardItems.keys){
    if (key==id){
      int oldCol = cardItems[id][5];
      cardItems[id][5] = oldCol + 1;
    }
  }
}

Future<void> minusInItemCard(int id) async {
  bool isDelId = false;
  if (cardItems.isNotEmpty) {
    for (final key in cardItems.keys) {
      if (key == id) {
        int oldCol = cardItems[id][5];
        if (oldCol == 1) {
          isDelId = true;
        }
        else {
          cardItems[id][5] = oldCol - 1;
        }
      }
    }
    if (isDelId) {
      delCard(id);
    }
  }
}

num sumCard() {
  num sum = 0;
  for (final key in cardItems.keys){
    sum += cardItems[key][3] * cardItems[key][5];
  }
  return sum;
}