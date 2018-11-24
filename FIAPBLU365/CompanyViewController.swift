//
//  CompanyViewController.swift
//  FIAPBLU365
//
//  Created by Gilson Gil on 24/11/18.
//  Copyright © 2018 FIAPON. All rights reserved.
//

import UIKit

final class CompanyViewController: UIViewController {
  var company: Company?

  
  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

  }
  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */

}

extension CompanyViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return company?.items.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let item = company?.items[indexPath.row] else { return UITableViewCell() }

    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = item.title
    cell.detailTextLabel?.text = item.subtitle

    cell.textLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize, weight: UIFont.Weight.bold)
    cell.detailTextLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize, weight: UIFont.Weight.light)

    return cell
  }
}

extension CompanyViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}
