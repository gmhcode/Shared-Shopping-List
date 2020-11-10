//
//  ListDetailViewModel.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 11/9/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
class ListDetailViewModel : ObservableObject {
    
    @Published var items: [CodableItem] = []
    @Published var contentDict : [String:[CodableItem]] = [:]
    var cancellable : AnyCancellable?
    
    init(listID:String) {
        fetchItems(by: listID)
        
    }
    
    
    func fetchItems(by iD: String) {
        let url = URL(string: "http://localhost:8081/items/query?userID=&listID=\(iD)")!
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .receive(on: RunLoop.main)
            .decode(type: [CodableItem].self, decoder: JSONDecoder())
            .mapError({ (er) -> Error in
                print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                return er
            })
            .catch{_ in Just([])}
            .sink(receiveCompletion: {_ in}, receiveValue: { items in
                //                self.items = items
                for item in items {
                    if self.contentDict[item.store] == nil {
                        self.contentDict[item.store] = [item]
                    }else {
                        self.contentDict[item.store]?.append(item)
                    }
                }
                print(items.count)
            })
    }
}

