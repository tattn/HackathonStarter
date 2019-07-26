//
//  WebImage.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 2019/07/24.
//  Copyright © 2019 Tatsuya Tanaka. All rights reserved.
//

import SwiftUI
import Nuke

struct WebImage: View {
    @State private var image: SwiftUI.Image? = nil
    private let url: URL
    var placeholder: SwiftUI.Image?

    init(url: URL, placeholder: SwiftUI.Image? = nil) {
        self.url = url
        self.placeholder = placeholder
    }

    var body: some View {
        if image == nil {
            ImagePipeline.shared.loadImage(with: url) { [self] result in
                switch result {
                case .success(let response):
                    self.image = SwiftUI.Image(uiImage: response.image)
                case .failure: ()
                }
            }
            return placeholder
        }
        return image
    }
}

#if DEBUG
struct WebImage_Previews: PreviewProvider {
    static var previews: some View {
        WebImage()
    }
}

extension WebImage {
    init() {
        url = URL(string: "https://dummy.com")!
        image = Image(systemName: "photo")
    }
}
#endif
