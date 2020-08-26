//
//  ContentView.swift
//  Slots Demo
//
//  Created by Benjamin Miles Davie on 25/08/2020.
//  Copyright © 2020 Benjamin Miles Davie. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private var betAmount = 5
    
    @State private var symbols = ["apple", "lemon", "donut"]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var credits = 1000
    @State private var background = Array(repeating: Color.white, count: 9)
    
    var body: some View {
        
        ZStack {
            
            Rectangle().foregroundColor(Color(red:  200/255, green: 143/255, blue: 32/255)).edgesIgnoringSafeArea(.all)
            
            Rectangle().foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255)).rotationEffect(Angle(degrees: 45)).edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                HStack {
                    
                    Image(systemName: "star.fill").foregroundColor(.white)
                    
                    Text("SwiftUI Slots")
                        .bold( ).foregroundColor(.white)
                    
                    Image(systemName: "star.fill").foregroundColor(.white)
                    
                }.scaleEffect(2)
                Spacer()
                
                Text("Credits: " + String(credits))
                    .foregroundColor(.black)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.5)).cornerRadius(20)
                Spacer()
                
                VStack {
                    
                    HStack {
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[0]], background: $background[0])
                        
                        CardView(symbol: $symbols[numbers[1]], background: $background[1])
                        
                        CardView(symbol: $symbols[numbers[2]], background: $background[2])
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[3]], background: $background[3])
                        
                        CardView(symbol: $symbols[numbers[4]], background: $background[4])
                        
                        CardView(symbol: $symbols[numbers[5]], background: $background[5])
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[6]], background: $background[6])
                        
                        CardView(symbol: $symbols[numbers[7]], background: $background[7])
                        
                        CardView(symbol: $symbols[numbers[8]], background: $background[8])
                        
                        Spacer()
                    }
                }
                
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            
                            self.processResults()
                            
                        }) {
                            Text("Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10).padding([.leading, .trailing,], 20)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        Text("\(betAmount) Credits")
                            .padding(.top, 10).font(.caption)
                    }
                    Spacer()
                    VStack {
                        Button(action: {
                            
                            self.processResults(true)
                            
                        }) {
                            Text("Super Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10).padding([.leading, .trailing,], 20)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        Text("\(betAmount * 5) Credits")
                            .padding(.top, 10).font(.caption)
                    }
                    Spacer()
                }
                
                
                Spacer()
            }
        }
    }
    func processResults(_ isMax:Bool = false) {
        self.background = self.background.map { _ in
            Color.white
        }
        
        if isMax{
            self.numbers = self.numbers.map({ _ in
                Int.random(in: 0...self.symbols.count - 1)})
        }
        else {
            self.numbers[3] = Int.random(in: 0...self.symbols.count-1)
            self.numbers[4] = Int.random(in: 0...self.symbols.count-1)
            self.numbers[5] = Int.random(in: 0...self.symbols.count-1)
        }
        processWin(isMax)
    }
    
    func processWin(_ isMax:Bool = false) {
        
        var matches = 0
        
        if !isMax {
            
            if isMatch(3, 4, 5) {
                matches += 1
            }
        }
        else {
            
            if isMatch(0, 1, 2) {
                matches += 1
            }
            
            if isMatch(3, 4, 5) {
                matches += 1
            }
            if isMatch(6, 7, 8){
                matches += 1
            }
            if isMatch(2, 4, 6){
                matches += 1
            }
            if isMatch(0, 4, 8){
                matches += 1
            }
        }
        
        if matches > 0 {
            
            self.credits += matches * self.betAmount * 5
            
        }
        else if !isMax {
            
            self.credits -= betAmount
            
        }
        else {
            
            self.credits -= betAmount * 10
            
        }
    }
    func isMatch(_ index1:Int, _ index2:Int, _ index3:Int) -> Bool {
        
        if self.numbers[index1] == self.numbers[index2] &&
            self.numbers[index2] == self.numbers[index3] {
            self.background[index1] = Color.green
            self.background[index2] = Color.green
            self.background[index3] = Color.green
            
            return true
        }
        
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
