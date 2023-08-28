//
//  ContentView.swift
//  WeSplit
//
//  Created by codinglife365 on 28/8/2566 BE.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isAmountFocused: Bool
    
    var currency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage / 100)
        
        let tipValue = checkAmount * tipSelection
        let grandToTal = checkAmount + tipValue
        let amountPerPerson = grandToTal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // amount and number of people
                Section {
                    TextField("Amount", value: $checkAmount, format: currency)
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                // tip percentage
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                // amount per person
                Section {
                    Text(0, format: currency)
                } header: {
                    Text("Amount per person")
                }
                
                // total amount
                Section {
                    Text(0,format: currency)
                } header: {
                    Text("Total Amount")
                }
                
            }
            .navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
