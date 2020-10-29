//
//  HomeProtocols.swift
//  FlickerSearch
//
//  Created by Rajlakshmi on 10/24/20.
//  Copyright © 2020 Rajlakshmi. All rights reserved.
//

import Foundation


protocol HomeCoordinatorProtocol: class {
    
    //MARK: HomeCoordinatorProtocol methods
    func showSearchHistory()
    func showImage(_ imageName: Image)
}


protocol HomeViewModelProtocol {
    
    //MARK: HomeViewModelProtocol methods
    
    func getNumberOfSections() -> Int
    func getPageNumber() -> Int
    func shouldLoadMoreImages() -> Bool
    func getSearchHistory()
    func getTotalNumbetOfImages() -> Int
    func loadMoreImages(for searchedText: String, pageNo: Int)
    func getImage(for searchText: String, pageNo: Int)
    func getNumberOfRowsInSection() -> Int
    func getPhotoURL(for row: Int) -> String?
    func showDetail(for indexPath: Int)
    func cleanData()
}


protocol HomeViewResultProtocol: class {
    
    // Update UI methods
       func show(_ searchResult: SearchResult)
       func showError(error: NetworkError)
}
