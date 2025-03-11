//
//  ContentView.swift
//  Calculator
//
//  Created by StudentPM on 3/10/25.
//

import SwiftUI

struct ContentView: View {
    //BUTTONS ------------
    @State private var numsAndOperations: [[String]] = [
        ["AC","+/-", "%", "÷"],
        ["7","8", "9", "x"],
        ["4","5", "6", "-"],
        ["1","2", "3", "+"],
        ["0", "." , "="]
    ]
    
    //NUMBERS ------------
    @State var num1: String = ""
    @State var num2: String = ""
    @State var num1Set: Bool = false
    @State var num2Set: Bool = false
    
    //OPERATION ----------
    @State var operationSign: String = ""
    
    //TOTAL --------------
    @State var total: Double = 0
    
    var body: some View {
        VStack(alignment: .trailing){
            Spacer()
            Text("\(total)")
                .font(.largeTitle)
                .foregroundColor(Color.white)
                .padding()
            ForEach(numsAndOperations, id: \.self){ index in
                HStack{
                    ForEach(index, id: \.self){ btn in
                        ButtonView(action: action, item: "\(btn)")
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
    
    func action(){
        
    }
}


//STRUCTS TO DESIGN IT --------------------

struct ButtonView: View {
    var action: () -> Void
    var item: String = ""
    var body: some View {
        Button(action: action){
            Text(item)
                .font(.largeTitle)
                .frame(width: decideWidthFrame(item: item), height: 80)
                .background(backgroundColor(item: item))
                .foregroundColor(fontColor(item: item))
                .cornerRadius(50)
        }
    }
    
    func decideWidthFrame(item: String) -> CGFloat{
        if item == "0"{
            return 170
        }
        else{
           return 80
        }
    }
    func backgroundColor(item: String) -> Color{
        if item == "=" || item == "+" || item == "-" || item == "x" || item == "÷"{
            return .orange
        }
        else if item == "AC" || item == "+/-" || item == "%"{
            return Color(hex: "cccccc")
        }
        else{
            return .gray
        }
    }
    func fontColor(item: String) -> Color{
        if item == "AC" || item == "+/-" || item == "%"{
            return .black
        }
        else {
            return .white
        }
    }
}
//struct ButtonsView: View{
//    var name: String = ""
//    var body: some View {
//        
//        //DESIGN FOR BUTTONS
//        ZStack{
//            if name == "="{
//                Circle()
//                    .fill(Color.orange)
//                Button(action: equation, label: {
//                    Text(name)
//                        .foregroundColor(Color.white)
//                })
//            }
//            else if name == "AC" || name == "+/-" || name == "%"{
//                //DESIGN for EXTRAS
//                Circle()
//                    .fill(Color(hex: "cccccc"))
//                Button(action: setExtra, label: {
//                    Text(name)
//                        .foregroundColor(Color.black)
//                        .font(.title)
//                })
//            }
//            else if name == "0"{
//                Rectangle()
//                    .fill(Color.gray)
//                    .frame(width:180, height:80)
//                    .cornerRadius(90)
//                Button(action: setNumber, label: {
//                    Text(name)
//                        .foregroundColor(Color.white)
//                        .font(.title)
//                })
//            }
//            else if name == "1" || name == "2" || name == "3" || name == "4" || name == "5" || name == "6" || name == "7" || name == "8" || name == "9" || name == "."{
//                Circle()
//                    .fill(Color.gray)
//                Button(action: setNumber, label: {
//                    Text(name)
//                        .foregroundColor(Color.white)
//                        .font(.title)
//                })
//            }
//            else{
//                Circle()
//                    .fill(Color.orange)
//                Button(action: setOperation, label: {
//                    Text(name)
//                        .foregroundColor(Color.white)
//                })
//            }
//        }
//    }
//}

//FUNCTIONS ----------------
func handleClick(){
    
    
    
}
//
//func setNumber(){
//    
//}
//func setOperation(){
//    
//}
//func setExtra(){
//    
//}
//func equation(){
//    
//}
//
#Preview {
    ContentView()
}
