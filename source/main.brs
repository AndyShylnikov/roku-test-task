sub main(args as dynamic)
    screen = CreateObject("roSGScreen")     ' create the roSGScreen
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("MainScene")     ' create a Scene node
    screen.show()
    config = loadConfig()

    scene.callFunc("initiate", config)
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub

function loadConfig()
    dataString = ReadAsciiFile("pkg:/config/config.json")
    config = parseJson(dataString)
    return config
end function