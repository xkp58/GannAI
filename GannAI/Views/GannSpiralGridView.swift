//
//  GannSpiralGridView.swift
//  GannAI
//
//  Created by Kang Peng on 2025/4/27.
//

import SwiftUI

/// Gann Spiral Square of Nine 全局网格（19×19）
/// 自动生成螺旋数字方阵，从中心 1 顺时针螺旋至 361。
/// - gridSize: 方阵大小（必须为奇数，如 19）
/// - cellSize: 每个格子的尺寸
/// - cellAction: 点击回调，返回 (row, col, value)
struct GannSpiralGridView: View {
    let gridSize: Int = 19
    let cellSize: CGFloat = 32
    var cellAction: ((Int, Int, Int) -> Void)? = nil

    // 生成螺旋数字方阵
    private var spiralGrid: [[Int]] {
        generateSpiralGrid(size: gridSize)
    }

    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            LazyVGrid(columns: Array(repeating: .init(.fixed(cellSize)), count: gridSize), spacing: 1) {
                ForEach(0..<gridSize, id: \.self) { row in
                    ForEach(0..<gridSize, id: \.self) { col in
                        let num = spiralGrid[row][col]
                        Button(action: { cellAction?(row, col, num) }) {
                            Text("\(num)")
                                .font(.system(size: 10))
                                .frame(width: cellSize, height: cellSize)
                                .background((row == gridSize/2 && col == gridSize/2) ? Color.blue.opacity(0.2) : Color.white)
                                .border(Color.gray.opacity(0.3), width: 0.5)
                        }
                    }
                }
            }
            .padding(4)
        }
    }

    /// 螺旋填充函数
    private func generateSpiralGrid(size: Int) -> [[Int]] {
        var grid = Array(repeating: Array(repeating: 0, count: size), count: size)
        let center = size / 2
        var x = center, y = center
        var value = 1
        grid[y][x] = value
        // 每层螺旋
        for layer in 1...center {
            // 向右一步
            x += 1; value += 1; grid[y][x] = value
            // 向上 2*layer-1 步
            for _ in 0..<(2*layer - 1) {
                y -= 1; value += 1; grid[y][x] = value
            }
            // 向左 2*layer 步
            for _ in 0..<(2*layer) {
                x -= 1; value += 1; grid[y][x] = value
            }
            // 向下 2*layer 步
            for _ in 0..<(2*layer) {
                y += 1; value += 1; grid[y][x] = value
            }
            // 向右 2*layer 步
            for _ in 0..<(2*layer) {
                x += 1; value += 1; grid[y][x] = value
            }
        }
        return grid
    }
}

// MARK: - Preview
struct GannSpiralGridView_Previews: PreviewProvider {
    static var previews: some View {
        GannSpiralGridView() { row, col, value in
            print("Tapped [\(row),\(col)] = \(value)")
        }
        .previewLayout(.sizeThatFits)
    }
}
