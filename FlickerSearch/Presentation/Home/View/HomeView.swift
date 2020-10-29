//
//  HomeView.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/25/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import UIKit


class HomeView: UICollectionViewController, AlertProtocol {
    
    // MARK: Properties
    var viewModel: HomeViewModelProtocol?
    var searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearch()
        
        // Set title
        self.title = Title.home
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: Title.history, style: .done, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped(sender: UIBarButtonItem) {
        viewModel?.getSearchHistory()
    }
    
    // Configure Search View Controller
    private func configureSearch() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Title.searchText
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
    
    
    // MARK: - Helper Method
    @objc func loadMorePhotos() {
        guard let searchText = searchController.searchBar.text, searchText.count > 0 else {
            return
        }
        
        // Check if there are more images available to be loaded
        if viewModel?.shouldLoadMoreImages() ?? false {
            viewModel?.loadMoreImages(for: searchText, pageNo: (viewModel?.getPageNumber() ?? 0) + Default.pageNo)
        }
    }

    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel?.getNumberOfSections() ?? 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRowsInSection() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.collectionCell, for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        
        let url = viewModel?.getPhotoURL(for: indexPath.row)
        cell.configure(with: url)
        return cell
        
    }
    
    // Load more photos if required
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let lastIndex = collectionView.numberOfItems(inSection: 0) - CellDefaults.forSection
        if indexPath.row == lastIndex && viewModel?.getPageNumber() != 0 {
            
            DispatchQueue.main.async {
                self.loadMorePhotos()
                
            }            
        }
        
        guard let image = viewModel?.getPhotoURL(for: indexPath.row) else {return}
        guard let cell = cell as? ImageCell else {return}
        cell.configure(with: image)
    }
    
    // Row selected delegate method
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.showDetail(for: indexPath.row)
    }
    
}

//MARK: Search Bar Delegates
extension HomeView: UISearchBarDelegate{
    
    // To capture searched Text
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        guard let searhedText = searchController.searchBar.text, searhedText != "" else {return}
        viewModel?.getImage(for: searhedText, pageNo: (viewModel?.getPageNumber() ?? 0) + Default.pageNo )
    }
    
    
    // To capture the cancel event of search bar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearData()
    }
    
    
    // To clear search bar on close button click
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if  searchText.count == 0 {
            clearData()
        }
    }
    
    
    // Clear data from view
    private func clearData() {
        viewModel?.cleanData()
        collectionView.reloadData()
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension HomeView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = CollectionItem.spacing * (CollectionItem.itemsPerRow + 1.0)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / CollectionItem.itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return CollectionItem.insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionItem.spacing
    }
    
}


// MARK: Display Logic
extension HomeView: HomeViewResultProtocol {
    
    // Method to Update UI
    func show(_ searchResult: SearchResult) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
    // Method to show error popup
    func showError(error: NetworkError) {
        showPopup(title: ErrorMsg.errorTitle, message: error.errorDescription, okTitle: ErrorMsg.ok, cancelTitle: nil, response: nil)
    }
    
    
}
