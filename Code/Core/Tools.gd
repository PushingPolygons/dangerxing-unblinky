class_name Tools

static func DeleteChildren(node: Node):
	for child in node.get_children():
		#print(child.name)
		child.get_parent().remove_child(child)
		child.queue_free()
