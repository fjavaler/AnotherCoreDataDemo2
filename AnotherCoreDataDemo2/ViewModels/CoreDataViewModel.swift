//
//  CoreDataViewModel.swift
//  AnotherCoreDataDemo2
//
//  Created by Frederick Javalera on 9/15/21.
//

import CoreData
import Foundation

class CoreDataViewModel: ObservableObject {
  
  let container: NSPersistentContainer
  
  init() {
    container = NSPersistentContainer(name: "")
    container.loadPersistentStores { description, error in
      if let error = error {
        print("ERROR LOADING CORE DATA. \(error)")
      }
    }
  }
}
