//
//  AppDelegate.swift
//  FIAPBLU365
//
//  Created by Gilson Gil on 24/11/18.
//  Copyright © 2018 FIAPON. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "FIAPBLU")
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    return true
  }

  func applicationWillTerminate(_ application: UIApplication) {
    saveContext()
  }

  func saveContext() {
    let context = persistentContainer.viewContext
    guard context.hasChanges else { return }
    do {
      try context.save()
    } catch {
      print(context)
    }
  }
}

extension AppDelegate {
  static var persistentContainer: NSPersistentContainer {
    guard let delegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
    return delegate.persistentContainer
  }

  static var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }

  static func saveContext() {
    guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
    delegate.saveContext()
  }
}
