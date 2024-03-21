//
//  DateListViewModel.swift
//  FishRealm
//
//  Created by Hakan ERDOĞMUŞ on 10.03.2024.
//

import Foundation
import UIKit

class DateListViewModel {
    private let view: DateListView?
    
    var dates: [Date] = []
    var dateArray = [String]()
    var infoArray = [RealmModel]()

    init(view: DateListView?) {
        self.view = view
    }
    
    func viewDidLoad() {
       // view?.view.backgroundColor = .red
        view?.gradientColor(startColor: UIColor.lightGray, endColor: UIColor.blue)
        view?.confifureTableView()
       // view?.view.backgroundColor = .gray
        view?.tabBarController?.navigationController?.navigationBar.isTranslucent = false
        view?.tabBarController?.navigationController?.navigationBar.isHidden = true
      //  getDateArray()
    }
    func viewWillAppear() {
        view?.tableView.reloadData()
        getDateArray()
    }
    //Seçilen tarih içindeki bilgileri çektik
    func selectedDate(selectedDate: String) -> [RealmModel] {
        var groupDate = RealmManager.shared.groupedData
        //infoArray = [RealmModel]()
        if let selectedDate = groupDate[selectedDate] {
            print("Seçilen tarih: \(selectedDate)")
            infoArray = []
            for info in selectedDate {
              //  print("- \(info.info)")
                infoArray.insert(info, at: 0)
            }
        }
        return infoArray
    }
    //Date Array
    func getDateArray() {
        dateArray = RealmManager.shared.getGroupDate()
        //return dateArray
    }
    
    //Bottom Sheet açılacak sayfa
    func bottomSheet() {
        let bottomSheetVC = HomeView(infoArray: infoArray)
        view?.present(bottomSheetVC, animated: true)
        
    }
    

}
