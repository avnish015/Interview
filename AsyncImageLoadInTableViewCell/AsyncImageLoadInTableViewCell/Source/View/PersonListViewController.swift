//
//  ViewController.swift
//  AsyncImageLoadInTableViewCell
//
//  Created by Avnish Kumar on 13/03/24.
//

import UIKit

class PersonListViewController: UIViewController {
    
    let persons = Person.persons
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.reusableIdentifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Person List"
        self.addViews()
    }

    func addViews() {
        self.view.addSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addConstraints([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension PersonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.reusableIdentifier, for: indexPath) as? PersonTableViewCell else {
            return UITableViewCell()
        }
        cell.person = persons[indexPath.row]
        return cell
    }
    
    
    
    
}

