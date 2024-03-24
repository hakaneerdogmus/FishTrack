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
    var label: UILabel!

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
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().multipliedBy(0.3)
            make.bottom.equalToSuperview()
        }

    }
    private func configurelabel() {
        
        let scrollView = UIScrollView(frame: .zero)
       // scrollView.backgroundColor = .red
        contentView.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        
        label = UILabel(frame: .zero)
        label.contentMode = .scaleAspectFill
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
      //  label.backgroundColor = .black
        scrollView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
