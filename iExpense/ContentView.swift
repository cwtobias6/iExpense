//
//  ContentView.swift
//  iExpense
//
//  Created by Christian Tobias on 2/14/21.
//

import SwiftUI

struct ExpenseItem:Identifiable {
    let id = UUID()
    var name:String
    var type:String
    var amount:Int
}

class Expenses:ObservableObject {
    @Published var items = [ExpenseItem]()
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) {Text($0.name)}
                    .onDelete(perform: removeItems)
            }
            
            .navigationTitle("iExpense")
            .navigationBarItems(trailing: Button(action: {
                let expense = ExpenseItem(name: "Xbox \(Int.random(in: 0...10))", type: "Gaming", amount: 10)
                expenses.items.append(expense)
                
            }, label: {
                Image(systemName: "plus")
            }))
        }
    }
    
    func removeItems(at offsets:IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
