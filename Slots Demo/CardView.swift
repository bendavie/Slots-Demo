//
//  CardView.swift
//  Slots Demo
//
//  Created by Benjamin Miles Davie on 26/08/2020.
//  Copyright © 2020 Benjamin Miles Davie. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    @Binding var symbol:String
    @Binding var background:Color
    
    var body: some View {
        
        Image(symbol)
        .resizable()
        .aspectRatio(1, contentMode: .fit)
        .background(background.opacity(0.5))
        .cornerRadius(20)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(symbol:Binding.constant("apple"), background: Binding.constant(Color.green))
    }
}
