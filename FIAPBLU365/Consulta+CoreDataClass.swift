//
//  Consulta+CoreDataClass.swift
//  
//
//  Created by Gilson Gil on 24/11/18.
//
//

import Foundation
import CoreData

@objc(Consulta)
public class Consulta: NSManagedObject {
  var isValid: Bool {
    return json != nil
  }

  var prettyPrinted: [String: Any]? {
    guard let json = json else { return nil }
    guard let dict = try? JSONSerialization.jsonObject(with: json as Data, options: .allowFragments) as? [String: Any] else { return nil }
    return dict
  }

  convenience init(url: String, documentId: String) {
    guard let entity = NSEntityDescription.entity(forEntityName: "Consulta", in: AppDelegate.context) else { fatalError() }
    self.init(entity: entity, insertInto: AppDelegate.context)
    self.url = url
    self.documentId = documentId
  }

  static func consulta(url: String, documentId: String) -> Consulta {
    let fetchRequest: NSFetchRequest<Consulta> = Consulta.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "url == %@ AND documentId == %@", url, documentId)
    do {
      let consultas = try AppDelegate.context.fetch(fetchRequest)
      if let consulta = consultas.first {
        return consulta
      }
    } catch {
      print(error)
    }
    let consulta = Consulta(url: url, documentId: documentId)
    return consulta
  }

  static func consultas(documentId: String) -> [Consulta] {
    let fetchRequest: NSFetchRequest<Consulta> = Consulta.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "documentId == %@", documentId)
    do {
      let consultas = try AppDelegate.context.fetch(fetchRequest)
      return consultas
    } catch {
      print(error)
      return []
    }
  }
}
