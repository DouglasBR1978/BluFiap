//
//  NetworkError.swift
//  FIAPBLU365
//
//  Created by Gilson Gil on 24/11/18.
//  Copyright © 2018 FIAPON. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
  case timeout
  case noConnection
  case server
  case unauthorized

  init?(statusCode: Int?, error: Error?) {
    if let statusCode = statusCode {
      switch statusCode {
      case 401:
        self = .unauthorized
        return
      default:
        break
      }
    }
    if let error = error {
      switch error._code {
      case NSURLErrorTimedOut:
        self = .timeout
        return
      case NSURLErrorNotConnectedToInternet:
        self = .noConnection
        return
      default:
        break
      }
    }
    return nil
  }

  var description: String {
    return "Erro desconhecido, favor tentar novamente"
  }
}
