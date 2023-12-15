//  CategoryListView.swift
//  SUPREME_kuchnia
import SwiftUI

struct CategoryListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Dish.name, ascending: true)],
        animation: .default
    )
    private var dishes: FetchedResults<Dish>
    
    let category: Category
    
    var body: some View {
        VStack {
            
            //Text("Ilość dań: \(dishes.count)")
            //.font(.system(size:30,weight: .bold))
            //.foregroundColor(.gray)
            
            List {
                ForEach(dishes) { dish in
                    if dish.toCategory?.name == category.name {
                        NavigationLink(destination: DetailDishView(dish: dish)) {
                            Text("\(dish.name!)")
                        }
                    }
                }
                .onDelete { indices in
                    deleteDishes(at: indices)
                }
                
                NavigationLink(destination: AddDishView(category: category)) {
                    HStack {
                        Image(systemName: "plus.app")
                            .font(.system(size: 25))
                            .foregroundColor(.blue)
                        Text("Dodaj danie \(category.name!)")
                            .foregroundColor(.blue)
                    }
                }
            }
            
        }
        .navigationTitle("\(category.name!)")
    }
    
    private func deleteDishes(at indices: IndexSet) {
        indices.forEach { index in
            let dish = dishes[index]
            viewContext.delete(dish)
        }
        saveContext()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            // Handle the error here
            print("Error saving context: \(error)")
        }
    }
}

//preview nie działa, bo nie mamy konstruktora parametrowego dla klasy Category (dlatego zakomentowane, bo by preview provider by próbował odczytywać pole name które nie jest ustawione)
//struct CategoryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryListView(category: Category())//category_name: "Nazwa_kategorii"
//    }
//}
