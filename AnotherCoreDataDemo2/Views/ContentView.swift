//
//  ContentView.swift
//  AnotherCoreDataDemo2
//
//  Created by Frederick Javalera on 9/15/21.
//

import SwiftUI
import Foundation

struct ContentView: View {
  
  @StateObject var vm = ContentViewViewModel()
  @State var textFieldText: String = ""
  
  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        TextField("Add fruit here...", text: $textFieldText)
          .font(.headline)
          .padding(.leading)
          .frame(height: 55)
          .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
          .cornerRadius(10)
          .padding(.horizontal)
        
        Button(action: {
          guard !textFieldText.isEmpty else { return }
          vm.addFruit(text: textFieldText)
        }, label: {
          Text("Save")
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)))
            .cornerRadius(10)
        })
        .padding(.horizontal)
        
        List {
          ForEach(vm.savedEntities) { entity in
            Text(entity.name ?? "NO NAME")
              .onTapGesture {
                vm.updateFruit(entity: entity)
              }
          }
          .onDelete(perform: vm.deleteFruit)
        }
        .listStyle(PlainListStyle())
      }
    }
    .navigationTitle("Fruits")
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
