sub init()

end sub

function setResultContent(params as object)
    data = CreateNodeAndInit("ContentNode")
    row = data.CreateChild("ContentNode")
    row.title = "Search results: " + params.count().toStr()
    for i = 0 to params.count() - 1
        item = row.CreateChild("ResultRowListData")
        item.setFields({
            "title": params[i].title
            "year": params[i].year
            "uriPoster": params[i].uriPoster
            "config": params[i].config
        })
    end for
    m.top.content = data
end function

