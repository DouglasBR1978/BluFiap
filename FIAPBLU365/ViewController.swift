//
//  ViewController.swift
//  FIAPBLU365
//
//  Created by Gilson Gil on 24/11/18.
//  Copyright © 2018 FIAPON. All rights reserved.
//

import UIKit

import CPF_CNPJ_Validator

final class ViewController: UIViewController {
  @IBOutlet
  weak var textField: UITextField!
  
  private var validator = StatusValidator()
  
  @IBAction
  func searchTapped(_ sender: UIButton) {
    submit()
  }

  func submit() {
    guard let text = textField.text else { return }
    let valid = validateDocumentId(text)
    guard valid.0 || valid.1 else { return }
    let consultaManager = ConsultaManager(documentId: text, isCPF: valid.0)
    consultaManager.start { consultas in
      if let consulta = consultas.first, let data = consulta.json {
        do {
          let company = try JSONDecoder().decode(Company.self, from: data as Data)
          self.performSegue(withIdentifier: "Company", sender: company)
        } catch {
          print(error)
          if let person = Person.person(from: data as Data) {
            self.performSegue(withIdentifier: "Person", sender: person)
          }
        }
      }
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    if let company = sender as? Company, let vc = segue.destination as? CompanyViewController {
      vc.company = company
    } else if let person = sender as? Person, let vc = segue.destination as? PersonViewController {
      vc.person = person
    }
  }
}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    submit()
    return true
  }
}

// MARK: - CPF CNPJ Validator
extension ViewController {
  func validateDocumentId(_ documentId: String?) -> (Bool, Bool) {
    guard let documentId = documentId else { return (false, false) }
    var status = validator.validate(cpf: documentId)
    if status == .valid {
      return (true, false)
    }
    status = validator.validate(cnpj: documentId)
    return (false, status == .valid)
  }
}
