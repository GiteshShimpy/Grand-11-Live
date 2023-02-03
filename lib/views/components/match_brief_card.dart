import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:my_grand_11_live/model/liveline.dart';
import 'package:my_grand_11_live/views/screens/match_info/match_details.dart';

import '../../utils/color.dart';
import '../../utils/match_utils.dart';
import '../../utils/style/app_text_style.dart';
import '../screens/home/live_controller.dart';

// ignore: must_be_immutable
class MatchBriefCard extends StatefulWidget {
  final LiveLine liveLine;

  const MatchBriefCard(this.liveLine, {super.key});

  @override
  State<MatchBriefCard> createState() => _MatchBriefCardState();
}

class _MatchBriefCardState extends State<MatchBriefCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => MatchDetailsScreen(widget.liveLine));
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.liveLine.title ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.white14SemiBold,
                        ),
                        SizedBox(height: 4,),
                        Text(
                          widget.liveLine.matchtime!,
                          style: AppTextStyle.mat10Normal),

                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(4),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: MatchUtils.isLive(widget.liveLine.jsondata)
                                ? Colors.black45
                                : (widget.liveLine.result?.isEmpty ?? false)
                                    ? Colors.deepOrange
                                    : Colors.black),
                        child: Text(
                            MatchUtils.isLive(widget.liveLine.jsondata)
                                ? "Live"
                                : (widget.liveLine.result?.isEmpty ?? false)
                                    ? "Upcoming"
                                    : "Finished",
                            style: AppTextStyle.white12Bold),
                      ),
                      MatchUtils.isLive(widget.liveLine.jsondata) ||
                          (widget.liveLine.result?.isEmpty ?? false)
                          ? Container(

                        child: CountdownTimer(
                          endTime: MatchUtils.getDateTime(
                              widget.liveLine.matchtime!)
                              .millisecondsSinceEpoch,
                          endWidget: Container(),
                          textStyle: AppTextStyle.orange12Bold,
                        ),
                      )
                          : Container(),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Stack(
                children: [

                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: 25,
                              height: 25,
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  child: CachedNetworkImage(
                                    imageUrl: MatchUtils.getTeamUrl(
                                        widget.liveLine, "A"),
                                    fit: BoxFit.cover,

                                    // placeholder: (_, __) => Center(
                                    //   child: CircularProgressIndicator(),
                                    // ),
                                  ))),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              MatchUtils.getTeamName(
                                  widget.liveLine.jsondata!, "A"),
                              style: AppTextStyle.white12Normal,
                            ),
                          ),
                          Text(
                            MatchUtils.getTeamAScore(widget.liveLine.jsondata!),
                            style: AppTextStyle.white12Bold,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 25,
                              height: 25,
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  child: CachedNetworkImage(
                                    imageUrl: MatchUtils.getTeamUrl(
                                        widget.liveLine, "B"),
                                    fit: BoxFit.cover,
                                    // placeholder: (_, __) => Center(
                                    //   child: CircularProgressIndicator(),
                                    // ),
                                  ))),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              MatchUtils.getTeamName(
                                  widget.liveLine.jsondata!, "B"),
                              style: AppTextStyle.white12Normal,
                            ),
                          ),
                          Text(
                            MatchUtils.getTeamBScore(widget.liveLine.jsondata!),
                            style: AppTextStyle.white12Bold,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: dividerColor,
              ),
              const SizedBox(
                height: 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MatchUtils.isLive(widget.liveLine.jsondata)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Partnership : ${MatchUtils.getJsonData(widget.liveLine.jsondata)?.partnership}",
                              style: AppTextStyle.white10SemiBold,
                            ),
                            Text(
                              " RR: ${Get.find<LiveController>().getRunRate(widget.liveLine)}",
                              style: AppTextStyle.white10SemiBold,
                            ),
                          ],
                        )
                      : Container(),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MatchUtils.getOnlyToss(widget.liveLine!)!=null ?
                            Text(
                              MatchUtils.getOnlyToss(widget.liveLine!) ?? "",
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              style: AppTextStyle.yellow12Bold,
                            ) :
                            Text(
                          MatchUtils.getScore(widget.liveLine),
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.start,
                          style: AppTextStyle.white12SemiBold,
                        ),

                            Text(
                              widget.liveLine!.venue!,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.mat10Normal,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          MatchUtils.getTeamARate(widget.liveLine.jsonruns!),
                          style: AppTextStyle.white12Bold,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          MatchUtils.getTeamBRate(widget.liveLine.jsonruns!),
                          style: AppTextStyle.white12Bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
