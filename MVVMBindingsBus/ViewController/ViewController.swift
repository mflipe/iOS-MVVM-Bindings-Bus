//
//  ViewController.swift
//  MVVMBindingsBus
//
//  Created by MacMini-8G on 10/07/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    private var viewModel = UserListViewModel()
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        
        Bus.shared.subscribeOnMain(.userFetch) { [weak self] event in
            
            guard let result = event.result else {
                return
            }
            
            switch result {
            case .success(let users):
                self?.viewModel.users = users
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        viewModel.fetchUserList()
    }

    // Table
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = viewModel.users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
}

