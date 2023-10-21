//
//  Router.swift
//  ViperDemo
//
//  Created by Dhruv Ukani on 21/10/23.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

//  MARK: - Router Protocol
protocol AnyRouter {
    var entry: EntryPoint? { get }
    static func start() -> AnyRouter
}

// MARK: - ContactRouter
class ContactRouter: AnyRouter {
    var entry: EntryPoint?
    
    
    static func start() -> AnyRouter {
        let router = ContactRouter()
        
//        Assign VIP
        var view: AnyView = ContactViewController()
        var presenter: AnyPresenter = ContactPresenter()
        var interactor: AnyInteractor = ContactInteractor()

//        View has reference of presenter
        view.presenter = presenter
        
//       Interactor has reference to presenter
        interactor.presenter = presenter
        
//        Presenter has reference of view, interactor and router
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        
//        Router has refernce of view which set entrypoint
        router.entry = view as? EntryPoint
        return router
    }
    
    
}
