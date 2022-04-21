def getPath(node):
    path = [node]
    currentNode = node

    while True:
        currentNode = currentNode.previousNode
        if not currentNode:
            break
        path.append(currentNode)

    path.reverse()

    return path


def dfs(node, condition, visited=[]):

    if condition(node):
        return getPath(node)

    for edgeNode in node.edgeNodes():
        if edgeNode in visited:
            continue

        nextNode = dfs(edgeNode, condition, visited + [node])

        if nextNode:
            return nextNode

    return None


def bfs(node, condition, visited: list = []):
    queue = []
    node.visited = True
    queue.append(node)
    while queue:
        currentNode = queue.pop(0)

        if condition(currentNode):
            return getPath(currentNode)

        for child in currentNode.edgeNodes():
            if child not in visited:
                visited.append(child)
                queue.append(child)
