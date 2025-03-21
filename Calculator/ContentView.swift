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
    @State var decimalSet: Bool = false
    @State var percentChosen: Bool = false
    
    //Keeping track of state
    @State var positive: Bool = true
    @State var sign: String = ""
    
    //OPERATION ----------
    @State var operationSet: Bool = false
    @State var operationSign: String = ""
    
    //TOTAL --------------
    @State var solvedBefore: Bool = false
    @State var result: Double = 0
    @State var equation: String = ""
    @State var total: String = "0"
    
    var body: some View {
        VStack(alignment: .trailing){
            //adds the gap
            Spacer()
            Text("\(total)")
            //THE TOTAL
                .font(.largeTitle)
                .foregroundColor(Color.white)
                .padding()
            ForEach(numsAndOperations, id: \.self){ index in
                HStack{
                    //BUTTONS AND STUFF
                    ForEach(index, id: \.self){ btn in
                        ButtonView(action: {handleClick(button: btn)}, item: "\(btn)")
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
    
    
    func handleClick(button: String){
        
        if button == "="{
            //send them to the solving function
            solveEquation()
        }
        else if button == "AC"{
            //resets everything
            num1 = ""
            operationSign = ""
            num2 = ""
            operationSet = false
            equation = ""
            total = "0"
            result = 0
            sign = ""
            positive = true
        }
        else if button == "+/-"{
            //changes it into a positive or negative
            var number: Double = 0
            if operationSet == false{
                if positive == true{
                    if let negativeNum = Double(num1){
                        number = negativeNum * -1
                        num1 = ("\(number)")
                    }

                    positive = false
                }
                else{
                    if let negativeNum = Double(num1){
                        number = negativeNum * -1
                        num1 = ("\(number)")
                    }
                    positive = true
                }
            }
            else {
                if positive == true{
                    if let negativeNum = Double(num2){
                        number = negativeNum * -1
                        num2 = ("\(number)")
                    }
                    positive = false
                }
                else{
                    if let negativeNum = Double(num2){
                        number = negativeNum * -1
                        num2 = ("\(number)")
                    }
                    positive = true
                }
            }
            total = ("\(num1)" + "\(operationSign)" + "\(num2)")
        }
        else if button == "+" || button == "-" || button == "x" || button == "÷"{
            //setting the operators
            if num1 == ""{
                num1 = "0"
                operationSign = button
                operationSet = true
                decimalSet = false
                total = ("\(num1)" + "\(operationSign)" + "\(num2)")
            }
            else{
                num2 = ""
                operationSign = button
                operationSet = true
                decimalSet = false
                total = ("\(num1)" + "\(operationSign)" + "\(num2)")
            }
        }
        else if button == "%"{
            //CHANGING STUFF INTO DECIMAL FORM
            if operationSet == false{
                //Ex: press 3 then click %. It turns into 0.03
                if let num = Double(total){
                    total = ("\(num/100)")
                    num1 = ("\(num/100)")
                }
            }
            //JUST IN CASE THEY DO IT AFTER THEY SOLVE AN EQUATION
            else if solvedBefore == true{
                total = ("\(result/100)")
                num1 = ("\(result/100)")
            }
            else{
//                total = ("\(result/100)")
                //IN CASE THEY PUT AN EQUATION
                if let doubleNum1 = Double(num1), let doubleNum2 = Double(num2){
                    total = ("\(doubleNum1 + (doubleNum2/100))")
                    num1 = ("\(doubleNum1 + (doubleNum2/100))")
                }
                operationSet = false
                num2 = ""
            }

            
//            num1 = ("\(result/100)")

        }
        else if button == "."{
            //THIS IS FOR DECIMALS
            if operationSet == false{
                //CHECKING IF THEY SET THE FIRST NUMBER YET
                if decimalSet == false{
                    num1 += button
                    total = ("\(num1)" + "\(operationSign)" + "\(num2)")
                    decimalSet = true
                }
            }
            else{
                //CHECKS IF THEY DID THE SECOND NUMBER
                if decimalSet == false{
                    num2 += button
                    total = ("\(num1)" + "\(operationSign)" + "\(num2)")
                    decimalSet = true
                }
            }
        }
        else{
//            if solvedBefore == true{
//                solvedBefore = false
//                
//                num1 = ""
//                operationSign = ""
//                num2 = ""
//                operationSet = false
//                equation = ""
//                total = "0"
//                
//                if operationSet == false{
//                    num1 += button
//                    total = ("\(num1)" + "\(operationSign)" + "\(num2)")
//                }
//                else{
//                    num2 += button
//                    total = ("\(num1)" + "\(operationSign)" + "\(num2)")
//                }
//            }
//            else{
            
            //SETTING THE NUMBERS IN THE EQUATION
                if operationSet == false{
                    num1 += button
                    total = ("\(num1)" + "\(operationSign)" + "\(num2)")
                }
                else{
                    num2 += button
                    total = ("\(num1)" + "\(operationSign)" + "\(num2)")
                }
//            }
        }
        
        
    }
    
    func solveEquation(){
        //Setting it be solved
        solvedBefore = true
        
        if operationSet == true{
            if operationSign == "+"{
                //ADDITION
                //transforming stuff into doubles
                if let doubleNum1 = Double(num1){
                    if let doubleNum2 = Double(num2){
                        result = doubleNum1 + doubleNum2
                    }
                }

                total = ("\(result)")
                num1 = ("\(result)")

                
            }
            else if operationSign == "-"{
                //SUBTRACTION
                if let doubleNum1 = Double(num1){
                    if let doubleNum2 = Double(num2){
                        result = doubleNum1 - doubleNum2
                    }
                }
                
                total = ("\(result)")
                num1 = ("\(result)")
                
//                if percentChosen == true{
//                    total = ("\(result/100)")
//                    num1 = ("\(result/100)")
//                    percentChosen = false
//                }
            }
            else if operationSign == "x"{
                //MULTIPLICATIOn
                if let doubleNum1 = Double(num1){
                    if let doubleNum2 = Double(num2){
                        result = (doubleNum1 * doubleNum2)
                    }
                }
                
                total = ("\(result)")
                num1 = ("\(result)")
                
//                if percentChosen == true{
//                    total = ("\(result/100)")
//                    num1 = ("\(result/100)")
//                    percentChosen = false
//                }
                
            }
            else{
                if num2 == "0"{
                    //if its divided by 0, turn it into error
                    total = "ERROR"
                }
                else{
                    //DIVISION
                    if let doubleNum1 = Double(num1){
                        if let doubleNum2 = Double(num2){
                            result = (doubleNum1 / doubleNum2)
                        }
                    }
                    
                    total = ("\(result)")
                    num1 = ("\(result)")
                    
                    //converts stuff
//                    if percentChosen == true{
//                        total = ("\(result/100)")
//                        num1 = ("\(result/100)")
//                        percentChosen = false
//                    }
                    
                }
            }
        }
        else{
            if percentChosen == true{
                //if they choose the percent and stuff but not the second number
                if let doubleNum1 = Double(num1){
                    total = ("\(doubleNum1/100)")
                    num1 = ("\(doubleNum1/100)")
                    percentChosen = false
                }
            }
        }
    }
}


//STRUCTS TO DESIGN IT --------------------

struct ButtonView: View {
    var action: () -> Void
    var item: String = ""
    var body: some View {
        Button(action: action){
            Text(item)
            //creating the button and stylizing it
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
        //SETTING THE BACKGROUND COLOR FOR THE BUTTONS
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
        //FONT COLOR FOR THE NUMBERS AND OTHER FUNCTIONS OF THE BUTTON
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
