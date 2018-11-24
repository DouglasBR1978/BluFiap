//
//  Company.swift
//  FIAPBLU365
//
//  Created by Gilson Gil on 24/11/18.
//  Copyright © 2018 FIAPON. All rights reserved.
//

import Foundation

struct Company: Decodable {
  let name: String
  let email: String?
  let documentId: String?
  let fantasyName: String?
  let status: String?
  let socialCapital: String?
  let nature: String?
  let activity: String?
  let type: String?
  let street: String?
  let city: String?
  let neighborhood: String?
  let zipcode: String?
  let phone: String?
  let state: String?
  let socios: [Person]

  enum CodingKeys: String, CodingKey {
    case name = "nome"
    case socios = "qsa"
    case zipcode = "cep"
    case phone = "telefone"
    case state = "uf"
    case documentId = "cnpj"
    case socialCapital = "capital_social"
    case type = "tipo"
    case status = "situacao"
    case nature = "natureza_juridica"
    case street = "logradouro"
    case fantasyName = "fantasia"
    case activity = "atividade_principal"
    case neighborhood = "bairro"
    case city = "municipio"
    case email
  }

  enum ActivityCodingKeys: String, CodingKey {
    case text
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String.self, forKey: .name)
    socios = try container.decodeIfPresent([Person].self, forKey: .socios) ?? []
//    socios = []
    zipcode = try container.decodeIfPresent(String.self, forKey: .zipcode)
    phone = try container.decodeIfPresent(String.self, forKey: .phone)
    state = try container.decodeIfPresent(String.self, forKey: .state)
    documentId = try container.decodeIfPresent(String.self, forKey: .documentId)
    socialCapital = try container.decodeIfPresent(String.self, forKey: .socialCapital)
    type = try container.decodeIfPresent(String.self, forKey: .type)
    status = try container.decodeIfPresent(String.self, forKey: .status)
    nature = try container.decodeIfPresent(String.self, forKey: .nature)
    street = try container.decodeIfPresent(String.self, forKey: .street)
    fantasyName = try container.decodeIfPresent(String.self, forKey: .fantasyName)
    let activityDict = try container.decodeIfPresent([[String: String]].self, forKey: .activity)
    if let dict = activityDict?.first {
      activity = dict["text"]
    } else {
      activity = nil
    }
    neighborhood = try container.decodeIfPresent(String.self, forKey: .neighborhood)
    city = try container.decodeIfPresent(String.self, forKey: .city)
    email = try container.decodeIfPresent(String.self, forKey: .email)
  }

  var items: [Item] {
    var items: [Item] = []
    items.append(Item(title: "NOME", subtitle: name))
    if let fantasy = fantasyName {
      items.append(Item(title: "NOME FANTASIA", subtitle: fantasy))
    }
    if let email = email {
      items.append(Item(title: "EMAIL", subtitle: email))
    }
    if let socialCapital = socialCapital {
      items.append(Item(title: "CAPITAL SOCIAL", subtitle: socialCapital))
    }
    if let value = type {
      items.append(Item(title: "TIPO", subtitle: value))
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
    socios.forEach {
      items.append(Item(title: "SOCIO", subtitle: $0.name ?? ""))
    }
    return items
  }
}
