//
//  ContentView.swift
//  SimpleCalculator
//
//  Created by Denilson Washuma on 07/08/2024.
//

import SwiftUI

struct CalculatorView: View {
 private var numberList:[Int] = [1,2,3,4,5,6,7,8,9,0]
    
    @State private var firstNumber:Int = 0
    @State private var secNumber:Int = 0
    @State private var symboll: String = "+"
    @State private var symbolIsSet:Bool = false
    @State private var secNumIsSet:Bool = false
    
    @State private var answer: Double = 0
    
    var body: some View {
        
        VStack() {
            Spacer()
            HStack() {
                Spacer()
                Text("\(firstNumber)")
                    .font(.largeTitle)
                
                Text("\(symboll)")
                
                Text("\(secNumber)")
                    .font(.largeTitle)
            }
            .padding(.trailing,50)
            
            HStack{
                Spacer()
                Text(String(format: "%.1f", answer))
                    .font(.system(size: 50))
                    .fontWeight(.semibold)
                
            }
            .padding(.trailing,50)
            
            
            
            
            Spacer()

            
            
            HStack(spacing:40){
               
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 80), count: 3),spacing: 5, content: {
                        ForEach(numberList, id: \.self){ numbe in
                            CalcButton(childText: String(numbe)) {
                                if symbolIsSet {
                                    secNumber = numbe
                                    secNumIsSet = true
                                } else {
                                    firstNumber = numbe
                                }
                                
                            }
                        }
                        
                    })
                    
                    
                    
                    VStack{
                        CalcButton(childText: "+", btColor: .yellow) {
                            setSymbol(symbo: "+")
                        }
                        CalcButton(childText: "-", btColor: .yellow){ setSymbol(symbo: "-") }
                        CalcButton(childText: "X", btColor: .yellow){ setSymbol(symbo: "X")}
                        CalcButton(childText: "=", btColor:secNumIsSet ? .yellow: .gray){
                            if secNumIsSet {
                                switch symboll {
                                case "+":
                                    answer = Double(firstNumber + secNumber)
                                    
                                    break
                                case "-":
                                    answer = Double(firstNumber - secNumber)
                                    break
                                case "X":
                                    answer = Double(firstNumber * secNumber)
                                    break
                                default:
                                    break
                                }
                            }
                        }
                    }
                    
                    
            }
            .padding(.bottom,20)
            
            Button(action: {
                firstNumber = 0
                secNumber = 0
                answer = 0
                symboll = "_"
                secNumIsSet = false
                symbolIsSet = false
                
            }, label: {
                Text("Reset")
            })
            .buttonStyle(.bordered)
            .padding(.bottom,20)
            
            
            
//            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
//            .background(.blue)
            
        }
        
       
      
    }
    
    func setSymbol(symbo:String){
        symboll = symbo
        symbolIsSet = true
    }
    
   
    
        
}

#Preview {
    CalculatorView()
}

struct CalcButton: View {
    var childText:String
    var btColor: Color = .purple
    var onClick: () -> Void
    
    var body: some View {
        Button(action: {
            onClick()
            
        }, label: {
            Text(childText)
                .font(.title.bold())
            
        })
        .foregroundStyle(.white)
        .frame(width: 70,height: 70)
        .background(btColor)
        .cornerRadius(8)
    }
}
    


