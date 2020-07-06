//
//  ViewController.swift
//  Shared Shopping List
//
//  Created by Greg Hughes on 6/30/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    struct MainViewModel {
        var collectionViewDataSource = [1,2,3,4,5,6,7,8,9]
        var listTypes = ["Shopping Lists"]
        ///Datasource
        var lists : [List] = [List(title: "Home List", listMaster: "Person"),List(title: "Home List", listMaster: "Person"),List(title: "Home List", listMaster: "Person"),List(title: "Home List", listMaster: "Person"),List(title: "Home List", listMaster: "Person"),List(title: "Home List", listMaster: "Person"),List(title: "Home List", listMaster: "Person")]
    }
    var mainViewModel : MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewModel()
        setupCollectionView()
        
    }
    
    func setViewModel() {
        mainViewModel = MainViewModel()
    }
    func setupCollectionView(){
        ///Makes the collectionView headers sticky
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let mainViewModel = mainViewModel else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return 0 }
        
        return mainViewModel.lists.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MainCollectionViewCell
        
        cell?.shoppingListTitle = mainViewModel?.lists[indexPath.row].title
        
        cell?.layer.borderWidth = 1
        
        return cell ?? UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "listTypeHeaderView", for: indexPath) as? SectionHeaderView,
            let mainViewModel = mainViewModel else { return UICollectionReusableView() }
        
        sectionHeaderView.listType = mainViewModel.listTypes[indexPath.section]
        
        return sectionHeaderView
    }
    
}
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
}
