
import 'package:dio/dio.dart';

import '../models/response.dart';

//Global Network

Dio client = Dio(options);

var options = BaseOptions(
    baseUrl: 'https://api.stackexchange.com/2.3/',
    responseType: ResponseType.json,
    headers: {
      "Content-Type" : "application/json",
      "Accept" : "application/json",
    }
);

// Global Variables

ResponseModel? responseModel;

int questionsPageNumber = 1;

bool? networkStatusOn;
