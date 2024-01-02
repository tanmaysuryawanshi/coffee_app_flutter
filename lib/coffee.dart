import 'dart:math';

List<Coffee> coffeeList = List.generate(
    names.length,
    (index) => Coffee(
          name: names[index],
          price: (Random().nextDouble() * (200 - 100) + 100).toDouble(),
          image: 'assets/${index + 1}.png',
        ));
final names = [
  "Caramel Macchiato",
  "Caramel Cold Drink",
  "Iced Coffee Mocha",
  "Caramelized Pecan Latte",
  "Toffee Nut Latte",
  "Capuchino",
  "Toffee Nut Iced Latte",
  "Americano",
  "Vietnamese-Style Iced Coffee",
  "Black Tea Latte",
  "Classic Irish Coffee",
  "Toffee Nut Crunch Latte",
];

class Coffee {
  final String name;
  final double price;
  final String image;

  Coffee({required this.name, required this.price, required this.image});
}
