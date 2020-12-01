//
//  RemoveListMemberView.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/30/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import SwiftUI

struct RemoveListMemberView: View {
    @ObservedObject var listVM = listViewModel
    @State var isChecked = false
    @State var areYouSureView = false
    @State var selectedListMember : CodableListMember?
    
    @State var listMembers = listViewModel.listAndItemsAndListMembers.listMembers.filter({$0.listID == listViewModel.mostRecentList?.uuid})
    
    
    var body: some View {
        ZStack {
            List(listMembers) { listMember in
                HStack {
    //                Image(systemName: isChecked ? "checkmark.square": "square")
    //
    //                    .onTapGesture {
    //                    isChecked.toggle()
    //                }
                    Text("\(listMember.userName)")
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedListMember = listMember
                    areYouSureView.toggle()
                }
            }
            if areYouSureView {
                VStack {
                    
                    Text("Are you sure you want to remove \(selectedListMember?.userName ?? "") from this list?")
                        .padding()
                    HStack {
                        Spacer()
                        Button(action: {
                            listVM.removeListMemberView.toggle()
                        }, label: {
                            Text("Cancel")
                        }).padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).strokeBorder(Color.black, lineWidth: 2)
                        )
                        Spacer()
                        Button(action: {
                            guard let selectedListMember = selectedListMember else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
                            listVM.removeListMember(lm: selectedListMember)
                            listVM.removeListMemberView.toggle()
                        }) {
                            Text("Yes")
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).strokeBorder(Color.black, lineWidth: 2)
                        )
                        Spacer()
                    }.padding()
                }.overlay(
                    RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 2)
                )
            }
        }
    }
}

struct RemoveListMemberView_Previews: PreviewProvider {
    static var previews: some View {
        RemoveListMemberView()
    }
}
