sub init()
    m.top.functionName = "doGet"
end sub


function doGet()
    request = createObject("roUrlTransfer")
    url = m.top.url
    responseInfo = {}
    ? url
    request.setUrl(url)
    responseInfo = parsejson(request.getToString())
    m.top.responseInfo = responseInfo
end function

