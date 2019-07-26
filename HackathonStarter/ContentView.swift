//
//  ContentView.swift
//  HackathonStarter
//
//  Created by Tatsuya Tanaka on 2019/07/24.
//  Copyright © 2019 Tatsuya Tanaka. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello World")
            WebImage(url: URL(string: "https://avatars3.githubusercontent.com/u/8188636?s=180&v=4")!)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
