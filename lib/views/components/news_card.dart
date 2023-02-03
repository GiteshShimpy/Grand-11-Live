import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grand_11_live/model/NewsEverything.dart';
import 'package:my_grand_11_live/utils/color.dart';
import 'package:my_grand_11_live/utils/style/app_text_style.dart';
import 'package:my_grand_11_live/views/controllers/ad_controller.dart';
import 'package:readmore/readmore.dart';


class NewsCard extends StatelessWidget {
  final Article article;

  const NewsCard(this. article, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: CachedNetworkImage(
                    imageUrl: "${article.urlToImage}",
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


          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    article.title!,
                    maxLines: 3,
                    style: AppTextStyle.white14SemiBold,
                  ),
                  ReadMoreText(
                    article.description??"",
                    trimLines: 2,
                    style: AppTextStyle.mat12Normal,
                    colorClickableText: Colors.deepOrange,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: '...Read more',
                  callback: (v){
                      print(v);
                  AdController adController = Get.find<AdController>();
                      adController.getInterstitialAd();
                  },
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Text(
                      article.publishedAt?.toLocal().toString()??"",
                      textAlign: TextAlign.end,
                      style: AppTextStyle.white10Normal,
                    ),
                  ),

                ],),
            ),
          )


        ],
      ),
    );
  }
}
