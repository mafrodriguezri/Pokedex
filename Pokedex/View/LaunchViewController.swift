//
//  LaunchViewController.swift
//  Pokedex
//
//  Created by Manuel on 4/7/20.
//  Copyright © 2020 ManuelRR. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    let pokemonTypesViewModel = PokemonTypesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonTypesViewModel.delegate = self
        pokemonTypesViewModel.getPokemonTypes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentList()
    }
    
    func presentList() {
        if pokemonTypesViewModel.pokemonTypesArray.count == 18 {
            let pokemonListViewController = PokemonListViewController(nibName: "PokemonListViewController", bundle: nil)
            pokemonListViewController.modalPresentationStyle = .fullScreen
            pokemonListViewController.pokemonTypesViewModel = pokemonTypesViewModel
            self.present(pokemonListViewController, animated: true)
        }
    }
}
//MARK: - viewModel delegate methods
extension LaunchViewController : PokemonTypesViewModelDelegate {
    
    func successGetPokemonTypes() {
        presentList()
        print("success saving 18 pokemon types")
    }
    
    func failureGetPokemonTypes() {
        print("failure saving 18 pokemon types")
    }
}
