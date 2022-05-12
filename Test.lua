local startResult = require('vscode-debuggee').start()
print('debuggee start result: ', startResult)

local CurrentDirectory = io.popen("cd"):read()

function string.split(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function downloadFile(url, path)
    os.execute("powershell.exe Invoke-WebRequest " .. url .. " -OutFile " .. path)
end

local file = {}
function exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
       if code == 13 then
          return true
       end
    end
    return ok, err
end

function ExtractFile(path, destination)
    os.execute("powershell.exe ".. CurrentDirectory .. "/7za.exe" .." x \"" .. path .."\" -y -o\"".. destination .."\" > BootstrapperLogs.log")
end

print("[+] Loading Files...")

local KaoruScripts = {
    ["Folder"] = {
        "KaoruHub";
    };
    ["Scripts"] = {
        [1] = {"https://anonfiles.com/L1n711f2ye/Magic_Woodcutter_Simulator_lua"};
        [2] = {"https://anonfiles.com/72o812ffya/Weapon_Fighting_Simulator_lua"};
    };
}

print("[+] Checking If Folders exists...")
if (exists("./KaoruHub")) then
    print("[-] Scripts seems to be already installed, Uninstalling them for you...")
    os.remove("./KaoruHub")
end

print("[+] Creating Folders...")
for i = 1, #KaoruScripts["Folder"] do
    if (not exists("./"..v.."/")) then
        os.execute("powershell.exe mkdir \"".. io.popen("cd"):read() .. "/" .. v .. "\" > BootstrapperLogs.log")
        if i == 1 then 
            os.execute("powershell.exe explorer.exe ".. io.popen("cd"):read() .. "/" .. v"")
        end
    end
end

print("Download Files...")
for i, v in pairs(KaoruScripts["Scripts"]) do
    FileName = string.split(v[1], "/")[#string.split(v[1], "/")]
    if (not exists(io.popen("cd"):read() .. "/" .. v[2] .. "/" .. FileName)) then
        downloadFile(v[1], io.popen("cd"):read() .. "/" .. v[2] .. "/" .. FileName)
    end
end

print("Finished!")