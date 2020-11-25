//
//  ListCell.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 10/30/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI

struct ListCell: View {
    let list : CodableList
    let itemCount : Int
    let brightness : Double
    var body: some View {
        
        VStack {
            HStack {
                
                VStack(alignment: .leading) {
                    Text(list.title)
                        .lineLimit(2)
                        .padding([.leading],10)
                        .multilineTextAlignment(.leading)
                        .truncationMode(.tail)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .heavy, design: .default))
                }
                Spacer()
                Text("\(itemCount)")
                    .padding(.trailing,10)
                    .font(.system(size: 30, weight: .heavy, design: .default))
                    .foregroundColor(Color.white)
                
            }.frame(height: 80, alignment: .center)
            .background(Color.blue.brightness(brightness))
          
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 5)
            )
        }
    }
}


struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        let list = CodableList(uuid: "123", title: "list title", listMasterID: "listMasteerID")
        ListCell(list: list, itemCount: 1, brightness: 0)
    }
}

struct SliderView: View {
    @State private var titleLength: CGFloat = 1
    
    var body: some View {
        Text(String.init(repeating: "T", count: Int(self.titleLength)))
        Text("Title length")
        Slider(value: $titleLength, in: 1...100) {
            // This Text is for Accessibility
            Text("Title")
        }
    }
}
