//
//  SelectableTag.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 06/10/2023.
//

import SwiftUI

protocol TapButtonDelegate: NSObject {
    func didSelectTag(_ moviePageType: MoviePageType)
}

struct TagModel: Identifiable {
    let id: Int
    let title: String
    var isSelected: Bool
}

struct TagButtonView: View {
    var viewModel: MoviePresentable
    @State var tags: [TagModel]
    @State private var selectedTag: Int?
    weak var delegate: TapButtonDelegate?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(0..<tags.count) { index in
                    Button(action: {
                        let newTag = tags.compactMap { tag in
                            var newTag = tag
                            newTag.isSelected = false
                            return newTag
                        }
                        tags = newTag
                        withAnimation {
                            selectedTag = index
                        }

                        // Add your button action here
                        if tags[index].id == 1 {
                            tags[index].isSelected = true
                            self.delegate?.didSelectTag(.popular)
                        } else if tags[index].id == 2 {
                            tags[index].isSelected = true
                            self.delegate?.didSelectTag(.upcoming)
                        } else if tags[index].id == 3 {
                            tags[index].isSelected = true
                            self.delegate?.didSelectTag(.top_rated)
                        }
                    }) {
                        Text(tags[index].title)
                            .padding(10)
                            .background(tags[index].isSelected ? Color.black.opacity(0.7) : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                }
            }
            .padding(10)
        }
    }
}
