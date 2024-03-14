//
//  PersonTableViewCell.swift
//  AsyncImageLoadInTableViewCell
//
//  Created by Avnish Kumar on 13/03/24.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    static let reusableIdentifier = "PersonTableViewCell"
    var downloadTaskId: UUID?
    
    let iconView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.blue.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var person: Person? {
        didSet {
            guard let person = person else { return }
            self.downloadTaskId = self.iconView.load(string: person.imageURL)
            titleLabel.text = person.name
            subTitleLabel.text = person.emailId
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) called")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.cancelDownloading(uuid: downloadTaskId)
    }
    
    func addSubViews() {
        
        self.addSubview(iconView)
        self.addConstraints([
            self.iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            self.iconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.iconView.widthAnchor.constraint(equalToConstant: 50),
            self.iconView.heightAnchor.constraint(equalTo: self.iconView.widthAnchor, multiplier: 1)
        ])
        
        self.addSubview(titleLabel)
        self.addConstraints([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.iconView.trailingAnchor, constant: 8),
            self.titleLabel.topAnchor.constraint(equalTo: self.iconView.topAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])

        self.addSubview(subTitleLabel)
        self.addConstraints([
            self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
            self.subTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
}
