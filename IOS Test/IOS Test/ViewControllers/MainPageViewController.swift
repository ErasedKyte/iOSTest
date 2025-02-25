//
//  MainPageViewController	.swift
//  IOS Test
//
//  Created by Temp on 25/02/2025.
//

import UIKit
import SwiftUI

class MainPageViewController: UIViewController {
    private let stickyThreshold: CGFloat = 300
    private var filteredItems: [Item] = []
    // MARK: - added all these values to test the functionality
    private var items: [Item] = [
        Item(imageName: "image", title: "apple", description: "this is an apple"),
        Item(imageName: "image", title: "banana", description: "this is a banana"),
        Item(imageName: "image", title: "orange", description: "this is an orange"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry"),
        Item(imageName: "image", title: "blueberry", description: "this is a blueberry")
    ]
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var caroselCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 60, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 25
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = items.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        return pageControl
    }()
    
    private lazy var floatingButton: UIButton = {
        let button = UIButton()
        button.setTitle("...", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 30
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapOnFloatingAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var headerView: UIView = {
        let header = UIView()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private lazy var searchBarContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        filteredItems = items
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerViewFit()
        tableView.isScrollEnabled = tableView.contentSize.height > tableView.frame.height
    }
}

extension MainPageViewController {
    private func setup() {
        setupConstraints()
        setupTableHeader()
    }
    
    private func setupConstraints() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(floatingButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            floatingButton.widthAnchor.constraint(equalToConstant: 60),
            floatingButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupTableHeader() {
        view.addSubview(headerView)
        headerView.addSubview(caroselCollectionView)
        headerView.addSubview(pageControl)
        headerView.addSubview(searchBarContainer)
        searchBarContainer.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            caroselCollectionView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 80),
            caroselCollectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 30),
            caroselCollectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -30),
            caroselCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            headerView.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            
            pageControl.centerXAnchor.constraint(equalTo: caroselCollectionView.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: caroselCollectionView.bottomAnchor, constant: 10),
            
            searchBarContainer.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20),
            searchBarContainer.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 30),
            searchBarContainer.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -30),
            searchBarContainer.heightAnchor.constraint(equalToConstant: 50),
            
            searchBar.topAnchor.constraint(equalTo: searchBarContainer.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: searchBarContainer.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: searchBarContainer.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: searchBarContainer.bottomAnchor),
            
            searchBarContainer.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20)
        ])
        
        tableView.tableHeaderView = headerView
        
        DispatchQueue.main.async {
            self.headerView.layoutIfNeeded()
            let size = self.headerView.systemLayoutSizeFitting(CGSize(width: self.view.bounds.width,
                                                                      height: UIView.layoutFittingCompressedSize.height))
            self.headerView.frame = CGRect(origin: .zero, size: size)
            self.tableView.tableHeaderView = self.headerView
        }
    }
    
    private func headerViewFit() {
        guard let header = tableView.tableHeaderView else { return }
        let size = header.systemLayoutSizeFitting(CGSize(width: tableView.bounds.width,
                                                         height: UIView.layoutFittingCompressedSize.height))
        if header.frame.height != size.height {
            header.frame.size.height = size.height
            tableView.tableHeaderView = header
            tableView.layoutIfNeeded()
        }
    }
}

extension MainPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredItems = searchText.isEmpty ? items : items.filter {
            $0.title.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}

extension MainPageViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier,
                                                            for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureImage(with: items[indexPath.item].imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 380, height: 250)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == caroselCollectionView {
            let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = Int(pageIndex)
        }
        
        if scrollView == tableView {
            let offsetY = scrollView.contentOffset.y
            
            if offsetY >= stickyThreshold {
                if searchBar.superview != self.view {
                    searchBar.removeFromSuperview()
                    self.view.addSubview(searchBar)
                    
                    NSLayoutConstraint.activate([
                        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                        searchBar.heightAnchor.constraint(equalToConstant: 50)
                    ])
                    self.view.layoutIfNeeded()
                }
            } else {
                if searchBar.superview != searchBarContainer {
                    searchBar.removeFromSuperview()
                    searchBarContainer.addSubview(searchBar)
                    searchBar.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        searchBar.topAnchor.constraint(equalTo: searchBarContainer.topAnchor),
                        searchBar.leadingAnchor.constraint(equalTo: searchBarContainer.leadingAnchor),
                        searchBar.trailingAnchor.constraint(equalTo: searchBarContainer.trailingAnchor),
                        searchBar.bottomAnchor.constraint(equalTo: searchBarContainer.bottomAnchor)
                    ])
                    searchBarContainer.layoutIfNeeded()
                }
            }
        }
    }
}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier,
                                                       for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.setupStrings(with: filteredItems[indexPath.row])
        return cell
    }
}

extension MainPageViewController {
    @objc private func didTapOnFloatingAction() {
        let targetChars = ["a", "e", "r"]
        var counts: [Character: Int] = ["a": 0, "e": 0, "r": 0]
        
        for item in items {
            for char in item.title.lowercased() where targetChars.contains(String(char)) {
                counts[char, default: 0] += 1
            }
        }
        
        let message = counts.map { "\($0.key) = \($0.value)" }
                              .joined(separator: "\n")
        
        let alert = UIAlertController(
            title: "Statistics",
            message: "Total items: \(items.count)\n\(message)",
            preferredStyle: .actionSheet
        )
        alert.addAction(UIAlertAction(title: "Done", style: .cancel))
        present(alert, animated: true)
    }
}
