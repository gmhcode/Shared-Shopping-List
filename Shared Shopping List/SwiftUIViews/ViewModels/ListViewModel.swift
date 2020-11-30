//
//  ListViewModel.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 10/30/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation
import Combine
//Global
let listViewModel = ListViewModel()
class ListViewModel: ObservableObject {

    @Published var showCreateListView = false
    @Published var showDeleteListView = false
    @Published var showJoinListView = false
    @Published var removeListMemberView = false
    @Published var mostRecentList : CodableList?
    @Published var listAndItemsAndListMembers = ListAndItemsAndListMembers(lists: [], items: [], listMembers: [])
    var cancellable : AnyCancellable?

    init() {
        fetchLists()
    }
    ///Fetches the list for the main user
//    func fetchAllLists() {
//        let url = URL(string: "http://localhost:8081/lists")!
//
//
//        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .receive(on: RunLoop.main)
//            .decode(type: [CodableList].self, decoder: JSONDecoder())
//            .mapError({ (er) -> Error in
//                print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
//                return er
//            })
//            .catch{_ in Just([])}
//            .sink(receiveCompletion: {_ in}, receiveValue: { list in
//                if list.count > 0 {
//                    self.lists = list
//                    if self.mostRecentList == nil {
//                        self.mostRecentList = self.lists[0]
//                    }
//                }
//            })
//    }
    func fetchLists() {
        
        let url = URL(string: "http://localhost:8081/lists/query?userID=\(mainUser.uuid)")!

        
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .receive(on: RunLoop.main)
            .decode(type: ListAndItemsAndListMembers.self, decoder: JSONDecoder())
            .mapError({ (er) -> Error in
                print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                return er
            })
            .catch{_ in Just(ListAndItemsAndListMembers(lists: [], items: [], listMembers: []))}
            .sink(receiveCompletion: {_ in}, receiveValue: { listAndItemsAndListMembers in
//                if self.listAndItemsAndListMembers.Lists.count > 0 {
                    self.listAndItemsAndListMembers = listAndItemsAndListMembers
                    if self.mostRecentList == nil {
                        if listAndItemsAndListMembers.lists.count > 0 {
                            self.mostRecentList = self.listAndItemsAndListMembers.lists[0]
                        }
                       
                    }
//                }
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
                self.listAndItemsAndListMembers.lists.append(list)
            }
            
        }
    }
    
    func countListItems(list: CodableList) -> Int{
        var matchingItemCount = listAndItemsAndListMembers.items.filter({$0.listID == list.uuid}).count
        return matchingItemCount
    }
    
    func deleteList(list:CodableList) {
        print("💥",list.title)
        ListController.BackEnd.shared.deleteCodableList(list: list) { [weak self] (list) in
            DispatchQueue.main.async {
                guard let strongSelf = self else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
                strongSelf.listAndItemsAndListMembers.lists.removeAll(where: {$0.uuid == list.uuid})
                strongSelf.mostRecentList = strongSelf.listAndItemsAndListMembers.lists[0]
            }
        }
    }
    
    func setMostRecentList(list: CodableList) {
        mostRecentList = list
    }

    private func addUserToList(newUserID: String, list:CodableList, userName:String) {
        ListMemberController.BackEnd.shared.createCodableListMember(listID: list.uuid, userID: newUserID, userName: userName) {[weak self] (listMember) in
            print("🌎 ", listMember.userID)
            DispatchQueue.main.async {
                self?.listAndItemsAndListMembers.lists.append(list)
//                self?.listAndItemsAndListMembers.listMembers.append(listMember)
            }
        }
    }
    //THIS IS WORKING BUT WHEN fetchLists() IS CALLED AT CONTENTVIEWS INIT.. THE FETCH LIST ISNT CORRECTLY FETCHING THIS LIST.
    func joinList(joinerPassword: String) {
        ListController.BackEnd.shared.findListToJoin(joinerPassword: joinerPassword) { (list) in
            self.addUserToList(newUserID: mainUser.uuid, list: list, userName: mainUser.name)
        }
    }
}

struct ListAndItemsAndListMembers: Codable {
    var lists : [CodableList]
    var items : [CodableItem]
    var listMembers : [CodableListMember]
    
    enum CodingKeys:String,CodingKey {
           case lists = "Lists"
           case items = "Items"
           case listMembers = "ListMembers"
       }
}
