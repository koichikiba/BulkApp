//
//  CreateViewController.swift
//  BulkApp
//
//  Created by user on 2022/11/13.
//

import UIKit
import Alamofire
import KeychainAccess

class CreateViewController: UIViewController {
    
    private var token = ""
    let consts = Constants.shared
    let okAlert = OkAlert()
    var selectedCategoryId = 1
    
    @IBOutlet weak var eventTextField: UITextField! //①
    @IBOutlet weak var memoTextField: UITextField! //②
    
    @IBOutlet weak var categoryField: UITextField!
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    //インデックスは0はじまり、idは1はじまりなので+1する
    let categories = [
        "胸",
        "背中",
        "脚",
        "肩",
        "腕(上腕二頭筋)",
        "腕(上腕三頭筋)",
        "腹",
        "その他"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        //token読み込み
        token = LoadToken().loadAccessToken()
        
        //TextViewに枠線をつける
        let viewCustomize = ViewCustomize()
//        memoTextField = viewCustomize.addBoundsTextField(textField: memoTextField)
//        
        // Do any additional setup after loading the view.
    }
    
    //投稿ボタン
    @IBAction func postArticle(_ sender: Any) {
        if eventTextField.text != "" && memoTextField.text != "" {
                                    createRequest(token: token)
        } else {
            okAlert.showOkAlert(title: "未入力欄があります", message: "全ての欄を入力してください", viewController: self)
        }
    }
    
    //投稿のリクエスト
    func createRequest(token: String) {
        guard let url = URL(string: consts.baseUrl + "/api/posts") else { return }
        
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token),
            .accept("application/json"),
            .contentType("multipart/form-data")
        ]
        
        //文字情報と画像やファイルを送信するときは 「AF.upload(multipartFormData: …」 を使う
        AF.upload(
            //multipartFormDataにappendで送信したいデータを追加していく
            multipartFormData: { multipartFormData in
                
                guard let eventTextData = self.eventTextField.text?.data(using: .utf8) else {return}
                multipartFormData.append(eventTextData, withName: "event")
                
                guard let memoTextData = self.memoTextField.text?.data(using: .utf8) else {return}
                multipartFormData.append(memoTextData, withName: "memo")
                
                //部位
                
                guard let categoryId = String(self.selectedCategoryId).data(using: .utf8) else {return}
                multipartFormData.append(categoryId, withName: "category_id")
                
                
                
            },
            to: url,
            method: .post, //uploadはデフォルトがPOSTメソッドなので省略可能
            headers: headers
        ).response { response in
            switch response.result {
            case .success:
                print("🍏success from Create🍏")
                self.createAlart(title: "投稿完了!", message: "作成した記事を投稿しました")
            case .failure(let err):
                print(err)
                self.okAlert.showOkAlert(title: "エラー!", message: "\(err)", viewController: self)
            }
        }
    }
    
    //OKが押されたら一覧画面に戻るアラートのメソッド
    func createAlart(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        eventTextField.resignFirstResponder()
        memoTextField.resignFirstResponder()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension CreateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedCategoryId = row + 1
    }
    
}
