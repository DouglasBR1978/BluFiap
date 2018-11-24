//
//  URLRequestable.swift
//  FIAPBLU365
//
//  Created by Gilson Gil on 24/11/18.
//  Copyright © 2018 FIAPON. All rights reserved.
//

import Alamofire

protocol URLRequestable: URLRequestConvertible {
  var method: HTTPMethod { get }
  var url: String { get }
  var parameters: Parameters? { get }
  var headers: Parameters? { get }
  var encoding: ParameterEncoding { get }
  var queryParameters: Parameters? { get }

  func handleResponse(response: DataResponse<Any>, completion: @escaping (Any?) -> Void)
}

extension URLRequestable {
  var queryParameters: Parameters? { return nil }

  func asURLRequest() throws -> URLRequest {
    guard var urlComponents = URLComponents(string: url) else { fatalError() }
    if let query = queryParameters {
      let queryItems = query.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
      urlComponents.queryItems = queryItems
    }
    guard let url = urlComponents.url else { fatalError() }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    headers?.forEach {
      guard let value = $0.value as? String else { return }
      urlRequest.addValue(value, forHTTPHeaderField: $0.key)
    }
    return try encoding.encode(urlRequest, with: parameters)
  }

  @discardableResult
  func request(_ completion: @escaping (Any?) -> Void) -> DataRequest {
    return SessionManager.default.request(self).responseJSON { response in
      print("\n\n")
      print("--- [REQUEST] \(response.request?.httpMethod ?? "") - \(response.request?.url?.absoluteString ?? "")")
      print("--- [HEADER] \(response.request?.allHTTPHeaderFields ?? [:])")
      if let body = response.request?.httpBody {
        print("--- [BODY] \(String(data: body, encoding: String.Encoding.utf8) ?? "")\n")
      }
      if let status = response.response?.statusCode {
        print("--- [STATUS] \(status)\n")
      }
      if let res = response.result.value {
        print("--- [RESULT] \(res)\n")
      } else {
        print("--- [RESULT] EMPTY\n")
      }
      print("|____\n")
      if let networkError = NetworkError(statusCode: response.response?.statusCode,
                                         error: response.error) {
        completion(networkError)
        return
      }
      self.handleResponse(response: response, completion: completion)
    }
  }
}
