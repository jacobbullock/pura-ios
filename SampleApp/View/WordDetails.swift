//
//  WordDetails.swift
//  SampleApp
//
//  Created by Jacob Bullock on 1/16/24.
//

import SwiftUI

struct WordDetails: View {
    @ObservedObject private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .empty: emptyView
            case .loading: loadingView
            case .word(let word): detailView(word: word)
            case .error(let error): errorView(error: error)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

extension WordDetails {
    @ViewBuilder private var emptyView: some View {
        VStack {
            Text("Search for any english word to get started")
            
            Image(systemName: "sparkle.magnifyingglass")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(.gray.opacity(0.3))
        }
    }
    
    @ViewBuilder private var loadingView: some View {
        ProgressView()
    }
    
    @ViewBuilder private func errorView(error: Error) -> some View {
        VStack {
            Text(error.localizedDescription)
            
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(.gray.opacity(0.3))
        }
    }
    
    @ViewBuilder private func detailView(word: Word) -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(word.text)
                    .font(.largeTitle)
                
                if let wordClass = word.wordClass {
                    Text(wordClass)
                        .font(.headline)
                }
                
                ForEach(0..<word.definitions.count, id: \.self) { index in
                    HStack(alignment: .top) {
                        Text("\(index + 1). ")
                        Text(word.definitions[index])
                    }
                }
                
                if !word.images.isEmpty {
                    Divider()
                        .padding(.vertical, 15)
                    
                    Text("Giphy")
                        .font(.title)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(word.images, id: \.self) { item in
                                VideoLooperView(videoURL: item)
                                    .frame(width: 150, height: 150)
                            }
                        }
                    }
                    .frame(height: 200)
                }
                
                if !word.synonyms.isEmpty {
                    Divider()
                        .padding(.vertical, 15)
                    
                    Text("Synonyms")
                        .font(.title)
                    
                    VStack(alignment: .leading) {
                        ForEach(word.synonyms, id: \.self) { item in
                            Button(
                                action: { viewModel.search(query: item) },
                                label: { Text(item) }
                            )
                        }
                    }
                    
                }
            }
        }
    }
}
