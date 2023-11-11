//
//  SelectableTag.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 06/10/2023.
//

import SwiftUI

struct TagModel: Identifiable {
    let id: Int
    let title: String
    var isSelected: Bool
}

struct TagButtonView: View {
    var viewModel: MoviePresentable
    @State var tags: [TagModel]
    @State private var selectedTag: Int?
    weak var delegate: MovieViewController?
    
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
                            self.delegate?.buttonPopularTapped()
                        } else if tags[index].id == 2 {
                            tags[index].isSelected = true
                            self.delegate?.buttonUpcomingTapped()
                        } else if tags[index].id == 3 {
                            tags[index].isSelected = true
                            self.delegate?.buttonTopRatedTapped()
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
