//
//  ContentView.swift
//  WeSplit
//
//  Created by codinglife365 on 28/8/2566 BE.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0
    @FocusState private var isAmountFocused: Bool
    
    var currency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "THB")
    
    var tipSelected: Double {
        let tipSelected = (Double(checkAmount) * Double(tipPercentage)) / 100
        return tipSelected
    }
    
    var totalAmount: Double {
        let totalAmount = Double(checkAmount) + tipSelected
        return totalAmount
    }
    
    var peopleSelected: Double {
        let peopleSelected = Double(numberOfPeople) + 2
        return peopleSelected
    }
    
    var amountPerPerson: Double {
        let amountPerPerson = totalAmount / peopleSelected
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    // amount and number of people
                    Section {
                        TextField("Amount", value: $checkAmount, format: currency)
                            .keyboardType(.decimalPad)
                            .focused($isAmountFocused)
                    }header: {
                        Text("Bill Total")
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
                    
                    // total amount
                    Section {
                        Text(totalAmount,format: currency)
                    } header: {
                        Text("Total Amount")
                    }
                    
                    Section {
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                    }header: {
                        Text("Number of people")
                    }
                    
                    // amount per person
                    Section {
                        Text(amountPerPerson, format: currency)
                            .font(.title2).bold()
                    } header: {
                        Text("Amount per person")
                    }
                }//. FORM
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        isAmountFocused = false
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
