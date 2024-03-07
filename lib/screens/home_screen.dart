import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/get_news_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetNewsContent getNewsContent = Get.find();
  double? deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    return Obx(
      () => getNewsContent.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: getNewsContent.listOfNewsVariable.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: getNewsContent
                                  .listOfNewsVariable[index].urlToImage,
                              height: 200.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Positioned(
                                right: 0,
                                top: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: deviceWidth! * .1,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: getNewsContent
                                  .listOfNewsVariable[index].title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: deviceWidth! * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ": ${getNewsContent.listOfNewsVariable[index].author}",
                              style: TextStyle(
                                color: Colors.grey, // Set the color to gray
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        getNewsContent.listOfNewsVariable[index].content,
                        style: TextStyle(fontSize: deviceWidth! * 0.04),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        getNewsContent.listOfNewsVariable[index].description,
                        style: TextStyle(
                            fontSize: deviceWidth! * 0.04, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
