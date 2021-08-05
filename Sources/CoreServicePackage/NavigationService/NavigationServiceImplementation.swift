//
//  NavigationService.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 12.07.2021.
//

import SwiftUI

open class NavigationService: ObservableObject, NavigationProtocol {
    public var navigation: NavigationModelProtocol?
    public var tabBar: NavigationTabModelProtocol?
    
    public init() { }
    
    public var selectedTab: Int {
        return tabBar?.selectedIndex ?? 0
    }
    
    public func registerTabBarView(with model: NavigationTabModelProtocol) {
        self.tabBar = model
    }

    public func registerNavigationView(with model: NavigationModelProtocol) {
        self.navigation = model
    }
    
    public func selectTab(with index: Int) {
        tabBar?.selectedIndex = index
    }
    
    public func present(view: AnyView) {
        tabBar?.present(view: view)
    }
    
    public func dismiss() {
        tabBar?.dismissPresentedView()
    }
    
    public func show(view: AnyView) {
        navigation?.push(view)
    }
    
    public func back(toRoot: Bool) {
        navigation?.pop(toRoot: toRoot)
    }
    
    public func showTabBar() {
        tabBar?.isTabBarVisible = true
    }
    
    public func hideTabBar() {
        tabBar?.isTabBarVisible = false
    }
    
    public func updateNavigation(with title: String) {
        navigation?.title = title
    }
}
