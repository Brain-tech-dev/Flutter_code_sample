class HomeData {
  List<HomeBanner>? bannerList;
  List<HomeCategory>? topCategory;
  List<HomeCategory>? generalCategory;

  HomeData({this.bannerList, this.topCategory, this.generalCategory});

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        bannerList: json["bannerList"] == null ? [] : List<HomeBanner>.from(json["bannerList"]!.map((x) => HomeBanner.fromJson(x))),
        topCategory: json["topCategory"] == null ? [] : List<HomeCategory>.from(json["topCategory"]!.map((x) => HomeCategory.fromJson(x))),
        generalCategory: json["generalCategory"] == null ? [] : List<HomeCategory>.from(json["generalCategory"]!.map((x) => HomeCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bannerList": bannerList == null ? [] : List<dynamic>.from(bannerList!.map((x) => x.toJson())),
        "topCategory": topCategory == null ? [] : List<dynamic>.from(topCategory!.map((x) => x.toJson())),
        "generalCategory": generalCategory == null ? [] : List<dynamic>.from(generalCategory!.map((x) => x.toJson())),
      };
}

class HomeBanner {
  int? id;
  String? bannerWeb;
  String? bannerMobile;
  String? link;
  dynamic createdDate;

  HomeBanner({this.id, this.bannerWeb, this.bannerMobile, this.link, this.createdDate});

  factory HomeBanner.fromJson(Map<String, dynamic> json) => HomeBanner(
        id: json["id"],
        bannerWeb: json["bannerWeb"],
        bannerMobile: json["bannerMobile"],
        link: json["link"],
        createdDate: json["createdDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bannerWeb": bannerWeb,
        "bannerMobile": bannerMobile,
        "link": link,
        "createdDate": createdDate,
      };
}

class HomeCategory {
  int? categoryId;
  String? categoryName;
  String? categoryNameThai;
  String? image;
  int? parentId;
  String? categoryUrl;

  HomeCategory({this.categoryId, this.categoryName, this.categoryNameThai, this.image, this.parentId, this.categoryUrl});

  factory HomeCategory.fromJson(Map<String, dynamic> json) => HomeCategory(
        categoryId: json["categoryID"],
        categoryName: json["categoryName"],
        categoryNameThai: json["categoryNameThai"],
        image: json["image"],
        parentId: json["parentID"],
        categoryUrl: json["categoryURL"],
      );

  Map<String, dynamic> toJson() => {
        "categoryID": categoryId,
        "categoryName": categoryName,
        "categoryNameThai": categoryNameThai,
        "image": image,
        "parentID": parentId,
        "categoryURL": categoryUrl,
      };
}
