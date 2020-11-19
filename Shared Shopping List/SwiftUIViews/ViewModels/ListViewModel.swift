//
//  ListViewModel.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 10/30/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation
import Combine

class ListViewModel: ObservableObject {
    @Published var lists = [CodableList]()
    @Published var createListView = false
    var cancellable : AnyCancellable?

    init() {
        fetchLists()
    }
    
    func fetchLists() {
        
        let url = URL(string: "http://localhost:8081/lists")!

        
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .receive(on: RunLoop.main)
            .decode(type: [CodableList].self, decoder: JSONDecoder())
            .mapError({ (er) -> Error in
                print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                return er
            })
            .catch{_ in Just([])}
            .sink(receiveCompletion: {_ in}, receiveValue: { list in
                self.lists = list
            })
//            .mapError({ error in
//                print(error)
//                
//            })
//            .receive(on: RunLoop.main)
//            .sink(receiveCompletion: {_ in}, receiveValue: { list in
//                self.lists = list
//            })
//            .receive(on: RunLoop.main)
//            .eraseToAnyPublisher()
//            .sink(receiveCompletion: {_ in}, receiveValue: {
//                self.lists = $0
//            })
//        URLSession.shared.dataTask(with: url) { (data, res, er) in
//            do {
//                let jsonDecoder = JSONDecoder()
//                let lists = try jsonDecoder.decode([Listi].self, from: data!)
//                print(lists)
//                self.lists = lists
//            }catch let er{
//
//                print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
//            }
//        }.resume()
//        let blah = createList(uuid: "", title: "", listMasterID: "")
//        blah.sink
    }
    func createList(uuid: String, title: String, listMasterID: String) {
        let list = ListController.createList(title: title, listMasterID: listMasterID, uuid: uuid)
        cancellable = Future<CodableList,Error> { promise in
            ListController.BackEnd.shared.createCodableList(list: list) { (cList) in
                guard let list = cList else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
                
                promise(.success(list))
            }
        }.sink(receiveCompletion: {_ in}) { (list) in
            DispatchQueue.main.async {
                self.lists.append(list)
            }
            
        }
    }
}

