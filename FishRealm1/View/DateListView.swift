//
//  DateListView.swift
//  FishRealm
//
//  Created by Hakan ERDOĞMUŞ on 10.03.2024.
//

import UIKit
import SnapKit

class DateListView: UIViewController {
    private var viewModel: DateListViewModel!
    
    var tableView: UITableView!

    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewModel = DateListViewModel(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        tableView.reloadData()
//        viewModel.getDateArray()
        viewModel.viewWillAppear()
    }
    //Back graound Color
    func gradientColor(startColor: UIColor, endColor: UIColor) {
        let gradientLayer = Theme.gradientLayerColor(startColor: startColor, endColor: endColor)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    // Table View
    func confifureTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
       // tableView.separatorStyle = .none
       // tableView.isOpaque = true
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}

extension DateListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.dateArray[indexPath.row]
        cell.backgroundColor = .darkGray
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print("Selected info: \(viewModel.selectedDate(selectedDate: viewModel.dateArray[indexPath.row]))")
        viewModel.selectedDate(selectedDate: viewModel.dateArray[indexPath.row])
        viewModel.bottomSheet()
    }
}
