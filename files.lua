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
    function Folders:WriteFile(file)
        if not isfile(file) then
            repeat
                writefile(file)
                wat()
            until isfolder(file)
        end
    end
end
return Folders
