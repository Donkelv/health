import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/home_section/home_top.dart';

import 'app_logic/walk_tracker.dart';


class Home extends ConsumerWidget {

  
  

  @override
  Widget build(BuildContext context, ScopedReader scopedReader) {
    final walk = scopedReader(walkProvider);
    print(walk.walk.toString());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        TopHome(provider: walk),
        
      ],
    );
  }
}

