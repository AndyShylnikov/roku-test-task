function createNodeAndInit(nodeName as string, params = invalid as object)
  node = createObject("roSGNode", nodeName)
  if params <> invalid then
    node.setFields(params)
  end if
  return node
end function

Function IsValid(obj As Dynamic) As Boolean
    return type(obj) <> "<uninitialized>" and obj <> invalid
End Function
