//
//  MostFavoriteViewController.swift
//  NewsApp
//
//  Created by Oleksandr Semeniuk on 15.12.2021.
//

import UIKit

final class MostEmailedViewController: UIViewController {
    
    let networkManager = NetworkManager()
    var model: MostFavoriteModel = .init(items: [])
    
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Most Emailed"
        fetchData()
        createTableView()
        setUpButtonFavorite()
    }
    
    //MARK: - private methods
//    func getImage(from string: String) -> UIImage? {
//        //2. Get valid URL
//        guard let url = URL(string: string)
//            else {
//                print("Unable to create URL")
//                return nil
//        }
//
//        var image: UIImage? = nil
//        do {
//            //3. Get valid data
//         //   let data = try Data(contentsOf: url, options: [])
//            let data1 = try NSData(contentsOf: url )
//            //4. Make image
//            image = UIImage(data: data1 as! Data)
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//
//        return image
//    }

       
    
    private func fetchData() {
        networkManager.fetchMostNews(nesType: .mostEmailed) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let items: [NewsTableViewCellModel] = data.data.compactMap { item in
                    return NewsTableViewCellModel(
                        imageURL: "",
                        title: item.title,
                        date: item.publishedDate,
                        newsSection: item.section,
                        newsText: "asdbahsdghagsdhgvashgdakshgdaghsdvkgahsfvaflafhj"
                    )
                }
                
                self.model = MostFavoriteModel(items: items)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            print(self.model.items[0].date)
        }
    }
    
    private func createTableView() {
        guard let tableView = tableView else { return }
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func setUpButtonFavorite () {
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: #selector(action)
        )
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc func action() {
        print("Favorite")
    }
}

extension MostEmailedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "NewsTableViewCell",
            for: indexPath
        ) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        let item = model.items[indexPath.row]
        
        //let string = "https://static01.nyt.com/images/2021/12/08/science/08virus-fat/08virus-fat-thumbStandard.jpg"

     //   if let image = getImage(from: string) {
            //5. Apply image
//            cell.setUpCell(text: item.newsText,
//                           image: image,
//                           title: item.title,
//                           date: item.date,
//                           type: item.newsSection)        }
//
        let image: UIImage = UIImage(named: "News")!
     //   let image = URL(string: "https://static01.nyt.com/images/2021/12/08/science/08virus-fat/08virus-fat-thumbStandard.jpg")
        cell.setUpCell(text: item.newsText,
                       image: image,
                       title: item.title,
                       date: item.date,
                       type: item.newsSection)
        
        return cell
    }
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let arr = array[indexPath.section]
    //        performSegue(withIdentifier: "showDetail", sender: arr)
    //    }
    //    func tableView
}
