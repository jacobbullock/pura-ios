//
//  SearchViewModel.swift
//  SampleApp
//
//  Created by Jacob Bullock on 1/16/24.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    enum ViewState {
        case empty
        case loading
        case error(Error)
        case word(Word)
    }

    @Published var state: ViewState
    
    init(state: ViewState = .empty) {
        self.state = state
    }
    
    func search(query: String) {
        state = .loading
        Task {
            do {
                let word = try await API.shared.fetchWord(query: query)
                guard let word else {
                    throw APIError.custom("There was an error processing your query")
                }
                
                await MainActor.run { state = .word(word) }
            } catch {
                await MainActor.run { state = .error(error) }
            }
        }
    }
}
