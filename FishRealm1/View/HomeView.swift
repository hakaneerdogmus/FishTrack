//
//  HomeView.swift
//  FishRealm
//
//  Created by Hakan ERDOĞMUŞ on 9.03.2024.
//

import UIKit
import SnapKit

class HomeView: UIViewController {
    private var viewModel: HomeViewModel!
    private var collectionView: UICollectionView!
    
    init(infoArray: [RealmModel]) {
        super.init(nibName: nil, bundle: nil)
        viewModel = HomeViewModel(view: self, infoArray: infoArray)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    
    
    func gradientColor(startColor: UIColor, endColor: UIColor) {
        let gradientLayer = Theme.gradientLayerColor(startColor: startColor, endColor: endColor)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    //MARK: CollectionView layout cellerin gözükne ayarı
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        //CollectionView in dikey olarak scroll edilebilir olduğunu belirttik
        layout.scrollDirection = .vertical
        //Sağdan soldan üsttten alltan bırakılan boşluk ayarı
        layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 10)
        //Herbir hücre için ayar geniişilk ayarı ile yan yana 2 tane cel görünmesini ayarladık
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width  , height: UIScreen.main.bounds.width * 0.2)
        //Aradaki boşluklar Yatay yani alt alta olan cellerin mesafe boşlukları
        layout.minimumLineSpacing = 10
        return layout
    }
    //CollectionView
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeViewCell.self, forCellWithReuseIdentifier: HomeViewCell.reuseID)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview()
        }
    }
    

}

extension HomeView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.infoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewCell.reuseID, for: indexPath) as! HomeViewCell
        cell.setImage(realmModel: viewModel.infoArray[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        print("Seçilen data: \(viewModel.infoArray[indexPath.row])")
       // RealmManager.shared.deleteData(realmModel: viewModel.infoArray[indexPath.row])
        
       
    }
}
