//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Manuel on 4/7/20.
//  Copyright © 2020 ManuelRR. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController {

    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonListTableView: UITableView!
    @IBOutlet weak var tableViewActivityIndicator: UIActivityIndicatorView!
    
    let pokemonListViewModel = PokemonListViewModel()
    var pokemonTypesViewModel = PokemonTypesViewModel()
    var pokemonCompleteList : [ListPokemonEntity] = []
    var successGettingPageInfo = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonListViewModel.delegate = self
        pokemonListViewModel.page = 0
        showActivityIndicator(true)
        pokemonTableViewSetUp()
        pokemonSearchBar.delegate = self
        pokemonSearchBar.isUserInteractionEnabled = false
    }
//MARK: - set delegate and data source for tableView
    func pokemonTableViewSetUp() {
        pokemonListTableView.isHidden = true
        pokemonListTableView.rowHeight = 75
        pokemonListTableView.delegate = self
        pokemonListTableView.dataSource = self
        pokemonListTableView.register(UINib(nibName: PokemonTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PokemonTableViewCell.identifier)
    }
}
//MARK: - TableView delegate and dataSource methods
extension PokemonListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonListViewModel.pokemonListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemonCell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }
        pokemonCell.pokemonName = pokemonListViewModel.pokemonListArray[indexPath.row].name ?? ""
        pokemonCell.pokemonId = pokemonListViewModel.pokemonListArray[indexPath.row].idNumber ?? 0
        pokemonCell.firstType = pokemonTypesViewModel.pokemonWithType.filter{$0.pokemonName == pokemonCell.pokemonName && $0.typeSlot == 1}.map{$0.typeName ?? ""}.first ?? ""
        pokemonCell.secondType = pokemonTypesViewModel.pokemonWithType.filter{$0.pokemonName == pokemonCell.pokemonName && $0.typeSlot == 2}.map{$0.typeName ?? ""}.first ?? ""
        pokemonCell.setPokemonCellData()
        return pokemonCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let pokemonDetailViewController = PokemonDetailViewController(nibName: "PokemonDetailViewController", bundle: nil)
        pokemonDetailViewController.modalPresentationStyle = .fullScreen
        if let pokemonCell = tableView.cellForRow(at: indexPath) as? PokemonTableViewCell {
            pokemonDetailViewController.pokemonId = pokemonCell.pokemonId
            pokemonDetailViewController.firstTypeData = pokemonTypesViewModel.pokemonTypesArray.filter{$0.name == pokemonCell.firstType}.first
            pokemonDetailViewController.secondTypeData = pokemonTypesViewModel.pokemonTypesArray.filter{$0.name == pokemonCell.secondType}.first
            self.present(pokemonDetailViewController, animated: true)
        }
    }
    //used for making list api request by page
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if pokemonListViewModel.pokemonListArray.count < 807 {
//            showActivityIndicator(true)
//            pokemonListViewModel.page = successGettingPageInfo ? pokemonListViewModel.page + 1 : pokemonListViewModel.page
//        }
//    }
    
    func showActivityIndicator(_ boolean: Bool){
        tableViewActivityIndicator.isHidden = !boolean
        _ = boolean ? tableViewActivityIndicator.startAnimating() : tableViewActivityIndicator.stopAnimating()
    }
}
//MARK: - searchBar delegate methods
extension PokemonListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            pokemonListViewModel.pokemonListArray = pokemonCompleteList.filter { (listPokemon) -> Bool in
                guard let pokemonName = listPokemon.name else { return false }
                return pokemonName.localizedCaseInsensitiveContains(searchText)
            }
            pokemonListTableView.reloadData()
        }
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text, searchText.count == 0 {
            pokemonListViewModel.pokemonListArray = pokemonCompleteList
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.pokemonListTableView.reloadData()
            }
        }
    }
}
//MARK: - viewModel delegate methods
extension PokemonListViewController : PokemonListViewModelDelegate {
    
    func successGetPokemonList() {
        successGettingPageInfo = true
        pokemonListTableView.isHidden = false
        pokemonCompleteList = pokemonListViewModel.pokemonListArray
        pokemonListTableView.reloadData()
        pokemonSearchBar.isUserInteractionEnabled = true
        showActivityIndicator(false)
        print("success getting pokemon list for page \(pokemonListViewModel.page)")
    }
    
    func failureGetPokemonList() {
        successGettingPageInfo = false
        showActivityIndicator(false)
        print("failure getting pokemon list for page")
    }
}
