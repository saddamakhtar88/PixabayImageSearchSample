//
//  ViewController.swift
//  ImageSearch
//
//  Created by Saddam Akhtar on 4/19/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

class ImageSearchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel: ImageSearchViewModel = ImageSearchViewModel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

         if let cell = sender as? UICollectionViewCell,
            let indexPath = self.collectionView.indexPath(for: cell) {

             let detailViewController = segue.destination as! ImageDetailViewController
            detailViewController.image = viewModel.images[indexPath.row]
         }
    }
    
    func initialize() {
        viewModel.onResultChange = { [weak self] (result) in
            self?.collectionView.reloadData();
        }
        
        viewModel.onError = { (action, error) in
            // Show error
        }
        
        let searchKeyword = "apple"
        searchBar.text = searchKeyword
        viewModel.searchText = searchKeyword
    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard searchBar.text?.isEmpty == false else {
            return
        }
        viewModel.searchText = searchBar.text!
        // Loading Indicator
    }
}
 
extension ImageSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageSearchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchresultcell", for: indexPath) as! ImageSearchResultCollectionViewCell
        
        let imageViewModel = ImageSearchResultViewModel(image: viewModel.images[indexPath.row])
        imageSearchCell.configureWithData(data: imageViewModel)
        
        return imageSearchCell
    }
}

extension ImageSearchViewController: UICollectionViewDelegate {
    
}