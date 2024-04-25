class DynamicMockData {
  static Future<List<Map<String, Object>>> list(int page, int size) async {
    return List<Map<String, Object>>.generate(size, (index) {
      return {
        'id': index + (page - 1) * size + 1,
        'title': '标题${index + (page - 1) * size + 1}：这是一个列表标题，最多两行，多处部分将会被截取',
        'imageUrl': 'https://p26-passport.byteacctimg.com/img/user-avatar/097899bbe5d10bceb750d5c69415518a~100x100.awebp',
        'viewCount': 180,
      };
    });
  }
}