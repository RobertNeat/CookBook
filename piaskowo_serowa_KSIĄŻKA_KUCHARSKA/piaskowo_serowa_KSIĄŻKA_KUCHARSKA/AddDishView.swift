//  AddDishView.swift
//  SUPREME_kuchnia


import SwiftUI

struct AddDishView: View {
    let category: Category
    
        //rzeczy do działania na Core Data
        @Environment(\.managedObjectContext) private var viewContext
        @State var ingredient_merged:String = ""
        @State var step_merged:String = ""
    
        //zmienne używane w widoku
        @State var dish_name: String = ""
        @State var dish_ingredients: String = ""
        @State var dish_steps: String = ""
        
        @State var ingredient_counter: Int = 1
        @State var step_counter: Int = 1
        
        @State var difficulty_level = 1.0
        
        @State var dish_one_ingredient: [String] = Array(repeating: "", count: 20) // Replace '10' with your desired initial capacity
        @State var dish_one_step: [String] = Array(repeating: "", count: 20)
    
    
    //walidacja (zmienne służące do walidacji
        //tytuł składa się jedynie z liter małych i dużych + polskie litery
    let allowedTitleCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZĄĆĘŁŃÓŚŹŻąćęłńóśźż ")
        //składniki składają się z : liter małych, liter dużych, polskie znaki, cyfry 0-9
        //kroki składają się z : liter małych, liter dużych, polskie znaki, cyfry 0-9
    let allowedListCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZĄĆĘŁŃÓŚŹŻąćęłńóśźż0123456789.,/ ")
    @State var validationStatus: Bool = false
    @State var validationMessage:String = ""
    
    var body: some View {
        VStack {
            List {
                Section(header:
                            Text("Tytuł")
                                .font(.system(size: 23, weight: .semibold))
                                .foregroundColor(.gray)
                                .padding(5)
                ) {
                    TextField("", text: $dish_name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(5)
                }
                
                Section(header:
                            Text("Poziom trudności: \(String(format: "%.0f", difficulty_level))")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(.gray)
                                .padding(5)
                ) {
                    Slider(value: $difficulty_level, in: 0...10, step: 1)
                        .tint(.blue)
                }
                
                Section(header:
                            HStack {
                                Text("Składniki (\(ingredient_counter)):")
                                    .font(.system(size: 18, weight: .regular))
                                    .foregroundColor(.gray)
                                Spacer()
                                Stepper(value: $ingredient_counter, in: 0...20, step: 1) {}
                            }
                ) {
                    
                    ForEach(0..<ingredient_counter, id: \.self) { index in
                        TextField("",text:$dish_one_ingredient[index])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                
                Section(header:
                            HStack {
                                Text("Kroki wykonania (\(step_counter)):")
                                    .font(.system(size: 18, weight: .regular))
                                    .foregroundColor(.gray)
                                Spacer()
                                Stepper(value: $step_counter, in: 0...20, step: 1) {}
                            }
                ) {
                    ForEach(0..<step_counter, id: \.self) { index in
                        TextField("", text: $dish_one_step[index])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
            }
            
            Button(action: {
                
                //obsługa przycisku zapisania
                print("Dish_ingredient:\(dish_one_ingredient)")
                print("Dish_step:\($dish_one_step)")
                
                saveForm()
            }) {
                Text("Zapisz")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
        }
        .navigationTitle("Dodaj nowe \(category.name!)")
        .alert(isPresented: $validationStatus) {
            Alert(
                title: Text("Błąd wprowadzanych danych"),
                message: Text("\(validationMessage)"),
                dismissButton: .default(Text("OK"))
            )
        }
         
    }
    
    
    private func validate() -> Bool { //zwracamy true w momencie kiedy był błąd walidacji
        validationMessage = "Niepoprawne dane w:\n"
        var validateStatus:Bool = false //dla wszystkich pól
        
        var validateIngredientsList:Bool = false
        var validateStepsList:Bool = false
        @State var test:String = ""
        
        for x in 0..<ingredient_counter{
            if(dish_one_ingredient[x].isEmpty || dish_one_ingredient[x].rangeOfCharacter(from: allowedListCharacters.inverted) != nil){
                validateIngredientsList = true
            }
        }
        
        for x in 0..<step_counter{
            if(dish_one_step[x].isEmpty || dish_one_step[x].rangeOfCharacter(from: allowedListCharacters.inverted) != nil){
                validateStepsList = true
            }
        }
        
        if dish_name.isEmpty || dish_name.rangeOfCharacter(from: allowedTitleCharacters.inverted) != nil {
            validationMessage += "- Tytuł dania\n"
            validateStatus = true
            
        }
        else if(validateIngredientsList){
            validationMessage += "- Składniki\n"
            validateStatus = true
            //sprawdzenie wszystkich elementów listy [składników] czy spełniają warunki
        }
        else if(validateStepsList){
            validationMessage += "- Plan przygotowania\n"
            validateStatus = true
            //sprawdzenie wszystkich elementów listy [kroków] czy spełniają warunki
        }
        if(validateStatus){
            validationMessage += "\nTytuł (A-z)\n"
            validationMessage += "Elementy listy (A-z,0-9)\n"
        }
        validationStatus = validateStatus
        return validateStatus
    }
    
    private func saveForm(){
        if (!validate()){
            let newDish = Dish(context: viewContext)
            //zebranie i zwalidowanie elementów z pól
            //ustawić: name,ingredients,steps
            
            newDish.name = dish_name
            
            newDish.difficulty = Int16(difficulty_level)
            
            
            for x in dish_one_ingredient{
                if(!x.isEmpty){
                    dish_ingredients += x+"\n"
                }
            }
            newDish.ingredients = dish_ingredients
            
            for (index, x) in dish_one_step.enumerated() {
                if !x.isEmpty {
                    let stepNumber = "\(index + 1)."
                    dish_steps += stepNumber + " " + x + "\n"
                }
            }

            newDish.steps = dish_steps
            
            category.addToToDish(newDish)
            
            do {
                try viewContext.save()
                print("Element added succesfully.")
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                
            }
        }
    }
}

//struct AddDishView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddDishView()
//    }
//}
