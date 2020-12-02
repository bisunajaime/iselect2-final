import 'package:embesys_ctrl/constants.dart';
import 'package:flutter/material.dart';

class SoundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 18,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: boxGrad,
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SongImageAnimated(),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '2002',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'by Anne Marie',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Row(
            children: [
              Icon(
                Icons.skip_previous,
                color: Colors.white,
                size: 25,
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.play_circle_filled,
                color: Colors.white,
                size: 35,
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.skip_next,
                color: Colors.white,
                size: 25,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SongImageAnimated extends StatefulWidget {
  @override
  _SongImageAnimatedState createState() => _SongImageAnimatedState();
}

class _SongImageAnimatedState extends State<SongImageAnimated>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 30), vsync: this);
    animation = Tween<double>(begin: 0, end: 90).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    // controller.repeat(reverse: true);
    // if (animation.isCompleted) {
    //   controller.reverse();
    // } else {
    //   controller.forward();
    // }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animation.value,
      child: CircleAvatar(
        backgroundColor: Colors.indigo,
        backgroundImage: NetworkImage(
            'https://assets.audiomack.com/rosie18-3/3ec319fcc7fe488b07f9aa157225056b7f6e7d69cabb8e126162ab7f159d993d.jpeg?width=1000&height=1000&max=true'),
        radius: 28,
      ),
    );
  }
}
