//
//  CartView.swift
//  MNAD23-ICT
//
//  Created by Pubudu Mihiranga on 2023-11-12.
//

import SwiftUI

struct CartView: View {
    
    // declare your properties here
    
    @Binding var shopItems : [ShopItem]
    @State var totalBill : Double = 0
    @State var isCartEmpty : Bool = false
    @Binding var prevBill : Double
    var body: some View {
        NavigationStack {
            VStack{
                if (!isCartEmpty){
                    
                    VStack(alignment: .leading, content: {
                        List {
                            Section("Purchased Items") {
                                ForEach(shopItems.indices){index in
                                    if(shopItems[index].quantity > 0){
                                        HStack{
                                            Text("\(shopItems[index].name)")
                                            Spacer()
                                            Text(String(format: "%.1f", calculatePurchasedItems(item: shopItems[index] )))
                                            
                                        }
                                    }
                                }
                                
                                
                            }
                            
                            Section("Payement Details") {
                                HStack{
                                    Text("Net Amount")
                                    Spacer()
                                    Text(String(format: "%.1f", totalBill))
                                }
                            }
                            
                        }.listStyle(.plain)
                        
                        
                        
                        
                    }).padding()
                }else{
                    Text("Your Cart is Empty").padding(.top)
                    Spacer()
                    
                }
            }.navigationTitle("My Cart")
                .navigationBarTitleDisplayMode(.inline)
        }.onAppear{
            calculateTotal()
        }.onDisappear{
            prevBill = totalBill
        }
    }
    
    private func calculatePurchasedItems(item: ShopItem) -> Double {
        // calculate price for each purchase item
        // price = item price X item quantity
        return item.price * Double(item.quantity)
    }
    
    private func calculateTotal() {
        // calculate total bill value
        // total bill = each item price X each item quantity
        // hint: you need to calculate a new bill every time a user lands on this page;
        // this might be useful to decide when to display the 'Empty Cart' text.
        shopItems.forEach(){ item in
            totalBill = totalBill + item.price * Double(item.quantity)
        }
        
        if (totalBill == 0.0){
            isCartEmpty = true
        }
        
        
    }
}

#Preview {
    CartView(shopItems : .constant([
        ShopItem(name: "Broccoli", price: 5.00, quantity: 0),
        ShopItem(name: "Banana", price: 8.00, quantity: 0),
        ShopItem(name: "Avocado", price: 10.00, quantity: 0),
        ShopItem(name: "Chicken", price: 20.00, quantity: 0),
        ShopItem(name: "Water", price: 2.00, quantity: 1),
        // complete remaining data
    ]), prevBill: .constant(100))
}
