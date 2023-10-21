//
//  Presentator.swift
//  ViperDemo
//
//  Created by Dhruv Ukani on 21/10/23.
//

import Foundation

// MARK: - Presenter Errors
enum fetchError: Error {
    case failed
}

// MARK: - Presenter Protocol
protocol AnyPresenter {
    var router: AnyRouter? {get set}
    var interactor: AnyInteractor? {get set}
    var view: AnyView? {get set}
    
    func interactorDidFetchContacts(with result: Result<ContactList,fetchError>)
}

// MARK: - ContactPresenter
class ContactPresenter: AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    
    var view: AnyView?
    
    func interactorDidFetchContacts(with result: Result<ContactList, fetchError>) {
        switch result {
        case .success(let contactList):
            view?.update(with: contactList)
        case .failure:
            view?.update(with: "try again after some time")
        }
    }

}
