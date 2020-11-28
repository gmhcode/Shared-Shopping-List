//
//  DeleteListView.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/20/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI

struct DeleteListView: View {
    @ObservedObject var listVM : ListViewModel
    var body: some View {
        VStack (spacing: 30){
            Text(listVM.mostRecentList != nil ? listVM.mostRecentList!.title : "No List Selected")
            
                HStack {
                    Text("Are you sure you want to delete this list?")
                    Spacer()
                }
                    
                Button(action: {
                    guard let mostRecentList = listVM.mostRecentList else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
                    
                    //this should be "Delete List"
                    listVM.deleteList(list: mostRecentList)
                        listVM.showDeleteListView.toggle()
                    
                }, label: {
                    Text("Delete list")
                }).padding(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
                
            }
            .background(Color.white)
            .padding()
            

    }
}

struct DeleteListView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteListView(listVM: ListViewModel())
    }
}
