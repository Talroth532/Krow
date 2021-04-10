import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/Jobs.dart';
import '../Widgets/post_form.dart';
import '../Providers/User.dart';

class PostJobScreen extends StatelessWidget {
  static const routeName = '/Postjobscreen';

  @override
  Widget build(BuildContext context) {
    String posterId = Provider.of<User>(context).userid;
    Function postFn = Provider.of<Jobs>(context).uploadJob;
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: PostForm(
          postFn,
          posterId,
        ),
      ),
    );
  }
}
