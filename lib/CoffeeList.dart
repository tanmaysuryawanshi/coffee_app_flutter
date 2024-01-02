import 'dart:developer';
import 'dart:ui';

import 'package:coffeeappflutter/CoffeeDetails.dart';
import 'package:coffeeappflutter/coffee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const duration = Duration(milliseconds: 300);
const initialPage = 8.0;

class CoffeeList extends StatefulWidget {
  const CoffeeList({super.key});

  @override
  State<CoffeeList> createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  PageController pageController =
      PageController(viewportFraction: 0.35, initialPage: initialPage.toInt());
  double _currentPage = initialPage;
  double _textPage = initialPage;
  final _pageTextController = PageController(initialPage: initialPage.toInt());
  void _coffeeScrollListner() {
    setState(() {
      _currentPage = pageController.page!;
    });
  }

  void _textScrollListner() {
    setState(() {
      _textPage = _currentPage;
    });
  }

  @override
  void initState() {
    pageController.addListener(_coffeeScrollListner);
    _pageTextController.addListener(_textScrollListner);
    super.initState();
  }

  @override
  void dispose() {
    pageController.removeListener(_coffeeScrollListner);
    _pageTextController.removeListener(_coffeeScrollListner);
    _pageTextController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Colors.black,
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
              left: 20,
              right: 20,
              bottom: -size.height * 0.22,
              height: size.height * 0.3,
              child: DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                      color: Colors.brown,
                      blurRadius: 90,
                      offset: Offset.zero,
                      spreadRadius: 45)
                ]),
              )),
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
                controller: pageController,
                scrollDirection: Axis.vertical,
                itemCount: coffeeList.length,
                onPageChanged: (value) {
                  if (value < coffeeList.length) {
                    _pageTextController.animateToPage(value,
                        duration: duration, curve: Curves.easeOut);
                  }
                },
                itemBuilder: (context, index) {
                  final result = _currentPage - index + 1;
                  log(result.toString());
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }

                  final coffee = coffeeList[index - 1];
                  final value = -0.4 * result + 1;
                  final opacity = value.clamp(0.0, 1.0);
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 650),
                          pageBuilder: (context, animation, _) {
                            return FadeTransition(
                                opacity: animation,
                                child: Details(coffee: coffee));
                          }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..translate(
                              0.0,
                              size.height / 2.6 * (1 - value).abs(),
                            )
                            ..scale(value),
                          child: Opacity(
                              opacity: opacity,
                              child: Hero(
                                tag: coffee.name,
                                child: Image.asset(
                                  coffee.image,
                                  fit: BoxFit.fitHeight,
                                ),
                              ))),
                    ),
                  );
                }),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: 100,
              child: TweenAnimationBuilder<double>(
                builder: (context, value, child) {
                  return Transform.translate(
                      offset: Offset(0.0, -100 * value), child: child!);
                },
                duration: duration,
                tween: Tween(begin: 1.0, end: 0.0),
                child: Column(
                  children: [
                    Expanded(
                        child: PageView.builder(
                            itemCount: coffeeList.length,
                            controller: _pageTextController,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final opacity = (1 - (index - _textPage).abs())
                                  .clamp(0.0, 1.0);

                              return Opacity(
                                  opacity: opacity,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.2),
                                    child: Hero(
                                      tag: "text_${coffeeList[index].image}",
                                      child: Material(
                                        child: Text(
                                          coffeeList[index].name,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ));
                            })),
                    AnimatedSwitcher(
                      duration: duration,
                      child: Text(
                        'Rs ${coffeeList[_currentPage.toInt()].price.toStringAsFixed(2)}',
                        key: Key(coffeeList[_currentPage.toInt()].name),
                        style: TextStyle(fontSize: 30),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
