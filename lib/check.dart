import 'package:flutter/material.dart';

class SlidingWidgetsPage extends StatefulWidget {
  @override
  _SlidingWidgetsPageState createState() => _SlidingWidgetsPageState();
}

class _SlidingWidgetsPageState extends State<SlidingWidgetsPage>
    with SingleTickerProviderStateMixin {
  bool showSecondWidget = false;
  late AnimationController _controller;
  late Animation<Offset> _firstWidgetAnimation;
  late Animation<Offset> _secondWidgetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Tween to animate the first widget moving left (Offset (-1.0, 0.0)) and coming back to the screen (Offset.zero)
    _firstWidgetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0), // Move out to the left
    ).animate(_controller);

    // Tween to animate the second widget moving from the right (Offset(1.0, 0.0)) and moving back out
    _secondWidgetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Off-screen on the right
      end: Offset.zero,              // Move into the screen
    ).animate(_controller);
  }

  void toggleWidgets() {
    if (showSecondWidget) {
      _controller.reverse(); // First widget comes back, second widget moves out
    } else {
      _controller.forward(); // Second widget slides in, first widget slides out
    }
    setState(() {
      showSecondWidget = !showSecondWidget;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sliding Widgets Animation'),
      ),
      body: Stack(
        children: [
          // First widget (sliding out to the left)
          SlideTransition(
            position: _firstWidgetAnimation,
            child: Center(
              child: Container(
                width: 200,
                height: 100,
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'First Widget',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),

          // Second widget (sliding in from the right)
          SlideTransition(
            position: _secondWidgetAnimation,
            child: Center(
              child: Container(
                width: 200,
                height: 100,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Second Widget',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleWidgets,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
