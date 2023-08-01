import 'package:flutter/material.dart';

class AnimatedSearch extends StatefulWidget {
  AnimatedSearch({Key? key}) : super(key: key);

  @override
  State<AnimatedSearch> createState() => _AnimatedSearchState();
}


class _AnimatedSearchState extends State<AnimatedSearch> with TickerProviderStateMixin{
late AnimationController _animationController;
late Animation <double> _animation;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 1.0, end: 1.4).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    _animationController.forward();
    _animation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
          _animationController.reverse();
      }
      else if(status == AnimationStatus.dismissed){
        _animationController.forward();
      }
    });
  }
  
  @override
  void dispose(){
    _animationController.dispose();    
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
         radius: 35,
         backgroundColor: Colors.green,
        child: ScaleTransition(
          scale: _animation,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                color: const Color.fromARGB(255, 129, 126, 126),
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                 radius: 20,
                child:Icon(Icons.person_search_sharp, size: 30,)
              )
            ],
          ),
          ),
      ),
    );
  }
} 

 

        