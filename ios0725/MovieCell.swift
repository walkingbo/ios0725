//
//  MovieCell.swift
//  ios0725
//
//  Created by 503_18 on 25/07/2019.
//  Copyright © 2019 503_18. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var tbnailImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    //행의 개수를 설정해 주는 메소드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    //셀을 생성해주는 메소드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        //타이틀을 출력
        cell.lblTitle.text = movieList[indexPath.row].title
        //이미지 URL로 부터 이미지를 다운로드 받기
        let imageURL = URL(string: movieList[indexPath.row].imageUrl)
        let imageData = try! Data(contentsOf: imageURL!)
        //이미지 만들기
        let image = UIImage(data: imageData)
        //이미지 출력
        cell.tbnailImage.image = image
        
        return cell
    }
    //셀의 높이를 설정하는 메소드
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

