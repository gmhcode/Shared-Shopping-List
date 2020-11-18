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
    @Published var list : Listi
    var cancellable : AnyCancellable?
    
    init(list:Listi) {
        self.list = list
        fetchItems(by: list.uuid)
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
    
    func writeItem(name:String, store:String,userSentID:String,listID:String, uuid:String/*,completion: @escaping (Item) ->()*/) -> Future<CodableItem,Error>{
        let item = ItemController.createItem(name: name, store: store, userSentID: userSentID, listID: listID, uuid: "")
        
        return Future<CodableItem,Error> { promise in
            ItemController.BackEnd.shared.createItem(item: item) { (item) in
                guard let item = item else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<");return}
                let citem = CodableItem(listID: item.listID, store: item.store, userSentId: item.userSentId, name: item.name, uuid: item.uuid)
                DispatchQueue.main.async {
                    if self.contentDict[citem.store] == nil {
                        self.contentDict[citem.store] = [citem]
                    }else {
                        self.contentDict[citem.store]?.append(citem)
                    }
                    promise(.success(citem))
                }
            }
            
        }
        
    }
    
    func deleteItem(item: CodableItem) -> Future<Item,Error>{
        return Future<Item,Error> { promise in
            
            ItemController.BackEnd.shared.deleteItem(item: item) { [weak self] (item) in
                guard let item = item else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
                DispatchQueue.main.async { [weak self] in
                    self?.contentDict[item.store]?.removeAll(where: {$0.uuid == item.uuid})
                    if self?.contentDict[item.store]?.isEmpty == true {
                        self?.contentDict[item.store] = nil
                    }
                    promise(.success(item))
                }
            }
        }
    }
}

