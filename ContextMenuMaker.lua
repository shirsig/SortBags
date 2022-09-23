-- #########################################################################################
-- #####    CONTEXT MENU MAKER https://wowpedia.fandom.com/wiki/Context_Menu_Maker     #####
-- ######################################################################################### 

-- Set to false to use file-scoped variables or true to use the new addon-scoped variables

local useAddonScope = true
local addonName, MenuClass

if useAddonScope then
    addonName, MenuClass = ...
else
    addonName, MenuClass = "--your addon's name--", {}
end

function MenuClass:New()
    local ret = {}
    
    -- set the defaults
    ret.menuList = {}
    ret.anchor = 'cursor'; -- default at the cursor
    ret.x = nil;
    ret.y = nil;
    ret.displayMode = 'MENU'; -- default
    ret.autoHideDelay = nil;
    ret.menuFrame = nil; -- If not defined, :Show() will create a generic menu frame
    ret.uniqueID = 1

    -- import the functions
    for k,v in pairs(self) do
        ret[k] = v
    end
    
    -- return a copy of the class
    return ret
end

--[[
    Return the index where "text" lives.
    ; text : The text to search for.
--]]
function MenuClass:GetItemByText(text)
    for k,v in pairs(self.menuList) do
        if v.text == text then
            return k
        end
    end
end
function MenuClass:UpdateMenuItem(old_text, new_text)
    for k,v in pairs(self.menuList) do
        if v.text == old_text then
            v.text = new_text
	    return
        end
    end
end

--[[
    Add menu items
    ; text : The display text.
    ; func : The function to execute OnClick.
    ; isTitle : 1 if this is a header (usually the first one)
    ; otherAttributes : table - { ["attribute"] = value, }
    returns the last index of the menu item that was just added.
--]]
function MenuClass:AddItem(text, func, isTitle, otherAttributes)
    local info = {}
    
    info["text"] = text
    info["isTitle"] = isTitle
    info["func"] = func
    
    if type(otherAttributes) == "table" then
        for attribute, value in pairs(otherAttributes) do
            info[attribute] = value
        end
    end

    table.insert(self.menuList, info)
    return #self.menuList
end

--[[
    Set an attribute for the menu item.
    Valid attributes are found in the FrameXML\UIDropDownMenu.lua file with their valid values.
    Arbitrary non-official attributes are allowed, but are only useful if you plan to access them with :GetAttribute().
    ; text : The text of the menu item or index of the menu item.
    ; attribute : Set this attribute to "value".
    ; value : The value to set the attribute to.
--]]
function MenuClass:SetAttribute(text, attribute, value)
    self.menuList[self:GetItemByText(text) or (self.menuList[text] and text) or 1][attribute or "uniqueID"] = value
end

--[[
    Get an attribute for the menu item.
    Valid attributes are found in the FrameXML\UIDropDownMenu.lua file with their valid values or any arbitrary attribute set with :SetAttribute().
    ; text : The text of the menu item or index of the menu item.
    ; attribute : Get this attribute.
--]]
function MenuClass:GetAttribute(text, attribute)
    return self.menuList[self:GetItemByText(text) or (self.menuList[text] and text) or 1][attribute or "uniqueID"]
end

--[[
    Remove the first item matching "text"
    ; text : The text to search for.
--]]
function MenuClass:RemoveItem(text)
    table.remove(self.menuList, self:GetItemByText(text))
end


--[[
    ; anchor : Set the anchor point. 
--]]
function MenuClass:SetAnchor(anchor)
    if anchor ~= 'cursor' then
        self.x = 0
        self.y = 0
    end
    self.anchor = anchor
end

--[[
    ; displayMode : "MENU"
--]]
function MenuClass:SetDisplayMode(displayMode)
    self.displayMode = displayMode
end

--[[
    ; autoHideDelay : How long, without a click, before the menu goes away.
--]]
function MenuClass:SetAutoHideDelay(autoHideDelay)
    self.autoHideDelay = tonumber(autoHideDelay)
end

--[[
    ; menuFrame : Should inherit a Drop Down Menu template.
--]]
function MenuClass:SetMenuFrame(menuFrame)
    self.menuFrame = menuFrame
end

function MenuClass:GetMenuList()
    return self.menuList
end

--[[
    ; x : X position
    ; save : When not nil, will add to the current value rather than replace it
--]]
function MenuClass:SetX(x, save)
    if save then
        self.x = self.x + x
    else
        self.x = x
    end
end

--[[
    ; y : Y position
    ; save : When not nil, will add to the current value rather than replace it
--]]
function MenuClass:SetY(y, save)
    if save then
        self.y = self.y + y
    else
        self.y = y
    end
end

function MenuClass:Activate()
    if not self.menuFrame then
        while _G['GenericMenuClassFrame'..self.uniqueID] do -- ensure that there's no namespace collisions
            self.uniqueID = self.uniqueID + 1
        end
        -- the frame must be named for some reason
        self.menuFrame = CreateFrame('Frame', 'GenericMenuClassFrame'..self.uniqueID, UIParent, "UIDropDownMenuTemplate")
    end
    self.menuFrame.menuList = self.menuList
end

--[[
    Show the menu.
--]]
function MenuClass:Show()
    self:Activate()
    EasyMenu(self.menuList, self.menuFrame, self.anchor, self.x, self.y, self.displayMode, self.autoHideDelay)
end

-- If you're not using the addon-scoped variables, you must have a global variable in order to use this menu.
if not useAddonScope then
    _G[addonName.."Menu"] = MenuClass
end

-- #########################################################################################
-- ##### END OF CONTEXT MENU MAKER https://wowpedia.fandom.com/wiki/Context_Menu_Maker #####
-- ######################################################################################### 