//
//  API.swift
//  FIAPBLU365
//
//  Created by Gilson Gil on 24/11/18.
//  Copyright © 2018 FIAPON. All rights reserved.
//

import Foundation

import Alamofire

enum API: String {
  case receitaws = "https://www.receitaws.com.br/v1/cnpj/"
  case cpf = "https://search-fiapchallenge-3e5jejiizmuvouoncnkzcgozoq.us-east-1.es.amazonaws.com/fiap/_search?q=document:"

  static var all: [API] {
    return [.receitaws, cpf]
  }

  static func apis(for isCPF: Bool) -> [API] {
    if isCPF {
      return [.cpf]
    } else {
      return [.receitaws]
    }
  }

  func url(with documentId: String) -> String {
    switch self {
    case .receitaws:
      return "\(rawValue)\(documentId)"
    case .cpf:
      return "\(rawValue)\(documentId)"
    }
  }
}

struct APIRequest: URLRequestable {
  let documentId: String
  let api: API

  var method: HTTPMethod {
    return .get
  }

  var url: String {
    return api.url(with: documentId)
  }

  var parameters: Parameters? {
    return nil
  }

  var headers: Parameters? {
    return nil
  }

  var encoding: ParameterEncoding {
    return URLEncoding.queryString
  }

  func handleResponse(response: DataResponse<Any>, completion: @escaping (Any?) -> Void) {
    guard let data = response.data, let statusCode = response.response?.statusCode else {
      completion(nil)
      return
    }
    switch statusCode {
    case 200...299:
      completion(data)
    default:
      completion(nil)
    }
  }
}

/*
 https://www.receitaws.com.br/v1/cnpj/07166139000159
 */
