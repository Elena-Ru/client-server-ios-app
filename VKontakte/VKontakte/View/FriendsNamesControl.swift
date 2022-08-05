//
//  FriendsNamesControl.swift
//  VKontakte
//
//  Created by Елена Русских on 29.06.2022.
//

import UIKit

class FriendsNamesControl: UIControl {
    
    var controllerFriendsView: AllFriendsViewController!
    var buttonLetterArray = [UIButton]()
    var heightButton = 8
    var selectedLetter: UIButton? = nil

    override init(frame: CGRect) {
    super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    }
    
    
    func setFriendsNamesControl (controller:AllFriendsViewController!){
        controllerFriendsView = controller
        guard !controller.firstLetterOfTheName.isEmpty else { return}
        var yCoordinat = 0

        for i in 0..<controller.firstLetterOfTheName.count{
            let buttonLetter = UIButton(frame: CGRect(x: Int(bounds.width / 2 - 5),
                                                    y: yCoordinat,
                                                    width: 15,
                                                    height: heightButton))
            buttonLetter.setTitle(String(controller.firstLetterOfTheName[i]), for: .normal)
            buttonLetter.setTitleColor(.white, for: .normal)
            buttonLetter.backgroundColor = .clear
        addSubview(buttonLetter)
            
            buttonLetter.addTarget(self, action: #selector(selectLetter(_:)), for:
            .touchUpInside)
            buttonLetterArray.append(buttonLetter)
            yCoordinat += (heightButton + 10)
        }
    }
    
    @objc private func selectLetter(_ sender: UIButton) {
        guard let index = self.buttonLetterArray.firstIndex(of: sender) else { return }
    self.selectedLetter = buttonLetterArray[index]
        controllerFriendsView.friendsTable.scrollToRow(at: IndexPath(row: 0, section: index), at: .top, animated: true)
    }
    
}


