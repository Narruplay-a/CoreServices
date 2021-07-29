//
//  StoreService.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 19.07.2021.
//

import SwiftUI
import Combine

open class StoreService: ObservableObject, StoreProtocol {
    @Published public var favoriteData: [Stock]    = []
    
    private var containsSet: Set<String>    = .init()
    private var cancellable: AnyCancellable?
    
    init() {
        loadFavoriteData()
        cancellable = NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
            .sink { value in
                self.saveFavoriteData()
            }
    }
    
    public func addToFavorite(_ stock: Stock) {
        favoriteData.append(stock)
        containsSet.insert(stock.symbol)
    }
    
    public func removeFromFavorite(_ offset: IndexSet) {
        favoriteData.remove(atOffsets: offset)
        containsSet = Set(favoriteData.map { $0.symbol })
    }
    
    public func isFavorite(_ symbol: String) -> Bool {
        return containsSet.contains(symbol)
    }
    
    public func saveFavoriteData() {
        let stockList = StockList(data: favoriteData)
        let payload: Data? = try? JSONEncoder().encode(stockList)
        
        UserDefaults.standard.set(payload, forKey: "favoriteData")
    }
    
    public func loadFavoriteData() {
        guard let stockData = UserDefaults.standard.data(forKey: "favoriteData") else { return }
        
        if let stockList = try? JSONDecoder().decode(StockList.self, from: stockData) {
            favoriteData = stockList.data ?? []
        }
        
        containsSet = Set(favoriteData.map { $0.symbol })
    }
}
