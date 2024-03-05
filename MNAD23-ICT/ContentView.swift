//
//  ContentView.swift
//  MNAD23-ICT
//
//  Created by Pubudu Mihiranga on 2023-11-12.
//

import SwiftUI

struct ContentView: View {
    
    // declare your properties here
    
    @State var shopItems = [
        ShopItem(name: "Broccoli", price: 5.00, quantity: 0),
        ShopItem(name: "Banana", price: 8.00, quantity: 0),
        ShopItem(name: "Avocado", price: 10.00, quantity: 0),
        ShopItem(name: "Chicken", price: 20.00, quantity: 0),
        ShopItem(name: "Water", price: 2.00, quantity: 0),
        // complete remaining data
    ]
    
    @State var showCartView = false
    
    @State var proudctCount : Int = 0
    
    @AppStorage("Previous bill amount") var billAmount : Double = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                List{
                    ForEach(shopItems.indices, id: \.self){ index in
                        HStack{
                            Image(shopItems[index].name.lowercased())
                                .resizable()
                                .frame(width: 60, height: 60)
                                .scaledToFit()
                            
                            VStack(alignment:.leading){
                                Text(shopItems[index].name)
                                Text("$\(String(format: "%.1f", shopItems[index].price))")
                                
                            }
                            
                            Stepper(value: $shopItems[index].quantity, in: 0...10) {
                                Text("")
                            }
                            Text("\(shopItems[index].quantity)")

                        }
                    }
                }.listStyle(.plain)
                
                Spacer()
                
                Button("Checkout") {
                    showCartView.toggle()
                }.buttonStyle(.bordered)
                    .tint(.green)
                Text("Your previous deal with us was $\(String(format: "%.1f", billAmount))")
            }
            .padding()
            .navigationTitle("Buy Fresh Groceries")
            .navigationDestination(isPresented: $showCartView) {
                CartView(shopItems: $shopItems, prevBill: $billAmount)
            }
        }
    }
}

#Preview {
    ContentView()
}
