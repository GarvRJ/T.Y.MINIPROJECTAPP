import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rating_dialog/rating_dialog.dart';

class RatingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: Text(
        'Station Rating',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        'Tap a star to set your rating and write a feedback for the station.',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      // your app's logo?
      image: const Image(image: AssetImage('assets/LOGO.png'),width: 100,height: 100,),
      submitButtonText: 'Submit',
      commentHint: 'Tell us your experience',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');

        // TODO: add your own logic
        if (response.rating < 3.0) {
          // send their comments to your email or anywhere you wish
          // ask the user to contact you instead of leaving a bad review
        } else {
          // _rateAndReviewApp();
        }
      },
    );
  }
}
