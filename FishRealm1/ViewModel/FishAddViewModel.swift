//
//  FishAddViewModel.swift
//  FishRealm
//
//  Created by Hakan ERDOĞMUŞ on 9.03.2024.
//

import UIKit
class FishAddedViewModel {
    let models = FishAddedModel()
    private let view: FishAddView?
    
    init(view: FishAddView?) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.gradientColor(startColor: UIColor.lightGray, endColor: UIColor.blue)
        view?.configureScrollView()
        view?.configureImageView()
        view?.configrePhotoTextView()
        view?.configureSavedButton()
    }
    
    func savePhotoWithInfo(image: Data, info: String) {
        RealmManager.shared.saveRealm(photo: image, info: info)
        view?.imageView.image = UIImage(systemName: "hand.tap")
        view?.photoTextView.text = ""
        view?.tabBarController?.selectedIndex = 0
        
    }
    
    // Resim sıkıştırma fonksiyonu
    func compressImage(image: UIImage?, compressionQuality: CGFloat) -> Data? {
        guard let image = image else {
            return nil
        }
        return image.jpegData(compressionQuality: compressionQuality)
    }

    
//    //Get RealmData
//    func getRealmData() -> [RealmModel] {
//        return RealmManager.shared.getRealmInfos()
//    }
}
