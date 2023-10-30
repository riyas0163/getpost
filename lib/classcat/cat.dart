class cat {
  bool? success;
  List<CategoryList>? categoryList;

  cat({this.success, this.categoryList});

  cat.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['categoryList'] != null) {
      categoryList = <CategoryList>[];
      json['categoryList'].forEach((v) {
        categoryList!.add(new CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.categoryList != null) {
      data['categoryList'] = this.categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryList {
  int? categoryId;
  String? category;
  String? description;
  Null? deletedOn;
  Null? removedRemarks;
  int? createdBy;

  CategoryList(
      {this.categoryId,
        this.category,
        this.description,
        this.deletedOn,
        this.removedRemarks,
        this.createdBy});

  CategoryList.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    category = json['category'];
    description = json['description'];
    deletedOn = json['deletedOn'];
    removedRemarks = json['removedRemarks'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['category'] = this.category;
    data['description'] = this.description;
    data['deletedOn'] = this.deletedOn;
    data['removedRemarks'] = this.removedRemarks;
    data['createdBy'] = this.createdBy;
    return data;
  }
}
