class ShutterStockImages {
  int? page;
  int? perPage;
  int? totalCount;
  String? searchId;
  List<ShutterStockImagesData>? data;

  ShutterStockImages(
      {this.page, this.perPage, this.totalCount, this.searchId, this.data});

  ShutterStockImages.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    totalCount = json['total_count'];
    searchId = json['search_id'];
    if (json['data'] != null) {
      data = <ShutterStockImagesData>[];
      json['data'].forEach((v) {
        data!.add(ShutterStockImagesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    data['total_count'] = totalCount;
    data['search_id'] = searchId;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShutterStockImagesData {
  String? id;
  double? aspect;
  Assets? assets;
  Contributor? contributor;
  String? description;
  String? imageType;
  bool? hasModelRelease;
  String? mediaType;

  ShutterStockImagesData(
      {this.id,
      this.aspect,
      this.assets,
      this.contributor,
      this.description,
      this.imageType,
      this.hasModelRelease,
      this.mediaType});

  ShutterStockImagesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aspect = json['aspect'];
    assets = json['assets'] != null ? Assets.fromJson(json['assets']) : null;
    contributor = json['contributor'] != null
        ? Contributor.fromJson(json['contributor'])
        : null;
    description = json['description'];
    imageType = json['image_type'];
    hasModelRelease = json['has_model_release'];
    mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['aspect'] = aspect;
    if (assets != null) {
      data['assets'] = assets!.toJson();
    }
    if (contributor != null) {
      data['contributor'] = contributor!.toJson();
    }
    data['description'] = description;
    data['image_type'] = imageType;
    data['has_model_release'] = hasModelRelease;
    data['media_type'] = mediaType;
    return data;
  }
}

class Assets {
  Preview? preview;
  Preview? smallThumb;
  Preview? largeThumb;
  Preview? hugeThumb;
  Preview? mosaic;
  Preview? preview1000;
  Preview? preview1500;

  Assets(
      {this.preview,
      this.smallThumb,
      this.largeThumb,
      this.hugeThumb,
      this.mosaic,
      this.preview1000,
      this.preview1500});

  Assets.fromJson(Map<String, dynamic> json) {
    preview =
        json['preview'] != null ? Preview.fromJson(json['preview']) : null;
    smallThumb = json['small_thumb'] != null
        ? Preview.fromJson(json['small_thumb'])
        : null;
    largeThumb = json['large_thumb'] != null
        ? Preview.fromJson(json['large_thumb'])
        : null;
    hugeThumb = json['huge_thumb'] != null
        ? Preview.fromJson(json['huge_thumb'])
        : null;
    mosaic = json['mosaic'] != null ? Preview.fromJson(json['mosaic']) : null;
    preview1000 = json['preview_1000'] != null
        ? Preview.fromJson(json['preview_1000'])
        : null;
    preview1500 = json['preview_1500'] != null
        ? Preview.fromJson(json['preview_1500'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (preview != null) {
      data['preview'] = preview!.toJson();
    }
    if (smallThumb != null) {
      data['small_thumb'] = smallThumb!.toJson();
    }
    if (largeThumb != null) {
      data['large_thumb'] = largeThumb!.toJson();
    }
    if (hugeThumb != null) {
      data['huge_thumb'] = hugeThumb!.toJson();
    }
    if (mosaic != null) {
      data['mosaic'] = mosaic!.toJson();
    }
    if (preview1000 != null) {
      data['preview_1000'] = preview1000!.toJson();
    }
    if (preview1500 != null) {
      data['preview_1500'] = preview1500!.toJson();
    }
    return data;
  }
}

class Preview {
  int? height;
  String? url;
  int? width;

  Preview({this.height, this.url, this.width});

  Preview.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['url'] = url;
    data['width'] = width;
    return data;
  }
}

class Contributor {
  String? id;

  Contributor({this.id});

  Contributor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
