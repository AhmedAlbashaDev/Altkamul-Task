import 'package:altkamul_task/models/question.dart';
import 'package:altkamul_task/widgets/tag_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';

class QuestionWidget extends StatelessWidget {
  QuestionWidget({Key? key , this.questionModel, this.onTap}) : super(key: key);

  QuestionModel? questionModel;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 20),
        decoration:  BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade400 , width: 1),
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AutoSizeText(
                  '${questionModel!.score!} votes',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                  ),
                ),
                const SizedBox(width: 7,),
                AutoSizeText(
                  '${questionModel!.answerCount} answers',
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.normal,
                      fontSize: 14
                  ),
                ),
                const SizedBox(width: 7,),
                AutoSizeText(
                  '${questionModel!.viewCount} views',
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.normal,
                      fontSize: 14
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10,),
            AutoSizeText(
              questionModel!.title ?? 'No Title Found',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15
              ),
            ),

            const SizedBox(height: 7,),
            InkWell(
              onTap: () async {
                if (!await launchUrl(Uri.parse(questionModel!.link!))) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).primaryColor,
                        content: const AutoSizeText(
                          'Can\'t Open This Link',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17
                          ),
                        ),
                      )
                  );
                }
              },
              child: AutoSizeText(
                questionModel!.link ?? 'No Link Found',
                style: TextStyle(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  decoration: TextDecoration.underline
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 10,),
            SizedBox(
              height: 33,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: questionModel!.tags!.length,
                itemBuilder: (context , index){
                  return TagWidget(tag: questionModel!.tags![index],);
                },
              ),
            ),

            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: '${questionModel!.owner!.profileImage}'  ?? '',
                      placeholder: (c,s){return SpinKitRipple(color: Theme.of(context).primaryColor,);},
                      errorWidget: (c,x,e){return const Icon(Icons.broken_image);},
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(width: 5,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          questionModel!.owner!.displayName ?? 'Ahmed Albasha',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor.withOpacity(.8),
                              fontWeight: FontWeight.w500,
                              fontSize: 12
                          ),
                        ),
                        AutoSizeText(
                          '${questionModel!.owner!.reputation ?? 0} asked',
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                              fontSize: 11
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 7,),
                AutoSizeText(
                  Jiffy(questionModel!.creationDate.toString()).fromNow(),
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                      fontSize: 12
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
