//
//  ContentView.swift
//  WeSplit
//
//  Created by Faizaan Khan on 11/7/22.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount = 0.0
    @State private var numberOfpeople: Int = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = [10,15,20,25,0]
    
    var splitAmount: Double{
        let peopleCount = Double(numberOfpeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = billAmount / 100 * tipSelection
        let grandTotal = billAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalBillAmount: Double{
        let tipSelection = Double(tipPercentage)
        let tipValue = billAmount/100 * tipSelection
        let totalAmount = billAmount + tipValue
        
        return totalAmount
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Enter the Amount", value: $billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfpeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section{
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }
//                    .pickerStyle(.segmented)
                } header: {
                    Text("How much percentage do you want to leave?")
                }
                
                Section{
                    Text(totalBillAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .background(tipPercentage == 0 ? .red : Color(UIColor.systemBackground))
                } header: {
                    Text("Total amount after tax")
                }
                
                Section{
                    Text(splitAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("We Split")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
