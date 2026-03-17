//
//  ContentView.swift
//  NewsSwiftUI
//
//  Created by Ildar Garifullin on 17.03.2026.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    let service = NewsService()
    @State var articles = [Article]()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                ForEach(articles, id: \.self) { article in
                    Item(imgURL: article.urlToImage, title: article.title, description: article.description)
                }
            }
            .padding(.horizontal, 15)
        }
        .onAppear {
            service.fetchNews(query: "Apple") { result in
                switch result {
                case .success(let articles):
                    self.articles = articles
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

struct Item: View {
    var imgURL: String?
    var title: String?
    var description: String?
    
    let speechService = SpeechService()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
//            Image("image")
            WebImage(url: URL(string: imgURL ?? ""))
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .clipShape(.buttonBorder)
            HStack {
                Text(title ?? "")
                    .font(.system(size: 16, weight: .black))
                Button {
                    speechService.speak(text: title ?? "")
                } label: {
                    ZStack {
                        Circle()
                            .frame(width: 27, height: 27)
                            .foregroundStyle(Color.green)
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 10,height: 10)
                            .foregroundStyle(Color.white)
                    }
                }
            }
            Text(description ?? "")
                .font(.system(size: 14, weight: .bold))
        }
        .padding(30)
        .background(Color.gray.opacity(0.3))
        .clipShape(.buttonBorder)    }
}

#Preview {
    ContentView()
}
