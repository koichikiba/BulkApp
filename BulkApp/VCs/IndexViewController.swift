//
//  IndexViewController.swift
//  BulkApp
//
//  Created by user on 2022/11/13.
//

import UIKit

import Alamofire
import Kingfisher
import KeychainAccess

class IndexViewController: UIViewController {
    
    @IBOutlet weak var articleTableView: UITableView!
    let consts = Constants.shared
    let sectionTitle = ["ワークアウト一覧"]
    private var token = ""
    
    var articles: [Article] = []
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleTableView.dataSource = self
        articleTableView.delegate = self
        getUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            requestIndex()
        }
    
    func requestIndex(){
            //URL、トークン、ヘッダーを用意
            let url = URL(string: consts.baseUrl + "/api/posts")!
            let token = LoadToken().loadAccessToken()
            let headers: HTTPHeaders = [
                .contentType("application/json"),
                .accept("application/json"),
                .authorization(bearerToken: token)
            ]

            /* ヘッダーはこの書き方でもOK
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": "Bearer \(token)",
            ]
            */
            
            //Alamofireでリクエスト
            AF.request(
                url,
                method: .get,
                encoding: JSONEncoding.default,
                headers: headers
            ).responseDecodable(of: Index.self) { response in
                switch response.result {
                case .success(let articles):
                    print("🔥success from Index🔥")
                    if let atcls = articles.data {
                        self.articles = atcls
                        self.articleTableView.reloadData()
                    }
                case .failure(let err):
                    print(err)
                }
            }
        }
    //自分(user)の情報取得(idとname)
        func getUser() {
            let url = URL(string: consts.baseUrl + "/api/user")!
            let token = LoadToken().loadAccessToken()
            let headers: HTTPHeaders = [
                .authorization(bearerToken: token),
                .accept("application/json")
            ]
            
            AF.request(
                url,
                encoding: JSONEncoding.default,
                headers: headers
            ).responseDecodable(of: User.self){ response in
                switch response.result {
                case .success(let user):
                    self.user = user
                case .failure(let err):
                    print(err)
                }
            }
        }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func pressedCreateButtton(_ sender: Any) {
            let createVC = self.storyboard?.instantiateViewController(withIdentifier: "Create") as! CreateViewController
            navigationController?.pushViewController(createVC, animated: true)
        }
}

extension IndexViewController: UITableViewDataSource {
    
    //セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    //セクションの数 (= セクションのタイトルの数)
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    //行の数(= 記事の数)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    //セル1つの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        cell.createdAtLabel.text = articles[indexPath.row].createdAtStr()
        cell.categoryLabel.text = articles[indexPath.row].category
        cell.eventLabel.text = articles[indexPath.row].event
        
        return cell
    }
    
}

extension IndexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        guard let user = user else { return }
        detailVC.articleId = article.id //詳細画面の変数に記事のIDを渡す
        detailVC.myUser = user //ユーザー情報も渡す
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
