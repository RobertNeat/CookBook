//  ContentView.swift
//  SUPREME_kuchnia

//prawa autorskie obrazy : pixabay:
//https://pixabay.com/photos/pumpkin-soup-soup-4508015/
//https://pixabay.com/photos/pasta-italian-cuisine-dish-3547078/
//https://pixabay.com/photos/meat-food-protein-shish-kebab-1155132/

import SwiftUI
import CoreData

struct ContentView: View {
    
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
        animation: .default
    )
    private var categories: FetchedResults<Category>
    
    let category_image_names = ["meat","pasta","soup"]
    @State var index = 0;
    
    //gest przytrzymania tytułu
    @State private var isForegroundBlack = false
    
    
    var body: some View {
        NavigationView {
            VStack{
                
                Text("Kategorie")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(isForegroundBlack ? .black : .gray) // conditionally set the foreground color
                    .padding(10)
                    .onLongPressGesture(perform: {
                            isForegroundBlack.toggle() // toggle the foreground color on long press
                    })
                    .onChange(of: isForegroundBlack, perform: { value in
                        if !value { // if it's not black, reset to default gray color
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                isForegroundBlack = false
                            }
                        }
                    })
                
                Spacer()
                
                List {
                    ForEach(Array(categories.enumerated()), id: \.element) { index, category in
                        NavigationLink(destination: CategoryListView(category:category)) {
                            HStack {
                                Text("\(category.name!)")
                                Spacer()
                                Image(category_image_names[index % category_image_names.count])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
                
                Spacer()
            }.onAppear {//podczas ładowania dodać przykładowe rasy, żeby w pickerze były dostępne
                if isFirstLaunch {
                    addCategory()
                    addMeatDishes_first_launch()
                    addPastaDishes_first_launch()
                    addSoupDishes_first_launch()
                    isFirstLaunch = false
                }
                
            }
            
        }
    }
    
    //dodanie kategorii (żeby istniały kategorie przed dodaniem potraw)
    private func addCategory(){
        let categoryNames:[String] = ["Zupy","Makarony","Dania mięsne"]
        for a in 0..<3{
            let newCategory = Category(context: viewContext)
            newCategory.name = categoryNames[a]
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError),\(nsError.userInfo)")
        }
    }
    
        
    //dodanie potraw w sekcji ... dania mięsne
    private func addMeatDishes_first_launch(){
        for a in 0..<3{
            let newDish = Dish(context: viewContext)
            newDish.name = meat_dish_name[a]
            newDish.ingredients = meat_dish_ingredients[a]
            newDish.steps = meat_dish_steps[a]
            newDish.difficulty = meat_dish_difficulty[a]
            
            if let selectedCategory = categories.first(where: { $0.name == "Dania mięsne"}){
                selectedCategory.addToToDish(newDish)
            }
        }
            
            do {
                try viewContext.save()
                print("Dishes [meat] added succesfully.")
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            
        }
        
    }
    
    //dodanie potraw w sekcji ... makarony
    private func addPastaDishes_first_launch(){
        for a in 0..<3{
            let newDish = Dish(context: viewContext)
            newDish.name = pasta_dish_name[a]
            newDish.ingredients = pasta_dish_ingredients[a]
            newDish.steps = pasta_dish_steps[a]
            newDish.difficulty = pasta_dish_difficulty[a]
            
            if let selectedCategory = categories.first(where: { $0.name == "Makarony"}){
                selectedCategory.addToToDish(newDish)
            }
        }
        
        do {
            try viewContext.save()
            print("Dishes [pasta] added succesfully.")
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    //dodanie potraw w sekcji ... zupy
    private func addSoupDishes_first_launch(){
        for a in 0..<3{
            let newDish = Dish(context: viewContext)
            newDish.name = soup_dish_name[a]
            newDish.ingredients = soup_dish_ingredients[a]
            newDish.steps = soup_dish_steps[a]
            newDish.difficulty = soup_dish_difficulty[a]
            
            if let selectedCategory = categories.first(where: { $0.name == "Zupy"}){
                selectedCategory.addToToDish(newDish)
            }
        }
            
        do {
            try viewContext.save()
            print("Dishes [zupy] added succesfully.")
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
