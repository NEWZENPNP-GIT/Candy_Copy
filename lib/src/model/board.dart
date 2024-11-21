class Board {
  String? boardId;
  String? title;
  String? contents;

  Board({
    this.boardId,
    this.title,
    this.contents,
  });

  factory Board.fromJson(Map<String, dynamic> json) => Board(
        boardId: json['boardId'],
        title: json['title'],
        contents: json['contents'],
      );

  Map<String, dynamic> toJson() => {
        'boardId': boardId,
        'title': title,
        'contents': contents,
      };
}
