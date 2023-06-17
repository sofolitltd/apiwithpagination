import 'package:flutter/material.dart';

import '../model/post.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //id
        Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blueAccent.shade100,
          ),
          child: Text(
            post.id.toString(),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
        ),

        const SizedBox(width: 16),

        //
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
              ),
              const SizedBox(height: 8),
              Text(post.body),
            ],
          ),
        ),
      ],
    );
  }
}
