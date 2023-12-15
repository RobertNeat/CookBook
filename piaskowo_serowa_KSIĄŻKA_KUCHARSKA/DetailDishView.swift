//
//  DetailDishView.swift
//  SUPREME_kuchnia
//
//  Created by apple on 06/06/2023.
//

import SwiftUI

struct DetailDishView: View {
    let dish: Dish
    //@State var difficulty = 0.5
    @State var isGaugeScaled = false
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("\(dish.name!)")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Gauge(value: Double(dish.difficulty), in: 0...10) {
                    } currentValueLabel: {
                        Text("\(String(format: "%.2f",Double(dish.difficulty)))")// difficulty * 10
                            .font(.system(size: 12))
                    }
                    .gaugeStyle(.accessoryCircular)
                    .tint(Gradient(colors: [.cyan, .blue]))
                    .frame(width: 100, height: 100)
                    .scaleEffect(isGaugeScaled ? 1.50 : 1.20)
                    .onTapGesture(count: 2) {
                        isGaugeScaled.toggle()
                    }
                }
                
                VStack {
                    HStack {
                        Text("\(dish.ingredients!)")
                            .font(.system(size: 15, weight: .bold))
                        Spacer()
                    }
                    .padding(10)
                    
                    Text("\(dish.steps!)")
                        .font(.system(size: 15, weight: .regular))
                        .padding(10)
                }
            }
        }
    }
}


/*
 //przed dodaniem double-tap do zwiększenia wielkości gauge
struct DetailDishView: View {
    
    let dish:Dish
    
    //w core data trzeba dodać difficulty
    @State var difficulty = 0.5
    
    var body: some View {
            VStack{
                
                List{
                    
                    HStack{
                        Text("\(dish.name!)")
                            .font(.system(size: 30,weight: .semibold))
                            .foregroundColor(.gray)
                        //.padding(20)
                        
                        Spacer()
                        
                        Gauge(value: difficulty, in: 0...1) {
                        }currentValueLabel: {
                            Text("\(String(format: "%.2f",difficulty*10))")
                                .font(.system(size:12))
                        }
                        .gaugeStyle(.accessoryCircular)
                        .tint(Gradient(colors:[.cyan,.blue]))
                        .frame(width: 100,height: 100)//zwiększa ramkę krawędzi komponentu
                        .scaleEffect(1.20)//skaluje komponent bez względu na ramkę
                    }
                        
                        
                    VStack{
                        HStack{
                            Text("\(dish.ingredients!)")
                                .font(.system(size:15,weight: .bold))
                            Spacer()
                        }.padding(10)
                        
                        Text("\(dish.steps!)")
                            .font(.system(size:15,weight: .regular))
                            .padding(10)
                    }
                }
            }
    }
}



//struct DetailDishView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailDishView()
//    }
//}

*/
