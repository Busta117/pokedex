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

    var viewControllerToPush: UIViewController {
        var viewCon: UIViewController?

        if let navigationController = navigationController, let last = navigationController.viewControllers.last {
            viewCon = last
        } else if let tabBarController = tabBarController {
            viewCon = tabBarController.selectedController
            if let navigation = viewCon as? UINavigationController, let last = navigation.viewControllers.last {
                viewCon = last
            }
        }

        return viewCon ?? UIViewController()
    }

    var viewControllerToPresent: UIViewController {
        var viewCon: UIViewController?

        if let navigationController = navigationController, let last = navigationController.viewControllers.last {
            viewCon = last
        } else if let tabBarController = tabBarController {
            viewCon = tabBarController.selectedController
            if let navigation = viewCon as? UINavigationController, let last = navigation.viewControllers.last {
                viewCon = last
            }
        }

        if let root = UIApplication.shared.keyWindow?.rootViewController {
            var top: UIViewController? = root
            while true {
                if let presented = top?.presentedViewController {
                    top = presented
                } else if let nav = top as? UINavigationController {
                    top = nav.visibleViewController
                } else if let tab = top as? UITabBarController {
                    top = tab.selectedViewController
                } else {
                    break
                }
            }
            viewCon = top
        }

        return viewCon ?? UIViewController()
    }

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

    func openDetail(pokemon: Pokemon) {
        DispatchQueue.main.async {
            let vc = PokemonDetailViewController.launch(withPokemon: pokemon)
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.viewControllerToPresent.present(nav, animated: true, completion: nil)
        }
    }
}
