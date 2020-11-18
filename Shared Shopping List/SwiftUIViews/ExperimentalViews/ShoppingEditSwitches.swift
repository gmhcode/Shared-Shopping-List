//
//  ShoppingEditSwitches.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/17/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI

struct ShoppingEditSwitches: View {
    
    @State var isOn = true
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Text("Hello")
                    Toggle(isOn: $isOn) {
                        
                    }
                    .labelsHidden()
                }
                Spacer()
                VStack {
                    Text("Hello")
                    Toggle(isOn: $isOn) {
                        
                    }
                    .labelsHidden()
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct ShoppingEditSwitches_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingEditSwitches()
    }
}
