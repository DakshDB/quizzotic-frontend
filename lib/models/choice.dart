class Choice {
  final int id;
  final int questionId;
  final String text;

  Choice({required this.id, required this.questionId, required this.text});

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      id: json['id'],
      questionId: json['questionId'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionId': questionId,
      'text': text,
    };
  }
}