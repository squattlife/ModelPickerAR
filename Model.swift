//
//  Model.swift
//  ModelPickerAR
//
//  Created by 이재영 on 2024/01/11.
//

import UIKit
import RealityKit
import Combine

class Model {
    var modelName: String
    var image: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        
        self.image = UIImage(named: modelName)!
        
        // combine을 이용해서 modelEntity 비동기 로드
        let fileName = modelName + ".usdz"
        self.cancellable = ModelEntity.loadModelAsync(named: fileName)
            .sink(receiveCompletion: { loadCompletion in
                // 에러 핸들링
                print("DEBUG: modelEntity 로드 실패 , 모델명: \(self.modelName)")
            }, receiveValue: { modelEntity in
                // modelEntity 받기
                self.modelEntity = modelEntity
                print("DEBUG: modelEntity 로드 성공! , 모델명: \(self.modelName)")
            })
    }
}
