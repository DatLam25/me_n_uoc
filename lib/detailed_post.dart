part of menuoc;

class DetailedPost extends StatelessWidget {
  DetailedPost(this.index, this.item, {Key? key}) : super(key: key);

  final int index;
  final Post item;
  final GlobalKey<CommentListState> _commentKey = GlobalKey();
  final GlobalKey<CommentBoxState> _inputKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(fit: BoxFit.fitWidth, child: Text(item.title)),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  color: Colors.grey[50],
                  height: 25,
                  child: FittedBox(
                    child: Text("by " + item.creator,
                        style: const TextStyle(fontSize: 15)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.pink[50],
                  alignment: Alignment.topLeft,
                  child: Text(
                    item.content,
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
                Ratio(
                    id: item.postId,
                    isPost: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                CommentList(key: _commentKey, postID: item.postId),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                // First child is enter comment text input
                CommentBox(
                  key: _inputKey,
                ),
                // Second child is button
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.black,
                  iconSize: 20.0,
                  onPressed: () {
                    //TODO: Add call to post the comment
                    String inputted = _inputKey.currentState!.getComment();
                    _commentKey.currentState!._commentFetch(item.postId);
                  },
                )
              ])),
        ],
      ),
    );
  }
}

class CommentBox extends StatefulWidget {
  const CommentBox({Key? key}) : super(key: key);

  @override
  CommentBoxState createState() => CommentBoxState();
}

class CommentBoxState extends State<CommentBox> {
  final commentController = TextEditingController();

  String getComment(){
    String text =  commentController.text;
    commentController.clear();
    return text;
  }


  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: commentController,
        autocorrect: true,
        decoration: const InputDecoration(
          hintText: "Comment",
          border: OutlineInputBorder(
            // borderRadius:
            //     BorderRadius.all(Radius.zero(5.0)),
              borderSide: BorderSide(color: Colors.black)),
        ),
      ),
    );
  }
}



class Ratio extends StatefulWidget {
  final int id;
  final bool isPost;

  const Ratio({Key? key, required this.id, required this.isPost}) : super(key: key);

  @override
  _RatioState createState() => _RatioState();
}

class _RatioState extends State<Ratio> {
  int likes = 0;
  int dislikes = 0;
  int likeState = 0;

  Future<void> _fetchRatio(int id, bool isPost) async {
    //TODO: Fetch ratio by id

    await Future.delayed(const Duration(milliseconds: 1000));
    likes = id;
    dislikes = id;
    setState(() {});
  }

  @override
  void initState() {
    _fetchRatio(widget.id, widget.isPost);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: (likeState == 1)
              ? const Icon(Icons.thumb_up_alt)
              : const Icon(Icons.thumb_up_alt_outlined),
          onPressed: () {
            setState(() {
              if (likeState == 1) {
                likeState = 0;
              } else {
                likeState = 1;
              }
            });
          },
        ),
        Text(likes.toString(), style: const TextStyle(fontSize: 18),),
        IconButton(
          icon: (likeState == -1)
              ? const Icon(Icons.thumb_down_alt)
              : const Icon(Icons.thumb_down_alt_outlined),
          onPressed: () {
            setState(() {
              if (likeState == -1) {
                likeState = 0;
              } else {
                likeState = -1;
              }
            });
          },
        ),
        Text(dislikes.toString(), style: const TextStyle(fontSize: 18),)
      ],
    );
  }
}

class CommentList extends StatefulWidget {
  final int postID;

  const CommentList({Key? key, required this.postID}) : super(key: key);

  @override
  CommentListState createState() => CommentListState();
}

class CommentListState extends State<CommentList> {
  List<Comment> comments = [];
  bool loading = true;

  Future<void> _commentFetch(int postID) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    //TODO: Replace with real http request
    List<Comment> newData = List.generate(
        10, (index) => Comment("Comment #$index", "User $index", index));
    comments.addAll(newData);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    _commentFetch(widget.postID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const CircularProgressIndicator()
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    color: Colors.blueGrey[100],
                    alignment: Alignment.topLeft,
                    child: Text(
                      comments[index].user + ": " + comments[index].text,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Ratio(
                    id: comments[index].commentId,
                    isPost: true,
                  ),
                ],
              );
            });
  }
}
