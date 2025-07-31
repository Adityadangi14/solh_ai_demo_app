import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_eval/flutter_eval.dart';
import 'package:stac/stac.dart';

class ResponseModel {
  List<Data>? data;

  ResponseModel({this.data});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? type;
  String? subtype;
  String? content;

  Data({this.type, this.subtype, this.content});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    subtype = json['subtype'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = type;
    data['subtype'] = subtype;
    data['content'] = content;
    return data;
  }
}


class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {

Map<String, dynamic> json=  {
        "type":  "container",
        "height":  80,
        "decoration":  {
            "color":  "#FFFFFF",
            "borderRadius":  {
                "topLeft":  16,
                "topRight":  16,
                "bottomLeft":  16,
                "bottomRight":  16
            },
            "boxShadow":  [
                {
                    "color":  "#22000000",
                    "blurRadius":  8,
                    "offset":  {
                        "dx":  0,
                        "dy":  2
                    }
                }
            ]
        },
        "child":  {
            "type":  "padding",
            "padding":  {
                "all":  12
            },
            "child":  {
                "type":  "row",
                "crossAxisAlignment":  "center",
                "children":  [
                   {
                        "type":  "sizedBox",
                        "width":  8
                    },
                    {
                        "type":  "container",
                        "width":  60,
                        "height":  60,
                        "clipBehavior":  "hardEdge",
                        "decoration":  {
                            "borderRadius":  {
                                "topLeft":  30,
                                "topRight":  30,
                                "bottomLeft":  30,
                                "bottomRight":  30
                            },
                            "color":  "#F0F0F0"
                        },
                        "child":  {
                            "type":  "padding",
                            "padding":  {
                                "all":  0
                            },
                            "child":  {
                                "type":  "image",
                                "src":  "https://solhapp-live.s3.amazonaws.com/solhApp/homepage-banner/1717064120134.jpg",
                                "imageType":  "network",
                                "fit":  "cover"
                            }
                        }
                    },
                    {
                        "type":  "sizedBox",
                        "width":  12
                    },
                    {
                        "type":  "expanded",
                        "child":  {
                            "type":  "column",
                            "crossAxisAlignment":  "start",
                            "children":  [
                                {
                                    "type":  "padding",
                                    "padding":  {
                                        "right":  12
                                    },
                                    "child":  {
                                        "type":  "text",
                                        "maxLines":  2,
                                        "data":  "Find calm with this audio-Relax and Unwind",
                                        "style":  {
                                            "fontSize":  14,
                                            "fontWeight":  "w700",
                                            "color":  "#222222"
                                        }
                                    }
                                },
                                {
                                    "type":  "sizedBox",
                                    "height":  4
                                },
                                {
                                    "type":  "text",
                                    "data":  "Audio",
                                    "style":  {
                                        "fontSize":  12,
                                        "fontWeight":  "w500",
                                        "color":  "#777777"
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "type":  "sizedBox",
                        "width":  8
                    },
                    {
                        "type":  "icon",
                        "icon":  "play_circle_filled",
                        "size":  28,
                        "color":  "#1858ec"
                    },
                    {
                        "type":  "sizedBox",
                        "width":  8
                    }
                ]
            }
        }
    };

// https://solhapp-live.s3.amazonaws.com/solhApp/homepage-banner/1717064120134.jpg
@override
  void initState() {
    // TODO: implement initState

   debugPrint( jsonDecode(map).toString(),wrapWidth: 9999999);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(body: Center(child: ListView.builder(itemCount: 100,itemBuilder: (context, index) {
      return Stac.fromJson(json,context);
    },)),);
  }
}


String map = "{\"recommendation\":[{\"content\":\"\\n\\t    {\\n  \\\"type\\\": \\\"container\\\",\\n  \\\"width\\\": 300,\\n  \\\"height\\\": 100,\\n  \\\"decoration\\\": {\\n    \\\"color\\\": \\\"#FFFFFF\\\",\\n    \\\"borderRadius\\\": {\\n      \\\"topLeft\\\": 16.0,\\n      \\\"topRight\\\": 16.0,\\n      \\\"bottomLeft\\\": 16.0,\\n      \\\"bottomRight\\\": 16.0\\n    },\\n    \\\"boxShadow\\\": [\\n      {\\n        \\\"color\\\": \\\"#22000000\\\",\\n        \\\"blurRadius\\\": 8.0,\\n        \\\"offset\\\": {\\\"dx\\\": 0, \\\"dy\\\": 2}\\n      }\\n    ]\\n  },\\n  \\\"child\\\": {\\n    \\\"type\\\": \\\"padding\\\",\\n    \\\"padding\\\": { \\\"all\\\": 12.0 },\\n    \\\"child\\\": {\\n      \\\"type\\\": \\\"row\\\",\\n      \\\"crossAxisAlignment\\\": \\\"start\\\",\\n      \\\"children\\\": [\\n        {\\n          \\\"type\\\": \\\"image\\\",\\n          \\\"src\\\": %v,\\n          \\\"imageType\\\": \\\"network\\\",\\n          \\\"width\\\": 80.0,\\n          \\\"height\\\": 80.0,\\n          \\\"fit\\\": \\\"cover\\\"\\n        },\\n        {\\n          \\\"type\\\": \\\"sizedBox\\\",\\n          \\\"width\\\": 12.0\\n        },\\n        {\\n          \\\"type\\\": \\\"expanded\\\",\\n          \\\"child\\\": {\\n            \\\"type\\\": \\\"column\\\",\\n            \\\"crossAxisAlignment\\\": \\\"start\\\",\\n            \\\"children\\\": [\\n              {\\n                \\\"type\\\": \\\"text\\\",\\n                \\\"data\\\": %v,\\n           \\n                \\\"style\\\": {\\n                  \\\"fontSize\\\": 14.0,\\n                  \\\"fontWeight\\\": \\\"w700\\\",\\n                  \\\"color\\\": \\\"#222222\\\"\\n                }\\n              },            \\n            ]\\n          }\\n        }\\n      ]\\n    }\\n  }\\n}\",\"data\":\"https://solhapp.com/blog/building-bridges-communication-empathy-listening-peace\",\"type\":\"blog\"},{\"content\":\"\\n\\t    {\\n  \\\"type\\\": \\\"container\\\",\\n  \\\"width\\\": 300,\\n  \\\"height\\\": 100,\\n  \\\"decoration\\\": {\\n    \\\"color\\\": \\\"#FFFFFF\\\",\\n    \\\"borderRadius\\\": {\\n      \\\"topLeft\\\": 16.0,\\n      \\\"topRight\\\": 16.0,\\n      \\\"bottomLeft\\\": 16.0,\\n      \\\"bottomRight\\\": 16.0\\n    },\\n    \\\"boxShadow\\\": [\\n      {\\n        \\\"color\\\": \\\"#22000000\\\",\\n        \\\"blurRadius\\\": 8.0,\\n        \\\"offset\\\": {\\\"dx\\\": 0, \\\"dy\\\": 2}\\n      }\\n    ]\\n  },\\n  \\\"child\\\": {\\n    \\\"type\\\": \\\"padding\\\",\\n    \\\"padding\\\": { \\\"all\\\": 12.0 },\\n    \\\"child\\\": {\\n      \\\"type\\\": \\\"row\\\",\\n      \\\"crossAxisAlignment\\\": \\\"start\\\",\\n      \\\"children\\\": [\\n        {\\n          \\\"type\\\": \\\"image\\\",\\n          \\\"src\\\": %v,\\n          \\\"imageType\\\": \\\"network\\\",\\n          \\\"width\\\": 80.0,\\n          \\\"height\\\": 80.0,\\n          \\\"fit\\\": \\\"cover\\\"\\n        },\\n        {\\n          \\\"type\\\": \\\"sizedBox\\\",\\n          \\\"width\\\": 12.0\\n        },\\n        {\\n          \\\"type\\\": \\\"expanded\\\",\\n          \\\"child\\\": {\\n            \\\"type\\\": \\\"column\\\",\\n            \\\"crossAxisAlignment\\\": \\\"start\\\",\\n            \\\"children\\\": [\\n              {\\n                \\\"type\\\": \\\"text\\\",\\n                \\\"data\\\": %v,\\n           \\n                \\\"style\\\": {\\n                  \\\"fontSize\\\": 14.0,\\n                  \\\"fontWeight\\\": \\\"w700\\\",\\n                  \\\"color\\\": \\\"#222222\\\"\\n                }\\n              },            \\n            ]\\n          }\\n        }\\n      ]\\n    }\\n  }\\n}\",\"data\":\"https://solhapp.com/blog/mental-wellbeing-strategies\",\"type\":\"blog\"},{\"content\":\"\\n\\t    {\\n  \\\"type\\\": \\\"container\\\",\\n  \\\"width\\\": 300,\\n  \\\"height\\\": 100,\\n  \\\"decoration\\\": {\\n    \\\"color\\\": \\\"#FFFFFF\\\",\\n    \\\"borderRadius\\\": {\\n      \\\"topLeft\\\": 16.0,\\n      \\\"topRight\\\": 16.0,\\n      \\\"bottomLeft\\\": 16.0,\\n      \\\"bottomRight\\\": 16.0\\n    },\\n    \\\"boxShadow\\\": [\\n      {\\n        \\\"color\\\": \\\"#22000000\\\",\\n        \\\"blurRadius\\\": 8.0,\\n        \\\"offset\\\": {\\\"dx\\\": 0, \\\"dy\\\": 2}\\n      }\\n    ]\\n  },\\n  \\\"child\\\": {\\n    \\\"type\\\": \\\"padding\\\",\\n    \\\"padding\\\": { \\\"all\\\": 12.0 },\\n    \\\"child\\\": {\\n      \\\"type\\\": \\\"row\\\",\\n      \\\"crossAxisAlignment\\\": \\\"start\\\",\\n      \\\"children\\\": [\\n        {\\n          \\\"type\\\": \\\"image\\\",\\n          \\\"src\\\": %v,\\n          \\\"imageType\\\": \\\"network\\\",\\n          \\\"width\\\": 80.0,\\n          \\\"height\\\": 80.0,\\n          \\\"fit\\\": \\\"cover\\\"\\n        },\\n        {\\n          \\\"type\\\": \\\"sizedBox\\\",\\n          \\\"width\\\": 12.0\\n        },\\n        {\\n          \\\"type\\\": \\\"expanded\\\",\\n          \\\"child\\\": {\\n            \\\"type\\\": \\\"column\\\",\\n            \\\"crossAxisAlignment\\\": \\\"start\\\",\\n            \\\"children\\\": [\\n              {\\n                \\\"type\\\": \\\"text\\\",\\n                \\\"data\\\": %v,\\n           \\n                \\\"style\\\": {\\n                  \\\"fontSize\\\": 14.0,\\n                  \\\"fontWeight\\\": \\\"w700\\\",\\n                  \\\"color\\\": \\\"#222222\\\"\\n                }\\n              },            \\n            ]\\n          }\\n        }\\n      ]\\n    }\\n  }\\n}\",\"data\":\"https://solhapp.com/blog/emotional-growth-lessons\",\"type\":\"blog\"},{\"content\":\"\\n\\t    {\\n  \\\"type\\\": \\\"container\\\",\\n  \\\"width\\\": 300,\\n  \\\"height\\\": 100,\\n  \\\"decoration\\\": {\\n    \\\"color\\\": \\\"#FFFFFF\\\",\\n    \\\"borderRadius\\\": {\\n      \\\"topLeft\\\": 16.0,\\n      \\\"topRight\\\": 16.0,\\n      \\\"bottomLeft\\\": 16.0,\\n      \\\"bottomRight\\\": 16.0\\n    },\\n    \\\"boxShadow\\\": [\\n      {\\n        \\\"color\\\": \\\"#22000000\\\",\\n        \\\"blurRadius\\\": 8.0,\\n        \\\"offset\\\": {\\\"dx\\\": 0, \\\"dy\\\": 2}\\n      }\\n    ]\\n  },\\n  \\\"child\\\": {\\n    \\\"type\\\": \\\"padding\\\",\\n    \\\"padding\\\": { \\\"all\\\": 12.0 },\\n    \\\"child\\\": {\\n      \\\"type\\\": \\\"row\\\",\\n      \\\"crossAxisAlignment\\\": \\\"start\\\",\\n      \\\"children\\\": [\\n        {\\n          \\\"type\\\": \\\"image\\\",\\n          \\\"src\\\": %v,\\n          \\\"imageType\\\": \\\"network\\\",\\n          \\\"width\\\": 80.0,\\n          \\\"height\\\": 80.0,\\n          \\\"fit\\\": \\\"cover\\\"\\n        },\\n        {\\n          \\\"type\\\": \\\"sizedBox\\\",\\n          \\\"width\\\": 12.0\\n        },\\n        {\\n          \\\"type\\\": \\\"expanded\\\",\\n          \\\"child\\\": {\\n            \\\"type\\\": \\\"column\\\",\\n            \\\"crossAxisAlignment\\\": \\\"start\\\",\\n            \\\"children\\\": [\\n              {\\n                \\\"type\\\": \\\"text\\\",\\n                \\\"data\\\": %v,\\n           \\n                \\\"style\\\": {\\n                  \\\"fontSize\\\": 14.0,\\n                  \\\"fontWeight\\\": \\\"w700\\\",\\n                  \\\"color\\\": \\\"#222222\\\"\\n                }\\n              },            \\n            ]\\n          }\\n        }\\n      ]\\n    }\\n  }\\n}\",\"data\":\"https://solhapp.com/blog/the-power-of-celebrating-small-wins\",\"type\":\"blog\"},{\"content\":\"\\n\\t    {\\n  \\\"type\\\": \\\"container\\\",\\n  \\\"width\\\": 300,\\n  \\\"height\\\": 100,\\n  \\\"decoration\\\": {\\n    \\\"color\\\": \\\"#FFFFFF\\\",\\n    \\\"borderRadius\\\": {\\n      \\\"topLeft\\\": 16.0,\\n      \\\"topRight\\\": 16.0,\\n      \\\"bottomLeft\\\": 16.0,\\n      \\\"bottomRight\\\": 16.0\\n    },\\n    \\\"boxShadow\\\": [\\n      {\\n        \\\"color\\\": \\\"#22000000\\\",\\n        \\\"blurRadius\\\": 8.0,\\n        \\\"offset\\\": {\\\"dx\\\": 0, \\\"dy\\\": 2}\\n      }\\n    ]\\n  },\\n  \\\"child\\\": {\\n    \\\"type\\\": \\\"padding\\\",\\n    \\\"padding\\\": { \\\"all\\\": 12.0 },\\n    \\\"child\\\": {\\n      \\\"type\\\": \\\"row\\\",\\n      \\\"crossAxisAlignment\\\": \\\"start\\\",\\n      \\\"children\\\": [\\n        {\\n          \\\"type\\\": \\\"image\\\",\\n          \\\"src\\\": %v,\\n          \\\"imageType\\\": \\\"network\\\",\\n          \\\"width\\\": 80.0,\\n          \\\"height\\\": 80.0,\\n          \\\"fit\\\": \\\"cover\\\"\\n        },\\n        {\\n          \\\"type\\\": \\\"sizedBox\\\",\\n          \\\"width\\\": 12.0\\n        },\\n        {\\n          \\\"type\\\": \\\"expanded\\\",\\n          \\\"child\\\": {\\n            \\\"type\\\": \\\"column\\\",\\n            \\\"crossAxisAlignment\\\": \\\"start\\\",\\n            \\\"children\\\": [\\n              {\\n                \\\"type\\\": \\\"text\\\",\\n                \\\"data\\\": %v,\\n           \\n                \\\"style\\\": {\\n                  \\\"fontSize\\\": 14.0,\\n                  \\\"fontWeight\\\": \\\"w700\\\",\\n                  \\\"color\\\": \\\"#222222\\\"\\n                }\\n              },            \\n            ]\\n          }\\n        }\\n      ]\\n    }\\n  }\\n}\",\"data\":\"https://solhapp.com/blog/breaking-free-from-addiction\",\"type\":\"blog\"}],\"text\":\"**Blog**:\\n\\n\\n\\n\\n\\n\"}";