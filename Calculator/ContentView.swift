//
//  ContentView.swift
//  Calculator
//
//  Created by StudentPM on 3/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var numsAndOperations: [[String]] = [
            ["AC","+/-", "%", "÷"],
            ["7","8", "9", "x"],
            ["4","5", "6", "-"],
            ["1","2", "3", "+"],
            ["0", " . " , "="]
        ]
    @State var num1: Double = 0
    @State var num2: Double = 0
    @State var total: Double = 0
    
    var body: some View {
        
        VStack(alignment: .trailing){
            
            Spacer()
            
            Text("\(total)")
                .font(.title)
                .foregroundColor(Color.white)
                .padding()
            
            ForEach(numsAndOperations, id: \.self){ index in
                HStack{
                    ForEach(index, id: \.self){ btn in
                        if btn == "÷" || btn == "x" || btn == "-" || btn == "+" || btn == "="{
                            OperationsView(name: "\(btn)")
                        }
                        else if btn == "AC" || btn == "+/-" || btn == "%"{
                            ExtrasView(name: "\(btn)")
                        }
                        else{
                            NumbersView(name: "\(btn)")
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Color.black
                .ignoresSafeArea()
        }
    }
}

struct OperationsView: View{
    var name: String = ""
    var body: some View {
        ZStack{
            Circle()
                .fill(Color.orange)
            Button(action: setOperation, label: {
                Text(name)
                    .foregroundColor(Color.white)
            })
        }
    }
}

struct ExtrasView: View{
    var name: String = ""
    var body: some View {
        ZStack{
            Circle()
                .fill(Color(hex: "cccccc"))
            Button(action: setExtra, label: {
                Text(name)
                    .foregroundColor(Color.black)
            })
        }
    }
}

struct NumbersView: View {
    var name: String = ""
    var body: some View {
        ZStack{
            if name == "0"{
                Rectangle()
                    .fill(Color.gray)
                    .frame(width:180, height:80)
                    .cornerRadius(90)
                Button(action: setNumber, label: {
                    Text(name)
                        .foregroundColor(Color.white)
                })
            }
            else{
                Circle()
                    .fill(Color.gray)
                Button(action: setNumber, label: {
                    Text(name)
                        .foregroundColor(Color.white)
                })
            }
        }
    }
}

//FUNCTIONS ----------------

func setNumber(){
    
}
func setOperation(){
    
}
func setExtra(){
    
}

#Preview {
    ContentView()
}
