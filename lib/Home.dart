import 'package:coffeeappflutter/CoffeeList.dart';
import 'package:coffeeappflutter/coffee.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! < -10) {
            Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 650),
                pageBuilder: (context, animation, _) {
                  return FadeTransition(
                      opacity: animation, child: CoffeeList());
                }));
          }
        },
        child: Stack(
          children: [
            SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFA89276), Colors.white])),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              height: size.height * 0.4,
              top: size.height * 0.15,
              child: Hero(
                tag: coffeeList[6].name,
                child: Image.asset(coffeeList[6].image),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: size.height * 0.7,
              child: Hero(
                tag: coffeeList[7].name,
                child: Image.asset(
                  coffeeList[7].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -size.height * 0.8,
              height: size.height,
              child: Hero(
                tag: coffeeList[8].name,
                child: Image.asset(
                  coffeeList[8].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                height: 140,
                left: 0,
                right: 0,
                bottom: size.height * 0.25,
                child: Image.asset('assets/logo.png'))
          ],
        ),
      ),
    );
  }
}
