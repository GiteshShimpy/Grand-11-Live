import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_grand_11_live/model/get_all_players.dart';

import '../../api/dio_client.dart';
import '../../utils/color.dart';
import '../../utils/style/app_text_style.dart';

class SquadCard extends StatefulWidget {
  final Playerslist playerItem;
   const SquadCard(this.playerItem, {Key? key}) : super(key: key);

  @override
  State<SquadCard> createState() => _SquadCardState();
}

class _SquadCardState extends State<SquadCard> {
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.all( 4),
      
      decoration: BoxDecoration(
          color: boxColor, borderRadius: BorderRadius.circular(3)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                width: 60,
                height: 80,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: CachedNetworkImage(
                      imageUrl: "$playerUrl${widget.playerItem.playerImage}",
                      fit: BoxFit.cover,
                      // placeholder: (_, __) => Center(
                      //   child: CircularProgressIndicator(),
                      // ),
                      // errorWidget: (_, __, ___) => Container(
                      //   color: Colors.black12,
                      //   child: Icon(
                      //     Icons.broken_image_outlined,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                    ))),




             Flexible(
               child: Text(
                widget.playerItem.playerName,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: AppTextStyle.white12SemiBold,
            ),
             ),
             Text(
              widget.playerItem.teamName,
               textAlign: TextAlign.center,
              style: AppTextStyle.mat12Normal,
            ),
          ],
        ),
      ),
    );
  }
}
