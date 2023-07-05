import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/episode_widget.dart';

/// 특정 웹툰을 눌렀을때 그 웹툰에 대한 detail을 보여줌
class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // StatelessWidget에서 바로 이렇게 안됨. -> StatefulWidget으로 바꿔줌
  // Future<WebtoonDetailModel> webtoon = ApiService.getToonById(widget.id);
  // 서로 다른 클래스에 있는 data들 이므로 widget(부모를 뜻함).~~ 를 써야됨
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool isLiked = false; // 좋아요 여부

  // 사용자의 저장소에 connection이 생김
  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList("likedToons");
    if (likedToons != null) {
      // 이미 list가 있다는 뜻 -> 있으면은, 내가 찾는 id가 likedToons 안에 있는지 확인하기
      if (likedToons.contains(widget.id) == true) {
        // 사용자가 이전에 이미 좋아요를 누른적이 있음
        setState(() {
          // setState으로 해줘야 refresh해도 저장가능
          isLiked = true;
        });
      }
    } else {
      // list가 없을때
      prefs.setStringList("likedToons", []);
    }
  }

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodeById(widget.id);
    initPrefs();
  }

  onHeartTap() async {
    final likedToons = prefs.getStringList("likedToons");
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }
      prefs.setStringList("likedToons", likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 2, // 그림자
        title: Text(
          // StatelessWidget 일때는 그냥 title로 함. StatefulWidget에서는 'widget.~~'로 작성. 'widget 은 '부모'를 의미'
          widget.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        actions: [
          // 웹툰에 좋아요 누르기. 좋아요 누르거나 좋아요취소 하면 그 정보가 저장이 됨.(핸드폰 저장소에 데이터 담기)
          IconButton(
            onPressed: onHeartTap,
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // overflow 때문에 SinglechildScrollView 씀
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      // 꾸밀거기 때문에 container 이용
                      clipBehavior: Clip.hardEdge, // 이거 해줘야 borderradius 적용됨
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          // 팁 : 처음 shadow 색깔 red로 해서 크기맞추기
                          BoxShadow(
                            // 그림자
                            blurRadius: 7,
                            offset: const Offset(10, 10),
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                      width: 250,
                      child: Image.network(
                        widget.thumb,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              // Webtoon 에 대한 FutureBuilder
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${snapshot.data!.genre} / ${snapshot.data!.age}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    );
                  }
                  return const Text("...");
                },
              ),
              const SizedBox(
                height: 25,
              ),
              // Episodes 에 대한 FutureBuilder
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //episodes는 10개만 반환하므로 listview/listviewbuilder말고 column 이용 (10개만 반환하는줄 알았는데 실제로 여러개 반환해서 SingleScrollview 이용했음)
                    // 반환값이 많으면 Listview
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Episode(
                            episode: episode,
                            webtoonID: widget.id,
                          ) // Extract Method 했음
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
