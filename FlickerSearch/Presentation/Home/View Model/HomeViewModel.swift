//
//  HomeViewModel.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/24/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    // MARK: Properties
    
    var coordinator: HomeCoordinatorProtocol
    weak var searchResult: HomeViewResultProtocol?
    private var dependency: DependencyProtocol
    private var imageList = [Image]()
    private  var images: Images?
    private var searchedTextList:[String]?
    private var shouldLoad:Bool = false
    
    
    // MARK: Life Cycle methods
    
    init(coordinator: HomeCoordinatorProtocol, dependency: DependencyProtocol) {
        self.coordinator = coordinator
        self.dependency = dependency
        setDataForSearchHistory()
    }
}


// MARK: HomeViewModelProtocol Methods

extension HomeViewModel: HomeViewModelProtocol {
    
    // Method to get number of rows in section
    func getNumberOfRowsInSection() -> Int {
        imageList.count
    }
    
    // Method to get url of images
    func getPhotoURL(for row: Int) -> String? {
        let image = imageList[row]
        let flickerImage = FlickerSearchAPI.flickerImage(photo: image, size: ImageSize.medium)
        return flickerImage.baseURL.absoluteString + flickerImage.path
    }
    
    // Method to show image
    func showDetail(for indexPath: Int) {
        let image = imageList[indexPath]
        coordinator.showImage(image)
    }
    
    // Method to get list of searched texts
    func getSearchHistory() {
        coordinator.showSearchHistory()
    }
    
    // Method to get number of section in a row
    func getNumberOfSections() -> Int {
        return CellDefaults.forSection
    }
    
    // Method to get number of pages
    func getPageNumber() -> Int {
        return images?.page ?? 0
    }
    
    // Method to get total number of images
    func getTotalNumbetOfImages() -> Int {
        return Int(images?.total ?? "") ?? 0
    }
    
    // Method to clean the list
    func cleanData() {
        images?.page = 0
        shouldLoad = false
        imageList.removeAll()
    }
    
    
    // Fetch data from api
    private func loadData(for searchedText: String, pageNo: Int) {
        dependency.fetchData(for: FlickerSearchAPI.photos(searchText: searchedText, pageNo: pageNo), completion: {[weak self] searchResult, error in
            guard error == nil else {
                self?.searchResult?.showError(error: NetworkError.requestError)
                return
            }
            
            guard let searchResult = searchResult else {
                self?.searchResult?.showError(error: NetworkError.requestError)
                return
            }
            self?.shouldLoad = true
            self?.images = searchResult.photos
            self?.imageList.append(contentsOf: self?.images?.photo ?? [])
            self?.searchResult?.show(searchResult)
        })
    }
    
    // Method to load more images
    func loadMoreImages(for searchedText: String, pageNo: Int) {
        
        // Check if device is connected to the internet
        guard Connectivity.isOnline() else {
            searchResult?.showError(error: NetworkError.internetError)
            return
        }
        shouldLoad = true
        loadData(for: searchedText, pageNo: pageNo)
        
    }
    
    // Method to get image for searched text and page number
    func getImage(for searchText: String, pageNo: Int) {
        guard Connectivity.isOnline() else {
            searchResult?.showError(error: NetworkError.internetError)
            return
        }
        shouldLoad = true
        saveDataToDisk(searchText)
        loadData(for: searchText, pageNo: pageNo)
    }
    
    // Method to set list of searched strings
    private func setDataForSearchHistory() {
        guard let searchHistory = FileHandler.getDataFromFile(fileName: Default.historyFileName, to: [String].self) else {
            searchedTextList = [String]()
            return
        }
        searchedTextList = searchHistory
    }
    
    
    // Method to save searched texts to persist user's serach history
    func saveDataToDisk(_ searchedText: String) {
        searchedTextList?.append(searchedText)
        _ = FileHandler.saveDataInFile(data: searchedTextList, fileName: Default.historyFileName)
    }
    
    
    // Method to check if there are more images to be loaded
    // Returns Bool
    func shouldLoadMoreImages() -> Bool {
        if getPageNumber() < getTotalNumbetOfImages() {
            return true
        } else {
            return false
        }
    }
}
