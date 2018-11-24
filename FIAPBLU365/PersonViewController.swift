//
//  PersonViewController.swift
//  FIAPBLU365
//
//  Created by Gilson Gil on 24/11/18.
//  Copyright © 2018 FIAPON. All rights reserved.
//

import UIKit

final class PersonViewController: UIViewController {
  var person: Person?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension PersonViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return person?.items.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let item = person?.items[indexPath.row] else { return UITableViewCell() }

    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = item.title
    cell.detailTextLabel?.text = item.subtitle

    cell.textLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize, weight: UIFont.Weight.bold)
    cell.detailTextLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize, weight: UIFont.Weight.light)

    return cell
  }
}
