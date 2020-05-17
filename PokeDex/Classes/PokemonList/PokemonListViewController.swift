//
//  PokemonListViewController.swift
//  PokeDex
//
//  Created by Santiago Bustamante on 15/05/20.
//  Copyright © 2020 Santiago Bustamante. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD

class PokemonListViewController: BaseViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!

    var viewModel: PokemonListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000.0

        title = "Pokemon"

        dataBinding()

        SVProgressHUD.show()
        viewModel.getAll()

        addPullToRefresh()
    }

    func dataBinding() {
        viewModel.pokemonList.asObservable().subscribe(onNext: { [weak self] list in
            SVProgressHUD.dismiss()
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)

        viewModel.error.asObservable().subscribe(onNext: { [weak self] error in
            if let _ = error {
                SVProgressHUD.dismiss()
                let alert: UIAlertController = UIAlertController(title: "Opps!", message: "Something went wrong, try again!", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(OKAction)
                self?.present(alert, animated: true, completion: nil)
            }
        }).disposed(by: disposeBag)
    }

    var refreshControl: UIRefreshControl?
    func addPullToRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl!)
    }

    @objc func refresh(_ sender: AnyObject) {
        SVProgressHUD.show()
        viewModel.getAll()
    }
}

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemonListFiltered.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonListTableViewCell", for: indexPath) as! PokemonListTableViewCell
        let pokemon = viewModel.pokemonListFiltered[indexPath.row]
        cell.setup(pokemon: pokemon)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = viewModel.pokemonListFiltered[indexPath.row]
        viewModel.openDetail(pokemon: pokemon)
    }
}

extension PokemonListViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.query = searchText
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension PokemonListViewController {
    class func launch(viewModel: PokemonListViewModel? = nil) -> PokemonListViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PokemonListViewController") as! PokemonListViewController
        if viewModel == nil {
            vc.viewModel = PokemonListViewModel(coordinator: MainCoordinator.shared) // default init, but injectable if needed
        }
        return vc
    }
}
