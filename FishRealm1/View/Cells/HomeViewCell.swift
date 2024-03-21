//
//  HomeViewCell.swift
//  FishRealm
//
//  Created by Hakan ERDOĞMUŞ on 9.03.2024.
//

import UIKit
import SnapKit

class HomeViewCell: UICollectionViewCell {
    static let reuseID = "HomeViewCell"
    
    var imageView: UIImageView!
    var label: UITextView!

        override init(frame: CGRect) {
            super.init(frame: frame)
            configureCell()
            configureImageView()
            configurelabel()
        }
    
    override func prepareForReuse() {
        imageView.image = nil
        label.text = nil
    }
    
    private func configureCell() {
        backgroundColor = .systemGray3
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    func setImage(realmModel: RealmModel) {
        imageView.image = UIImage(data: realmModel.photo!)
        label.text = realmModel.info
    }
    
    private func configureImageView() {
        imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        contentView.addSubview(imageView)
        
        // SnapKit ile kontraint'leri belirle
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalToSuperview()
        }

    }
    private func configurelabel() {
        label = UITextView(frame: .zero)
        label.contentMode = .scaleAspectFill
        label.clipsToBounds = true
        label.backgroundColor = .black
       // label.text = "asdasdasdasdaasdasdasdasdasdadasdasdaasdasdasdasdaasdasdasdasdasdadasdasdaasdasdasdasdaasdasdasdasdasdadasdasdaasdasdasdasdaasdasdasdasdasdadasdasdaasdasdasdasdaasdasdasdasdasdadasdasdaasdasdasdasdaasdasdasdasdasdadasdasdaasdasdasdasdaasdasdasdasdasdadasdasdaasdasdasdasdaasdasdasdasdasdadasdasdaasdasdasdasdaasdasdasdasdasdadasdasdaasdasdasdasdaasdasdasdasdasdadasdasdaasdasdasdasdaasdasdasdasdasdadasdasdaasdasdasdasdaasdasdasdasdasdadasdasdaasdasdasdasdaasdasdasdasdasdadasdasda"
        contentView.addSubview(label)
        
        // SnapKit ile kontraint'leri belirle
        label.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
