//
//  View.swift
//  ViperDemo
//
//  Created by Dhruv Ukani on 21/10/23.
//

import Foundation
import UIKit

//  MARK: - View Protocol
protocol AnyView {
    var presenter: AnyPresenter? {get set}
    
    func update(with contacts: ContactList)
    func update(with error: String)
}

//  MARK: - ContactViewController
class ContactViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    
    private var contacts: ContactList?
    
    private let tableview: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        view.addSubview(tableview)
        tableview.dataSource = self
        tableview.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    
    func update(with contacts: ContactList) {
        DispatchQueue.main.async {
            self.contacts = contacts
            self.tableview.reloadData()
            self.tableview.isHidden = false
        }
    }
    
    func update(with error: String) {
        print("update error called in view")
    }
}

//  MARK: - UITableViewDataSource
extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts?.documents.count ??  0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(contacts?.documents[indexPath.row].firstName ?? "") \(contacts?.documents[indexPath.row].lastName ?? "")" 
        return cell
    }
    
    
}
// MARK: - UITableViewDelegate
extension ContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
