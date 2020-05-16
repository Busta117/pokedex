//
//  MainCoordinator.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 15/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import UIKit
import SVProgressHUD

class MainCoordinator {
    static let shared = MainCoordinator()

    fileprivate weak var window: UIWindow?
    var navigationController: UINavigationController?
    var tabBarController: BaseTabBarController?

    func start(window: UIWindow?) {
        self.window = window

        if navigationController == nil {
            let launchScreen = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
            let navigation = UINavigationController(rootViewController: launchScreen)
            navigation.setNavigationBarHidden(true, animated: false)
            self.window?.rootViewController = navigation
            navigationController = navigation
        }

        loadHome()
    }

    fileprivate func loadHome() {
        navigationController = nil

        let pokemonTab = UINavigationController(rootViewController: PokemonListViewController.launch())
        pokemonTab.tabBarItem.title = "Pokemon"
        pokemonTab.tabBarItem.image = UIImage(named: "tabbar_pokemon")

        let moviesTab = UINavigationController(rootViewController: UIViewController())
        moviesTab.tabBarItem.title = "Movies"
        moviesTab.tabBarItem.image = UIImage(named: "tabbar_movies")

        let itemsTab = UINavigationController(rootViewController: UIViewController())
        itemsTab.tabBarItem.title = "Items"
        itemsTab.tabBarItem.image = UIImage(named: "tabbar_items")

        // let's setup tabbar
        let tabBar = BaseTabBarController()
        tabBarController = tabBar
        tabBarController?.setViewControllers([pokemonTab, moviesTab, itemsTab], animated: true)

        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }
}
