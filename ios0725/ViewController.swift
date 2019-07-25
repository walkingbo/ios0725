//
//  ViewController.swift
//  ios0725
//
//  Created by 503_18 on 25/07/2019.
//  Copyright © 2019 503_18. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //영화제목과 이미지 경로를 저장할 Tuple을 생성하고 Tuple의 배열을 생성
    typealias MovieRecord = (title:String, imageUrl:String)
    var movieList = [MovieRecord]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //다운로드 받을 주소
        let addr = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=1&count=20&genreId=&order=releasedateasc"
        
        //URL! 만들기
        let url = URL(string: addr)
        
        //데이터 다운로드 받기
        let data = try! Data(contentsOf: url!)
        
        //JSON 파싱
        //json 데이터의 시작이  { 로 시작해서 [로 시작하면 NSArray로 변환
        let jsonResult = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
        //hoppin 키의 값을 딕셔너리로 가져오기
        let hoppin = jsonResult["hoppin"] as! NSDictionary
        //movies 키의 값을 딕셔너리로 가져오기
        let movies = hoppin["movies"] as! NSDictionary
        //movie의 키 값을 배열로 가져오기
        let movie = movies["movie"] as! NSArray
        //배열 순회
        for temp in movie{
            //배열 각각의 데이터를 딕셔너리로 변환
            let imsi = temp as! NSDictionary
            //title 키와 thumbnailImage키의 값을 가져오기
            let title = imsi["title"] as! String
            let thumbnailImage = imsi["thumbnailImage"] as! String
            //파싱한 데이터를 데이터 배열에 추가
            movieList.append((title:title, imageUrl:thumbnailImage))
            
        }
        print(movieList)
        
        /*
        //문자열로 변환
        let jsonString = String(data: data, encoding: .utf8)
        
        print(jsonString)
        */
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //네이게이션 바 중앙에 타이틀을 설정
        self.title = "영화"
        
        
        
    }


}
