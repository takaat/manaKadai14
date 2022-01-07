//
//  ContentView.swift
//  Kadai14
//
//  Created by mana on 2022/01/07.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let name: String
    let isChecked: Bool
}

struct ContentView: View {
    @State private var isShowAddItemView = false
    @State private var items: [Item] = [.init(name: "りんご", isChecked: false),
                                        .init(name: "みかん", isChecked: true),
                                        .init(name: "バナナ", isChecked: false),
                                        .init(name: "パイナップル", isChecked: true)]

    var body: some View {
        NavigationView {
            List(items) { item in
                ItemView(item: item)
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowAddItemView = true },
                           label: { Image(systemName: "plus") })
                }
            }
        }
        .fullScreenCover(isPresented: $isShowAddItemView) {
            AddItemView(isShowView: $isShowAddItemView, items: $items)
        }
    }
}

struct AddItemView: View {
    @Binding var isShowView: Bool
    @Binding var items: [Item]
    @State private var name = ""

    var body: some View {
        NavigationView {
            HStack(spacing: 30) {
                Text("名前")
                    .padding(.leading)

                TextField("", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.trailing)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isShowView = false
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        items.append(.init(name: name, isChecked: false))
                        isShowView = false
                    }
                }
            }
        }
    }
}

struct ItemView: View {
    let item: Item
    private let checkMark = Image(systemName: "checkmark")

    var body: some View {
        HStack {
            if item.isChecked {
                checkMark.foregroundColor(.orange)
            } else {
                checkMark.hidden()
            }

            Text(item.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(isShowView: .constant(true), items: .constant([.init(name: "りんご", isChecked: true)]))
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: .init(name: "みかん", isChecked: true))
    }
}
