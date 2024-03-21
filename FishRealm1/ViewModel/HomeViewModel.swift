//
//  HomeViewModel.swift
//  FishRealm
//
//  Created by Hakan ERDOĞMUŞ on 9.03.2024.
//

import UIKit

class HomeViewModel {
    
    private let view: HomeView?
    
    var getRealmModel: [RealmModel] = []
    
    var infoArray: [RealmModel] = []
    
    init(view: HomeView?, infoArray: [RealmModel]) {
        self.view = view
        self.infoArray = infoArray
    }
    
    func viewDidLoad() {
        view?.gradientColor(startColor: UIColor.lightGray, endColor: UIColor.blue)
        view?.configureCollectionView()
    }
    
    func viewWillAppear() {
        
    }
    
    //Get RealmData
    func getRealmData() -> [RealmModel] {
        getRealmModel = RealmManager.shared.getRealmInfos().reversed()
       // infoArray = RealmManager.shared.getRealmInfos()
        return getRealmModel
    }
    
}
