//
//  ContentViewViewModel.swift
//  AnotherCoreDataDemo2
//
//  Created by Frederick Javalera on 9/15/21.
//

import CoreData
import Foundation

class ContentViewViewModel: ObservableObject {
  
  let container: NSPersistentContainer
  @Published var savedEntities: [FruitEntity] = []
  
  init() {
    container = NSPersistentContainer(name: "FruitsContainer")
    container.loadPersistentStores { description, error in
      if let error = error {
        print("[❗️] ERROR LOADING CORE DATA. \(error)")
      }
    }
    
    fetchFruits()
  }
  
  func fetchFruits() {
    let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
    
    do
    {
      savedEntities = try container.viewContext.fetch(request)
    } catch let error {
      print("Error fetching. \(error)")
    }
  }
  
  func addFruit(text: String) {
    let newFruit = FruitEntity(context: container.viewContext)
    newFruit.name = text
    
    saveData()
  }
  
  func deleteFruit(indexSet: IndexSet) {
    guard let index = indexSet.first else { return }
    let entity = savedEntities[index]
    container.viewContext.delete(entity)
    
    saveData()
  }
  
  func updateFruit(entity: FruitEntity) {
    let currentName = entity.name ?? ""
    let newName = currentName + "!"
    entity.name = newName
    
    saveData()
  }
  
  func saveData() {
    do {
      try container.viewContext.save()
      fetchFruits()
    } catch let error {
      print("Error saving. \(error)")
    }
  }
}
