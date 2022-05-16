sub init()
    m.background = m.top.findNode("background")
    m.keyboard = m.top.findNode("keyboard")
    m.resultRow = m.top.findNode("resultRow")
    m.searchButtons = m.top.findNode("searchButtons")
    m.utilLabel = m.top.findNode("utilLabel")
    m.dataService = createNodeAndInit("DataService")
    m.dataService.observeField("state", "onDataServiceStateChanged")
    m.searchResult = {}
    m.searchButtons.observeFieldScoped("buttonSelected","onSearchButtonSelected")
    m.searchTypes = [
        "series"
        "movie"
    ]
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if (press = true)
        if (Lcase(key) = "right" and m.keyboard.isInFocusChain())
            m.searchButtons.setFocus(true)
        else if (LCase(key) = "left" and (m.searchButtons.isInFocusChain() or m.resultRow.isInFocusChain()))
            m.keyboard.setFocus(true)
        else if (LCase(key) = "up" and m.resultRow.isInFocusChain())
            m.keyboard.setFocus(true)
        else if (LCase(key) = "down" and (m.searchButtons.isInFocusChain() or m.keyboard.isInFocusChain()) and isValid(m.resultRow.content) and m.resultRow.content.getChildCount() > 0)
            m.resultRow.setFocus(true)
        end if
    end if
end function

function initiate(config as object)
    m.config = config
    m.background.setFields(m.config.sceneConfig.background)
    m.keyboard.setFields(m.config.sceneConfig.keyboard)
    m.resultRow.setFields(m.config.sceneConfig.result)
    m.searchButtons.setFields(m.config.sceneConfig.searchButtons)
    m.utilLabel.setFields(m.config.sceneConfig.utilLabel)
    m.keyboard.setFocus(true)
end function

function onSearchButtonSelected(message as object)
    searchString = m.keyboard.text.trim()
    if (searchString <> "")
        m.dataService.url = m.config.apiConfig.host + "?apiKey=" + m.config.apiConfig.apiKey + "&s=" + searchString + "&type=" + m.searchTypes[message.getData()]
        m.dataService.control = "RUN"
    end if
end function

function onDataServiceStateChanged(message as object)
    state = message.getData()
    if (state = "stop")
        result = parseResult(m.dataService.responseInfo)
        if isValid(result) and result.success then
            m.resultRow.visible = true
            m.utilLabel.visible = false
            m.resultRow.callFunc("setResultContent", result.items)
        else
            m.resultRow.visible = false
            m.utilLabel.visible = true
        end if
    end if
end function

function parseResult(responseInfo as object)
    if isValid(responseInfo) and Lcase(responseInfo.response) = "true" then
        result = {
            success: true
            items: []
        }
        for each item in responseInfo.search
            result.items.push({
                title: item.Title
                year: item.year
                uriPoster: item.poster
            })
        end for
        return result
    else
        return {
            success: false
        }
    end if
end function
