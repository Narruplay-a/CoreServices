//
//  NavigationServiceProtocols.swift
//  HomeWork2
//
//  Created by Adel Khaziakhmetov on 29.07.2021.
//

import SwiftUI

public protocol NavigationTabModelProtocol {
    var isTabBarVisible: Bool { get set }
    var selectedIndex: Int { get set }
    
    func present(view: AnyView)
    func dismissPresentedView()
}

public protocol NavigationModelProtocol {
    var title: String { get set }
    
    func push<S: View>(_ screenView: S)
    func pop(toRoot: Bool)
}

public protocol NavigationRegisterProtocol {
    func registerTabBarView(with model: NavigationTabModelProtocol)
    func registerNavigationView(with model: NavigationModelProtocol)
}

public protocol NavigationControlProtocol {
    var selectedTab: Int { get }
    
    func selectTab(with index: Int)
    func present(view: AnyView)
    func dismiss()
    func show(view: AnyView)
    func back(toRoot: Bool)
    func showTabBar()
    func hideTabBar()
    func updateNavigation(with title: String)
}

public protocol NavigationProtocol: NavigationRegisterProtocol, NavigationControlProtocol { }

public enum PopDestination {
    case previous
    case root
}
