//
//  ItemCell.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/19/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI

struct ItemCell: View {
    @State var item : CodableItem
    @State var isChecked = true
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: isChecked ? "checkmark.square": "square")
                
                .onTapGesture {
                isChecked.toggle()
            }
            Spacer()
            Spacer()
            Text(item.name)
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        var item = CodableItem(listID: "id", store: "Store", userSentId: "John", name: "Item name", uuid: "uuid")
        ItemCell(item: item)
    }
}
