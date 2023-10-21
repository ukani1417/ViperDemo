//
//  Interactor.swift
//  ViperDemo
//
//  Created by Dhruv Ukani on 21/10/23.
//

import Foundation

//  MARK: - Interactor Protocol
protocol AnyInteractor {
    var presenter: AnyPresenter? {get set}
    
    func getUsers()
}

// MARK: - ContactInteractor
class ContactInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = Constants.Host
        components.path = Constants.Path
        var request = URLRequest(url: components.url!)
        request.setValue(Constants.ApiKey, forHTTPHeaderField: "X-Appwrite-Key")
        request.setValue(Constants.ProjectKey, forHTTPHeaderField: "X-Appwrite-Project")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, responce, error in
            guard let list = data , error == nil else {
                print(error?.localizedDescription ?? "")
                self?.presenter?.interactorDidFetchContacts(with: .failure(.failed))
                return
            }
            
            guard (responce as! HTTPURLResponse).statusCode == 200 else {
                self?.presenter?.interactorDidFetchContacts(with: .failure(.failed))
                return
            }
            
           
            let decoder = JSONDecoder()
            
            do {
                let ress = try decoder.decode(ContactList.self, from: list)
                self?.presenter?.interactorDidFetchContacts(with: .success(ress))
            } catch {
                print("error: ", error)
                debugPrint(error.localizedDescription)
                self?.presenter?.interactorDidFetchContacts(with: .failure(.failed))
            }
            
        }
        task.resume()
    }
    
    
}
