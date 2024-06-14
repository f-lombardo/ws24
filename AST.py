import ast
import graphviz

def ast_to_graph(node, graph, parent=None):
    node_id = str(id(node))
    label = type(node).__name__

    # Add the current node to the graph
    graph.node(node_id, label)

    # Connect to the parent node
    if parent:
        graph.edge(parent, node_id)

    # Recursively process the child nodes
    for field, value in ast.iter_fields(node):
        if isinstance(value, list):
            for item in value:
                if isinstance(item, ast.AST):
                    ast_to_graph(item, graph, node_id)
        elif isinstance(value, ast.AST):
            ast_to_graph(value, graph, node_id)

def generate_ast_graph(code):
    tree = ast.parse(code)
    graph = graphviz.Digraph(comment="Abstract Syntax Tree")
    ast_to_graph(tree, graph)
    return graph

# Sample Python code
sample_code = """
import math
def greet(who):
    if who:
    	print(f"Hello, {who}!")
    else:
    	print("Hello, World!")
"""

# Generate the AST graph
graph = generate_ast_graph(sample_code)

# Save the graph to a file and render it
graph.render("ast", format="png", view=True)

