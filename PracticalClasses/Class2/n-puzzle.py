#!/usr/bin/env python3

from algorithms import *


class PuzzleNode:
    def __init__(self, board: list, previousNode=None) -> None:
        self.board = board
        self.previousNode = previousNode
        self.visited = False
        self.heuristic = -1

    def __eq__(self, other) -> bool:
        return isinstance(other, self.__class__) and self.board == other.board

    def __gt__(self, other) -> bool:
        return isinstance(other, PuzzleNode) and self.heuristic > other.heuristic

    def __repr__(self):
        return f"({self.board})"

    def __str__(self):
        return f"({self.board})"

    def findZero(self):
        for i in range(0, len(self.board)):
            for j in range(0, len(self.board[i])):
                if self.board[i][j] == 0:
                    return (j, i)
        return (-1, -1)

    def edgeNodes(self):
        edgeList = []

        (x, y) = self.findZero()

        if y > 0:
            newBoard = []
            for i in range(len(self.board)):
                line = []
                for j in range(len(self.board)):
                    line.append(self.board[i][j])
                newBoard.append(line)
            temp = newBoard[y - 1][x]
            newBoard[y - 1][x] = 0
            newBoard[y][x] = temp
            edgeList.append(PuzzleNode(newBoard, self))
        if y < 2:
            newBoard = []
            for i in range(len(self.board)):
                line = []
                for j in range(len(self.board)):
                    line.append(self.board[i][j])
                newBoard.append(line)
            temp = newBoard[y + 1][x]
            newBoard[y + 1][x] = 0
            newBoard[y][x] = temp
            edgeList.append(PuzzleNode(newBoard, self))
        if x > 0:
            newBoard = []
            for i in range(len(self.board)):
                line = []
                for j in range(len(self.board)):
                    line.append(self.board[i][j])
                newBoard.append(line)
            temp = newBoard[y][x - 1]
            newBoard[y][x - 1] = 0
            newBoard[y][x] = temp
            edgeList.append(PuzzleNode(newBoard, self))
        if x < 2:
            newBoard = []
            for i in range(len(self.board)):
                line = []
                for j in range(len(self.board)):
                    line.append(self.board[i][j])
                newBoard.append(line)
            temp = newBoard[y][x + 1]
            newBoard[y][x + 1] = 0
            newBoard[y][x] = temp
            edgeList.append(PuzzleNode(newBoard, self))

        return edgeList


initialBoard = [
    [1, 6, 2],
    [5, 7, 3],
    [0, 4, 8],
]

initialNode = PuzzleNode(initialBoard)


def condition(node: PuzzleNode):
    lst = [[1, 2, 3], [4, 5, 6], [7, 8, 0]]

    if node.board == lst:
        return True
    return False


print("Path: ", bfs(initialNode, condition))
