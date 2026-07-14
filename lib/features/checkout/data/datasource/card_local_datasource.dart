import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../shared/models/card_model.dart';

class CardLocalDataSource {
  static const String _key = 'user_cards';

  // ✅ tarjetas permitidas backend
  final List<CardModel> _allowedCards = const [
    CardModel(
      id: '1',
      cardNumber: '4242424242424242',
      brand: 'Visa',
    ),
    CardModel(
      id: '2',
      cardNumber: '4111111111111111',
      brand: 'Visa',
    ),
    CardModel(
      id: '3',
      cardNumber: '4000000000000002',
      brand: 'Mastercard',
    ),
  ];

  // ✅ obtener tarjetas
  Future<List<CardModel>> getCards() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) {
      // 🔥 si no hay, usamos las permitidas por defecto
      await saveCards(_allowedCards);
      return _allowedCards;
    }

    final List decoded = json.decode(jsonString);
    return decoded.map((e) => CardModel.fromJson(e)).toList();
  }

  // ✅ guardar tarjetas
  Future<void> saveCards(List<CardModel> cards) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded =
        json.encode(cards.map((e) => e.toJson()).toList());

    await prefs.setString(_key, encoded);
  }

  // ✅ obtener tarjeta seleccionada
  Future<CardModel?> getCardByIndex(int index) async {
    final cards = await getCards();

    if (index >= 0 && index < cards.length) {
      return cards[index];
    }
    return null;
  }
}