import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_grand_11_live/api/dio_client.dart';
import 'package:my_grand_11_live/model/finised_matches.dart';

import '../../utils/color.dart';
import '../../utils/style/app_text_style.dart';

class MatchCard extends StatelessWidget {
  final AllMatch allMatch;

  const MatchCard(this.allMatch, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
          color: boxColor, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(allMatch.title, style: AppTextStyle.white14SemiBold),
                      Text(
                        allMatch.matchtime,
                        style: AppTextStyle.white8Normal,
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
         const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    color: boxColor,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child:
                  SizedBox(
                      width: 40,
                      height: 40,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          child: CachedNetworkImage(
                            imageUrl: teamUrl+allMatch.teamAImage!,
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

                ),
              ),
              Expanded(
                child: Text(allMatch.teamA!,
                    textAlign: TextAlign.start,
                    style: AppTextStyle.white12Normal),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: boxColor),
                child: const Center(
                  child: Text(
                    "VS",
                    style: AppTextStyle.white8Normal,
                  ),
                ),
              ),
              Expanded(
                child: Text(allMatch.teamB!,
                    textAlign: TextAlign.end,
                    style: AppTextStyle.white12Normal),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    color: boxColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child:   SizedBox(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              child: CachedNetworkImage(
                                imageUrl: teamUrl+allMatch.teamBImage!,
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
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8,),
          Text(allMatch.result??allMatch.venue!,
              textAlign: TextAlign.center,
              style: allMatch.result==null?AppTextStyle.white10SemiBold:AppTextStyle.green10SemiBold)
        ],
      ),
    );
  }
}
