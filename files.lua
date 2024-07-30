local Folders = {} do
    function Folders:MakeFolder(folder)
        if not isfolder((folder or "CrazyDay")) then
            repeat
                makefolder((folder or "CrazyDay"))
                wait()
            until isfolder((folder or "CrazyDay"))
        end
    end
    function Folders:DeleteFolder(folder)
        if isfolder((folder or "CrazyDay")) then
            repeat
                delfolder((folder or "CrazyDay"))
                wait()
            until not isfolder((folder or "CrazyDay"))
        end
    end
    function Folders:WriteFile(file, values)
        if not isfile(file) then
            repeat
                if values then
                    if type(values) == "table" then
                        writefile(file, game:GetService("HttpService"):JSONDecode(values))
                    else
                        writefile(file, values)
                    end
                else
                    writefile(file, "")
                end
                wait()
            until isfile(file)
        end
    end
    function Folders:ListFiles(path, str)
        local TablesOfFiles = {}
        local Names
        for i,v in ipairs(listfiles(path)) do
            if str and v.find(v,str) then Names = v:gsub(str, "") else Names = v end
            if Names.find(Names, ".lua") or Names.find(Names, ".json") then if Names.find(Names, ".lua") then Names = Names:gsub(".lua", "") else Names = Names:gsub(".json", "") end end
            table.insert(TablesOfFiles, Names)
        end
        return TablesOfFiles
    end
end
return Folders
