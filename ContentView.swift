//
//  ContentView.swift
//  ModelPickerAR
//
//  Created by 이재영 on 2024/01/09.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    private var models: [String] = {
        // 동적으로 모델 파일 가져오기
        let fileManager = FileManager.default
        
        guard let path = Bundle.main.resourcePath, let
                files = try? fileManager.contentsOfDirectory(atPath: path) else {
            return []
        }
        
        var availableModels: [String] = []
        for filename in files where filename.hasSuffix("usdz") {
            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            availableModels.append(modelName)
        }
        
        return availableModels
        
    }()
    
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
        
        ZStack(alignment: .bottom) {
            ARViewContainer()
            
            ModelPickerView(models: self.models)
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

struct ModelPickerView: View {
    var models: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(0 ..< self.models.count) { index in
                    Button(action: {
                        print("DEBUG: selected model with name: \(self.models[index])")
                    }) {
                        Image(uiImage: UIImage(named: self.models[index])!)
                            .resizable()
                            .frame(height: 80)
                            .aspectRatio(1/1, contentMode: .fit)
                            .cornerRadius(15)
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(20)
        .background(.black.opacity(0.5))
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
