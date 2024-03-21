//
//  TabBarController.swift
//  FishRealm
//
//  Created by Hakan ERDOĞMUŞ on 9.03.2024.
//

import UIKit

class TabBarController: UITabBarController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTabs()
        //self.selectedIndex = 1
        self.tabBar.backgroundColor = .gray
        self.tabBar.tintColor = .blue
        self.tabBar.unselectedItemTintColor = .black
        navigationItem.hidesBackButton = true
        
        
    }
    //MARK: Tab Setup
    private func setupTabs() {
        let dateListView = self.createNavigation(title: "Date Fish", image: UIImage(systemName: "calendar.circle"), selectedImage: UIImage(systemName: "calendar.circle.fill"), vc: DateListView())
        let fishAddedView = self.createNavigation(title: "Add Fish", image: UIImage(systemName: "fish.circle"), selectedImage: UIImage(systemName: "fish.circle.fill"), vc: FishAddView())
      //  let homeView = self.createNavigation(title: "Home", image: UIImage(systemName: "house.circle"), selectedImage: UIImage(systemName: "house.circle.fill"), vc: HomeView())

        self.setViewControllers([dateListView, fishAddedView], animated: true)
        
    }
    
    private func createNavigation(title: String, image: UIImage?, selectedImage: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.tabBarItem.selectedImage = selectedImage
       // nav.viewControllers.first?.navigationItem.title = title + " Controller"
       // nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Button", style: .plain, target: nil, action: nil)
        return nav
    }
}
