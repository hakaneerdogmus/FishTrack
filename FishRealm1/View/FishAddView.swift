//
//  ViewController.swift
//  FishRealm
//
//  Created by Hakan ERDOĞMUŞ on 9.03.2024.
//

import UIKit
import SnapKit

class FishAddView: UIViewController {

    private var viewModel: FishAddedViewModel!
    
    private var saveButton: UIButton!
    var imageView: UIImageView!
    var photoTextView: UITextView!
    private var scrollView: UIScrollView!

    init() {
        super.init(nibName: nil, bundle: nil)
        viewModel = FishAddedViewModel(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    // UITapGestureRecognizer tarafından çağrılacak fonksiyon
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Back graound Color
    func gradientColor(startColor: UIColor, endColor: UIColor) {
        let gradientLayer = Theme.gradientLayerColor(startColor: startColor, endColor: endColor)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    //Scroll View
    func configureScrollView() {
        scrollView = UIScrollView(frame: .zero)
        //scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    //Photo Button
    func configureImageView() {
        imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "hand.tap")
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped)))
       // imageView.backgroundColor = .red
      //  imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        scrollView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.safeAreaLayoutGuide).offset(Theme.topOffset10)
            make.leading.equalTo(Theme.leadingOffset)
            make.width.height.equalTo(100)
        }
    }
  
    //Photo Text Field
    func configrePhotoTextView() {
        photoTextView = UITextView(frame: .zero)
       // photoTextView.backgroundColor = .gray
        photoTextView.font = UIFont.systemFont(ofSize: 16)
        photoTextView.layer.borderWidth = 1
        photoTextView.layer.borderColor = UIColor.lightGray.cgColor
        photoTextView.layer.cornerRadius = 8
        photoTextView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        photoTextView.isScrollEnabled = true
        photoTextView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(photoTextView)
        
        photoTextView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.safeAreaLayoutGuide).offset(Theme.topOffset10)
            make.leading.equalTo(imageView.snp.trailing).offset(20)
            make.height.equalTo(imageView.snp.height)
            make.width.equalTo(225)
            make.bottom.equalToSuperview()
        }
    }
    //Selected Photo tapped
    @objc func imageViewTapped() {
            presentImagePicker()
    }
    //Saved Button
    func configureSavedButton() {
        saveButton = UIButton(type: .system)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(UIColor.white, for: .normal)
        saveButton.backgroundColor = .blue
        saveButton.layer.cornerRadius = Theme.buttonCornerRadius
        saveButton.titleLabel?.font = Theme.buttonTittleFont
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        scrollView.addSubview(saveButton)
        
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.top.equalTo(photoTextView.snp.bottom).offset(Theme.topOffset50)
            make.centerX.equalToSuperview()
        }
    }
    //Save button tapped
    @objc func saveButtonTapped() {
        guard let info = photoTextView.text else {
            print("İnfo bilgisi hatalı")
            return
        }
        if let compressedImageData = viewModel.compressImage(image: imageView.image, compressionQuality: 0.5) {
                // viewModel.savePhotoWithInfo metoduna sıkıştırılmış veriyi iletiyoruz
                viewModel.savePhotoWithInfo(image: compressedImageData, info: info)
            } else {
                print("Resim sıkıştırma hatası")
            }
        

        //viewModel.savePhotoWithInfo(image:imageData , info: info)
    }
    
}

extension FishAddView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentImagePicker() {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }

        // UIImagePickerControllerDelegate yöntemleri
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[.originalImage] as? UIImage {
                // Seçilen veya çekilen fotoğrafı imageView'e yerleştirin
                imageView.image = pickedImage
                imageView.contentMode = .scaleAspectFill
            }

            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
}




