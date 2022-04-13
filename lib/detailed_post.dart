part of menuoc;

class DetailedPost extends StatelessWidget {
  DetailedPost(this.index, this.post, {Key? key}) : super(key: key);

  final int index;
  final Post post;
  final GlobalKey<CommentListState> _commentKey = GlobalKey();
  final GlobalKey<CommentBoxState> _inputKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(fit: BoxFit.fitWidth, child: Text(post.title)),
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
                    child: Text("by " + post.creator,
                        style: const TextStyle(fontSize: 15)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.pink[50],
                  alignment: Alignment.topLeft,
                  child: Text(
                    post.content,
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
                Container(
                  color: Colors.pink[50],
                  child: Ratio(
                    id: post.postId,
                    isPost: true,
                    owner: post.creator,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CommentList(key: _commentKey, postID: post.postId),
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
                    _commentKey.currentState!._commentFetch(post.postId);
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

  String getComment() {
    String text = commentController.text;
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
  final String owner;
  final bool isPost;

  const Ratio({Key? key, required this.id, required this.isPost, required this.owner})
      : super(key: key);

  @override
  _RatioState createState() => _RatioState();
}

class _RatioState extends State<Ratio> {
  int totalLikes = 0;
  int likeState = 0;

  Future<void> _fetchRatio(int id, bool isPost) async {
    //TODO: Fetch ratio by id

    await Future.delayed(const Duration(milliseconds: 100));
    totalLikes = id;

    try {
      setState(() {});
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    Future.delayed(const Duration(milliseconds: 100));
    super.dispose();
  }

  @override
  void initState() {
    _fetchRatio(widget.id, widget.isPost);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isOwner = globals.currentUser.username == widget.owner || globals.currentUser.isAdmin;

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
        Text(
          totalLikes.toString(),
          style: const TextStyle(fontSize: 18),
        ),
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
        isOwner ? IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            //TODO:delete content

            Navigator.pop(context);
          },
        ) : const SizedBox(width: 50,),
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

  //TODO Add delete comment
  Future<void> _commentFetch(int postID) async {
    await Future.delayed(const Duration(milliseconds: 500));
    //TODO: Fetch Comment using postID
    List<Comment> newData = List.generate(
        10, (index) => Comment("Comment #$index", "User $index", index));
    comments.addAll(newData);
    try {
      setState(() {
        loading = false;
      });
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    _commentFetch(widget.postID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
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
                    color: Colors.blue[100],
                    alignment: Alignment.topLeft,
                    child: Text(
                      comments[index].user + ": " + comments[index].text,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    color: Colors.blue[50],
                    child: Ratio(
                      id: comments[index].commentId,
                      isPost: true,
                      owner: comments[index].user,
                    ),
                  ),
                ],
              );
            });
  }
}
