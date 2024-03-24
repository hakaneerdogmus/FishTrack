//
//  RealmManager.swift
//  FishRealm
//
//  Created by Hakan ERDOĞMUŞ on 9.03.2024.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    var models: [RealmModel] = []
    var groupedData = [String: [RealmModel]]()
    
    private init() {
        let fileURL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!)
            .appendingPathComponent("MyRealm.realm")
        
        let config = Realm.Configuration(fileURL: fileURL)
        // Diğer konfigürasyon ayarları
        
        do {
            let realm = try Realm(configuration: config)
        } catch {
            print("Realm başlatılamadı: \(error)")
        }
    }
    // Realm save
    func saveRealm(photo: Data, info: String) {
        let realm = try! Realm()
        do {
            try realm.write({
                let realmModel = RealmModel()
                // realm.deleteAll()
                realmModel.photo = photo
                realmModel.info = info
                realmModel.date = Date()
                models.insert(realmModel, at: 0)
                realm.add(models)
                print("Kayıt başarılı")
                print(models)
            })
        } catch {
            print("Kayıt hatası")
        }
    }
    //Get Realm infos
    func getRealmInfos() -> [RealmModel] {
        var realmModels: [RealmModel] = []
        do {
            let realm = try Realm()
            let results = realm.objects(RealmModel.self)
            // Results tipini döngü ile diziye çevirme
            for model in results {
                realmModels.append(model)
            }
        } catch {
            print("Realm error: \(error)")
        }
        return realmModels
    }
    //Tarihe göre gruplandırma Fonksiyonu
    func getGroupDate() -> [String] {
        var dates: [RealmModel] = []
        do {
            let realm = try Realm()
            let results = realm.objects(RealmModel.self)
            // Results tipini döngü ile diziye çevirme
            for model in results {
                dates.append(model)
            }
            print(dates.count)
        } catch {
            print("Realm error: \(error)")
        }
        // var groupedData = [String: [RealmModel]]()
        var dateArray = [String]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        for info in dates {
            let key = dateFormatter.string(from: info.date ?? Date())
            if var group = groupedData[key] {
                group.append(info)
                groupedData[key] = group
            } else {
                groupedData[key] = [info]
            }
        }
        print(groupedData.count)
        for (date, infos) in groupedData.sorted(by: { $0.key < $1.key }) {
            print("Tarih: \(date)")
            dateArray.insert(date, at: 0)
            for info in infos {
                print("- \(info.info)")
            }
        }
        return dateArray
    }
    //Delete Data
    func deleteData(realmModel: RealmModel) {
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.delete(realmModel)
            }
        } catch {
            print("Silme işleminde hata: \(error.localizedDescription)")
        }
    }
}
