import 'package:coffeeappflutter/coffee.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final Coffee coffee;

  const Details({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
            child: Hero(
              tag: "text_${coffee.image}",
              child: Material(
                child: Text(
                  coffee.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: size.height * 0.4,
            child: Stack(
              children: [
                Positioned.fill(
                    child: Hero(
                        tag: coffee.image,
                        child: Image.asset(
                          coffee.image,
                          fit: BoxFit.fitHeight,
                        ))),
                Positioned(
                  left: size.width * 0.05,
                  bottom: 0,
                  child: TweenAnimationBuilder<double>(
                    builder: (context, value, child) {
                      return Transform.translate(
                          offset: Offset(-100 * value, 150 * value),
                          child: child!);
                    },
                    duration: Duration(milliseconds: 500),
                    tween: Tween(begin: 1.0, end: 0.0),
                    child: Text(
                      'Rs ${coffee.price.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                                color: Colors.black45,
                                blurRadius: 10,
                                spreadRadius: 20)
                          ]),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
