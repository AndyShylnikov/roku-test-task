sub init()
    m.poster = m.top.findNode("poster")
    m.title = m.top.findNode("title")
    m.year = m.top.findNode("year")
    m.poster.ObserveField("loadStatus", "onPosterLoadChanged")
end sub

function onContentChanged()
    itemData = m.top.itemContent

    m.poster.setFields(itemData.config.poster)
    m.title.setFields(itemData.config.title)
    m.year.setFields(itemData.config.year)

    if itemData.uriPoster <> "" then m.poster.uri = itemData.uriPoster else m.poster.uri = m.config.fallBackPoster
    m.title.text = itemData.title
    m.year.text = itemData.year
end function

function onPosterLoadChanged(message as object)
    if message.getData() = "failed" then m.poster.uri = m.top.itemContent.config.fallBackPoster
end function    

