//
//  SearchBarView.swift
//  SeatGeekDSG
//
//  Created by Alex Lundquist on 4/6/22.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var body: some View {
        HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(searchText.isEmpty ? Color.gray : Color.white)
                TextField("", text: $searchText)
                    .placeholder(when: searchText.isEmpty) {
                        Text("Search for an event....").foregroundColor(Color.gray)
                    }
                    .foregroundColor(Color.white)
                    .overlay(
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .offset(x: 10)
                            .foregroundColor(Color.white)
                            .opacity(searchText.isEmpty ? 0.0 : 1.0)
                            .onTapGesture {
                                searchText = ""
                            }
                        , alignment: .trailing
                    )
                
            }
            .font(.headline)
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.searchBox)
            )
            .padding(10)
            if !searchText.isEmpty {
                Button {
                    withAnimation(.easeOut(duration: 0.1)) {
                        searchText = ""
                    }
                } label: {
                    Text("Cancel")
                }
                .foregroundColor(Color.white)
                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                .padding(.trailing, 10)
            }
        }
        .animation(.easeInOut, value: searchText.isEmpty)
    }
}
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
//struct SearchBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBarView()
//            .preferredColorScheme(.dark)
//            .previewLayout(.sizeThatFits)
//    }
//}
