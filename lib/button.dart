import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({super.key});

  @override
  State<AnimatedButton> createState() => _AnState();
}

class _AnState extends State<AnimatedButton> with TickerProviderStateMixin {
  double turns = 0.0;
  bool isClicked = false;
  Color customBlackColor = const Color.fromARGB(255, 53, 53, 53);
  Color customWhiteColor = const Color.fromARGB(255, 237, 237, 237);
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customWhiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "Animated Button",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Center(
        child: AnimatedRotation(
          duration: const Duration(seconds: 1),
          turns: turns,
          curve: Curves.easeOutExpo,
          child: GestureDetector(
            onTap: () {
              if (isClicked) {
                setState(() => turns -= 1 / 4);
                _controller.reverse();
              } else {
                setState(() => turns += 1 / 4);
                _controller.forward();
              }
              isClicked = !isClicked;
            },
            child: AnimatedContainer(
              curve: Curves.easeOutExpo,
              duration: const Duration(seconds: 1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: customWhiteColor,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 30.0,
                        offset: isClicked
                            ? const Offset(20, -20)
                            : const Offset(20, 20),
                        color: Colors.grey),
                    BoxShadow(
                        blurRadius: 30.0,
                        offset: isClicked
                            ? const Offset(-20, 20)
                            : const Offset(-20, -20),
                        color: Colors.white)
                  ]),
              child: SizedBox(
                height: 150,
                width: 150,
                child: Center(
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _controller,
                    size: 100,
                    color: customBlackColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
