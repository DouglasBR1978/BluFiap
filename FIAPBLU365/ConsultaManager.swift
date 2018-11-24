//
//  ConsultaManager.swift
//  FIAPBLU365
//
//  Created by Gilson Gil on 24/11/18.
//  Copyright © 2018 FIAPON. All rights reserved.
//

import Foundation

final class ConsultaManager: NSObject {
  let documentId: String
  let isCPF: Bool
  let isCNPJ: Bool
  let apis = API.all
  var consultas: [Consulta] = []

  let dispatchGroup = DispatchGroup()

  init(documentId: String, isCPF: Bool) {
    self.documentId = documentId
    self.isCPF = isCPF
    self.isCNPJ = !isCPF
    super.init()
  }

  func start(completion: @escaping ([Consulta]) -> Void) {
    consultas = Consulta.consultas(documentId: documentId)
    let missingConsultas: [Consulta] = API.apis(for: isCPF).compactMap { api in
      guard !consultas.contains(where: { $0.url == api.rawValue }) else { return nil }
      return Consulta(url: api.rawValue, documentId: documentId)
    }
    guard !missingConsultas.isEmpty else {
      completion(consultas)
      return
    }
    for _ in missingConsultas {
      dispatchGroup.enter()
    }
    missingConsultas.forEach { consulta in
      guard let api = API(rawValue: consulta.url!) else {
        return dispatchGroup.leave()
      }
      APIRequest(documentId: documentId, api: api).request { [weak self] json in
        guard let json = json as? NSData else {
          self?.dispatchGroup.leave()
          return
        }
        consulta.json = json
        self?.consultas.append(consulta)
        self?.dispatchGroup.leave()
      }
    }
    dispatchGroup.notify(queue: .main) {
      AppDelegate.saveContext()
      completion(self.consultas)
    }
  }
}
