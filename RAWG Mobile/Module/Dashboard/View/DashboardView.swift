//
//  DashboardView.swift
//  RAWG Mobile
//
//  Created by Naufal Abiyyu on 13/03/24.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var presenter: DashboardPresenter
    
    var body: some View {
        VStack {

            slideBannerView
            
            Spacer()
            
            topListPicks
            
        }
    }
}

extension DashboardView {
    
    // MARK: The Slide banner view like caraousel
    var slideBannerView: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                Text("New and trending")
                    .font(.system(size: 28))
                    .fontWeight(.heavy)
                    .foregroundStyle(.text)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        if presenter.isLoading {
                            HStack {
                                ForEach(0..<5, id: \.self) { _ in
                                    ShimmerView(selectedShimmer: .horizontal)
                                }
                            }
                        } else {
                            ForEach(presenter.trending, id: \.id) { game in
                                ZStack {
                                    SlideBannerView(data: game)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .onAppear {
            if self.presenter.trending.count == 0 {
                self.presenter.getTrending()
            }
        }
    }
    
    // MARK: List of Top Picks games
    var topListPicks: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                HStack {
                    Text("Top Picks")
                        .font(.system(size: 20))
                        .foregroundStyle(.text)
                        .fontWeight(.bold)
                    
                    VStack {
                        Divider()
                            .padding(.leading, 16)
                    }
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .leading) {
                        if presenter.isLoading {
                            HStack {
                                ForEach(0..<5, id: \.self) { _ in
                                    ShimmerView(selectedShimmer: .vertical)
                                }
                            }
                        } else {
                            ForEach(presenter.topPicks, id: \.id) { game in
                                ZStack {
                                    TopPicksView(data: game)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .ignoresSafeArea(.all)
        }
        .onAppear {
            if self.presenter.topPicks.count == 0 {
                self.presenter.getTopPicksGames()
            }
        }
    }
}
