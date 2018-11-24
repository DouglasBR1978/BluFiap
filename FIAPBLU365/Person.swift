//
//  Person.swift
//  FIAPBLU365
//
//  Created by Gilson Gil on 24/11/18.
//  Copyright © 2018 FIAPON. All rights reserved.
//

import Foundation

struct Person: Decodable {
  var name: String?
  var documentId: String?
  var address: String?
  var street: String?
  var city: String?
  var neighborhood: String?
  var zipcode: String?
  var phone: String?
  var state: String?
  var onlinebuyer: String?
  var age: Int?
  var wage: String?

  enum CodingKeys: String, CodingKey {
    case name = "nome"
  }

  static func person(from data: Data) -> Person? {
    guard let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return nil }
    if let hits = object?["hits"] as? [String: Any],
      let hits2 = hits["hits"] as? [[String: Any]],
      let source = hits2[0]["_source"] as? [String: Any] {
      print(source)
      var person = Person(onlinebuyer: source["compradoronline"] as? String ?? "", uf: source["uf"] as? String ?? "")
      person.age = source["idade"] as? Int
      person.wage = source["financeiros_renda"] as? String
      return person
    }
    return nil
  }

  init(onlinebuyer: String, uf: String) {
    name = nil
    documentId = nil
    address = nil
    street = nil
    city = nil
    neighborhood = nil
    zipcode = nil
    phone = nil
    state = uf
    age = nil
    wage = nil
    self.onlinebuyer = onlinebuyer
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String.self, forKey: .name)
    documentId = nil
    address = nil
    street = nil
    city = nil
    neighborhood = nil
    zipcode = nil
    phone = nil
    state = nil
    onlinebuyer = nil
    wage = nil
    age = nil
  }

  var items: [Item] {
    var items: [Item] = []
//    if let email = email {
//      items.append(Item(title: "EMAIL", subtitle: email))
//    }
    if let value = name {
      items.append(Item(title: "NOME", subtitle: value))
    }
    if let value = age {
      items.append(Item(title: "IDADE", subtitle: String(describing: value)))
    }
    if let value = wage {
      items.append(Item(title: "RENDA", subtitle: value))
    }
    if let value = onlinebuyer {
      items.append(Item(title: "COMPRADOR ONLINE", subtitle: value))
    }
    if let value = state {
      items.append(Item(title: "UF", subtitle: value))
    }
    if let value = city {
      items.append(Item(title: "CIDADE", subtitle: value))
    }
    if let value = street {
      items.append(Item(title: "LOGRADOURO", subtitle: value))
    }
    if let value = zipcode {
      items.append(Item(title: "CEP", subtitle: value))
    }
    return items
  }
}
