//
//  TodaysCardsView.swift
//  reMind
//
//  Created by Pedro Sousa on 03/07/23.
//

import SwiftUI

struct TodaysCardsView: View {
    @State var numberOfPendingCards: Int
    @State var theme: reTheme
    @State private var isSwiperViewPresented = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today's Cards")
                .font(.title)
                .fontWeight(.semibold)
            Text("\(numberOfPendingCards) cards to review")
                .font(.title3)

            NavigationLink() {
//                SwiperView(review: <#SwipeReview#>)
            } label: {
                Text("Start Swipping")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(reColorButtonStyle(.mauve))
            .padding(.top, 10)
        }
        .sheet(isPresented: $isSwiperViewPresented) {
                SwiperView(review: SwipeReview(termsToReview: [/* your terms here */]))
            }
        .padding(.vertical, 16)
    }
}

struct TodaysCardsView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysCardsView(numberOfPendingCards: 10, theme: .mauve)
            .padding()
    }
}
