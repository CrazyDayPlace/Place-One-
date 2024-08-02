repeat wait() until game:IsLoaded()
    local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/CrazyDayPlace/Place-One-/main/GuiTestPlace.lua"))()
    local SAVE = loadstring(game:HttpGet("https://raw.githubusercontent.com/CrazyDayPlace/Place-One-/main/Save.lua"))()
    local INT = loadstring(game:HttpGet("https://raw.githubusercontent.com/CrazyDayPlace/Place-One-/main/interfaces.lua"))()
    local OPTIONS = GUI.Options
    local WINDOW = GUI:CreateWindow({
        Title = "Fluent Gui",
        SubTitle = GUI.Version,
        UpdateDate = nil,
        UpdateLog = nil,
        IconVisual = nil,
        TabWidth = 100,
        Size = UDim2.fromOffset(500, 380),
        Acrylic = true,
        Theme = "Darker",
        MinimizeKey = Enum.KeyCode.LeftAlt,
        BlackScreen = false
    })

    local TABS = {
        A = WINDOW:AddTab({Title = "General", Name = nil, Icon = "layers"}),
        B = WINDOW:AddTab({ Title = "Settings", Icon = "settings"})
    }
    local SECTIONS = {
        A = {TABS.A:AddSection("Main")}
    }

    SECTIONS.A[1]:AddToggle("Play Macro", {
        Title = "TEST",
        Description = nil,
        Default = false,
        Callback = function (v)

        end
    })

    SECTIONS.A[1]:AddDropdown("Selected Skills", {
        Title = "TEST MULTI:",
        Description = nil,
        Values = {"FireBall1","Gammaray11"},
        Multi = true,
        Default = {nil},
        Callback = function (v)

        end
    })

    SECTIONS.A[1]:AddDropdown("XAWD", {
        Title = "TEST NORMAL:",
        Description = nil,
        Values = {"FireBall1","Gammaray11"},
        Multi = false,
        Default = 1,
        Callback = function (v)

        end
    })

    SECTIONS.A[1]:AddButton({
        Title = "TESTAXAW",
        Description = nil,
        Callback = function()
            for i,v in pairs(OPTIONS) do
                print(i,v)
            end
        end
    })

    for i,v in pairs(OPTIONS) do
        if not table.find({"AcrylicToggle","TransparentToggle","BlackScreenToggle","MenuKeybind","InterfaceTheme"}, i) then
            OPTIONS[tostring(i)]:OnChanged(function (Value)
                if type(Value) == "table" then
                    for i,v in pairs(Value) do
                        print(i,v)
                    end
                else
                    print(Value)
                end
            end)
        end
    end

do
    INT:SetLibrary(GUI)
    INT:SetFolder("FluentScriptHub")
    INT:BuildInterfaceSection(TABS.B)

    SAVE:SetLibrary(GUI)
    SAVE:SetFolder("FluentScriptHub")
    SAVE:SetIgnoreIndexes({})
    SAVE:IgnoreThemeSettings()
    WINDOW:SelectTab(1)
    SAVE:Load("Configs")
end
