--[[

	bucket lua
	
	https://github.com/paigeroid/bucket-lua
	@paigeroid
	

]]


--< Module >--
local Bucket = {}
Bucket.__index = Bucket



--< New >--
function Bucket.new(array)

	-- create the new thing
	local self = setmetatable( {}, Bucket )
	local length = 0

	if array then
		for i, v in pairs(array) do
			local stuff
			local vl = 0
			local str = tostring(v)

			if type(v) == "table" then for _ in pairs(v) do vl = vl + 1 end end

			if string.sub(str,1,string.len("(("))=="((" then
				stuff = {
					Key = i,
					Value = v,
					Type = "uni"
				}

			elseif type(v) == "table" and vl == 1 then
				for Key, Value in pairs(v) do
					stuff = {
						Key = Key,
						Value = Value,
						Type = "pair"
					}
					break
				end
			else
				stuff = {
					Key = i,
					Value = v,
					Type = "uni"
				}
			end

			self[length+1] = stuff

			length = length + 1
		end
	end

	return self
end



--< Raw >--
function Bucket.raw(array)

	-- create the new thing
	local self = setmetatable( {}, Bucket )
	local length = 0

	if array then
		for i, v in pairs(array) do
			local stuff
			local vl = 0
			local str = tostring(v)

			if type(v) == "table" then for _ in pairs(v) do vl = vl + 1 end end
			
			
			stuff = {
				Key = i,
				Value = v,
				Type = "pair"
			}
			

			self[length+1] = stuff

			length = length + 1
		end
	end

	return self
end



--< Split >--
function Bucket.split(string, splitter)

	-- create the new thing
	local self = setmetatable( {}, Bucket )
	local length = 1
	
	if splitter == nil then
        splitter = "%s"
	end

	for str in string.gmatch(string, "([^"..splitter.."]+)") do
		local stuff
			
		stuff = {
			Key = length,
			Value = str,
			Type = "pair"
		}
			

		self[length] = stuff

		length = length + 1
	end

	return self
end



--< Length >--
function Bucket:Length()
	local length = 0
	for _ in pairs(self) do length = length + 1 end
	return length
end



--< Update >--
function Bucket:Update()
	local count = 1
	for i, v in pairs(self) do
		local key

		if type(v.Key) == "number" and v.Key ~= i and v.Type == "uni" then
			key = i
		else
			key = v.Key
		end

		self[count] = { Key = key, Value = v.Value, Type = v.Type }

		count = count + 1

	end
end



--< Push >--
function Bucket:Push(Entry)
	local index = self:Length() + 1
	local l = 0

	if type(Entry) == "table" then for _ in pairs(Entry) do l = l + 1 end end

	if type(Entry) == "table" and l == 1 then
		for Key, Value in pairs(Entry) do
			stuff = {
				Key = Key,
				Value = Value,
				Type = "pair"
			}
		end
	else
		stuff = {
			Key = index,
			Value = Entry,
			Type = "uni"
		}
	end

	table.insert(self, index, stuff)
	self:Update()
end



--< Pull >--
function Bucket:Pull(Entry)
	local l = 0
	if type(Entry) == "table" then for _ in pairs(Entry) do l = l + 1 end end

	if type(Entry) == "table" and l == 1 then
		for Key, Value in pairs(Entry) do
			stuff = {
				Key = Key,
				Value = Value,
				Type = "pair"
			}
		end
	else
		stuff = {
			Key = 1,
			Value = Entry,
			Type = "uni"
		}
	end

	table.insert(self, 1, stuff)
	self:Update()
end



--< Insert >--
function Bucket:Append(Index, Entry)
	local l = 0
	if type(Entry) == "table" then for _ in pairs(Entry) do l = l + 1 end end

	if type(Entry) == "table" and l == 1 then
		for Key, Value in pairs(Entry) do
			stuff = {
				Key = Key,
				Value = Value,
				Type = "pair"
			}
		end
	else
		stuff = {
			Key = Index,
			Value = Entry,
			Type = "uni"
		}
	end

	table.insert(self, Index, stuff)
	self:Update()
end



--< Get >--
function Bucket:Get(str)
	for i, v in pairs(self) do
		if v.Type == "pair" then
			if v.Key == str then
				return v.Value
			end
		else
			if v.Value == str then
				return v.Value
			end
		end
	end

	return nil
end



--< GetType >--
function Bucket:GetType(str)
	for i, v in pairs(self) do
		if v.Type == "pair" then
			if v.Key == str then
				return v.Type
			end
		else
			if v.Value == str then
				return v.Type
			end
		end
	end

	return nil
end



--< GetEntry >--
function Bucket:GetEntry(str)
	for i, v in pairs(self) do
		if v.Type == "pair" then
			if v.Key == str then
				return v
			end
		else
			if v.Value == str then
				return v
			end
		end
	end

	return nil
end



--< At >--
function Bucket:At(index)
	for i, v in pairs(self) do
		if i == index then
			return v.Value
		end
	end

	return nil
end



--< KeyAt >--
function Bucket:KeyAt(index)
	for i, v in pairs(self) do
		if i == index then
			return v.Key
		end
	end

	return nil
end



--< TypeAt >--
function Bucket:TypeAt(index)
	for i, v in pairs(self) do
		if i == index then
			return v.Type
		end
	end

	return nil
end



--< EntryAt >--
function Bucket:EntryAt(index)
	for i, v in pairs(self) do
		if i == index then
			return v
		end
	end

	return nil
end



--< First >--
function Bucket:First(Offset)
	if not Offset then Offset = 0 end

	local index = 1 + Offset

	for i, v in pairs(self) do
		if i == index then
			return v.Value
		end
	end

	return nil
end



--< FirstKey >--
function Bucket:FirstKey(Offset)
	if not Offset then Offset = 0 end

	local index = 1 + Offset

	for i, v in pairs(self) do
		if i == index then
			return v.Key
		end
	end

	return nil
end



--< FirstType >--
function Bucket:FirstType(Offset)
	if not Offset then Offset = 0 end

	local index = 1 + Offset

	for i, v in pairs(self) do
		if i == index then
			return v.Type
		end
	end

	return nil
end



--< FirstEntry >--
function Bucket:FirstEntry(Offset)
	if not Offset then Offset = 0 end

	local index = 1 + Offset

	for i, v in pairs(self) do
		if i == index then
			return v
		end
	end

	return nil
end



--< Last >--
function Bucket:Last(Offset)
	if not Offset then Offset = 0 end

	local index = self:Length() - Offset

	for i, v in pairs(self) do
		if i == index then
			return v.Value
		end
	end

	return nil
end



--< LastKey >--
function Bucket:LastKey(Offset)
	if not Offset then Offset = 0 end

	local index = self:Length() - Offset

	for i, v in pairs(self) do
		if i == index then
			return v.Key
		end
	end

	return nil
end



--< LastType >--
function Bucket:LastType(Offset)
	if not Offset then Offset = 0 end

	local index = self:Length() - Offset

	for i, v in pairs(self) do
		if i == index then
			return v.Type
		end
	end

	return nil
end



--< LastEntry >--
function Bucket:LastEntry(Offset)
	if not Offset then Offset = 0 end

	local index = self:Length() - Offset

	for i, v in pairs(self) do
		if i == index then
			return v
		end
	end

	return nil
end



--< Set >--
function Bucket:Set(Key, Value)
	for i, v in pairs(self) do
		if v.Type == "pair" then
			if v.Key == Key then
				self[i].Value = Value
				return
			end
		else
			if v.Value == Key then
				self[i].Value = Value
				return
			end
		end
	end
end



--< SetAt >--
function Bucket:SetAt(Index, Value)
	local before = self[Index].Value
	self[Index].Value = Value
	return before
end



--< Del >--
function Bucket:Del(Key)
	for i, v in pairs(self) do
		if v.Type == "pair" then
			if v.Key == Key then
				table.remove(self, i)
				break
			end
		else
			if v.Value == Key then
				table.remove(self, i)
				break
			end
		end
	end

	self:Update()
end



--< DelVal >--
function Bucket:DelVal(Value)
	for i, v in pairs(self) do
		if v.Value == Value then
			table.remove(self, i)
			break
		end
	end

	self:Update()
end



--< DelAt >--
function Bucket:DelAt(Index)
	for i, v in pairs(self) do
		if i == Index then
			table.remove(self, Index)
			break
		end
	end

	self:Update()
end



--< Pop >--
function Bucket:Pop(Offset)
	if not Offset then Offset = 0 end
	local index = self:Length() - Offset

	return self:DelAt(index)
end



--< Shift >--
function Bucket:Shift(Offset)
	if not Offset then Offset = 0 end
	local index = 1 + Offset

	return self:DelAt(index)
end



--< ForEach >--
function Bucket:ForEach(func)
	for i, v in pairs(self) do
		func(v.Key, v.Value, i, v.Type)
	end
end



--< tostring >--
function Bucket:__tostring()
	local thing = "(("

	self:ForEach(function(k, v, i, t)

		local str = tostring(v)
		local value

		-- if it's another bucket
		if string.sub(str,1,string.len("(("))=="((" then
			value = '( Bucket ('..v:Length().."x) )"

			-- if it's a string
		elseif type(v) == "string" then
			value = '"'..tostring(v)..'"'

			-- if it's a table
		elseif type(v) == "table" then
			local vl = 0
			for _ in pairs(v) do vl = vl + 1 end

			value = '{ Table ('..vl.."x) }"

			-- if it's none of those
		else
			value = tostring(v)
		end

		-- if it's a pair
		if t == "pair" then
			thing = thing.." [ *"..k.." => "..value.." ]"

			-- if it's just a normal entry
		else
			thing = thing.." "..value
		end

		if i < self:Length() then
			thing = thing..","
		end

	end)

	thing = thing.." ))"

	return thing
end
function Bucket:ToString()
	return tostring(self)
end



--< tonumber
function Bucket:__tonumber()
	return self:Length()
end



--< Join >--
function Bucket:Join(joiner)
	if not joiner then joiner = "," end

	local thing = ""

	self:ForEach(function(k, v, i, t)

		local value
		local str = tostring(v)

		-- if it's another bucket
		if string.sub(str,1,string.len("(("))=="((" then
			value = 'Bucket ('..v:Length().."x)"

			-- if it's a table
		elseif type(v) == "table" then
			local vl = 0
			for _ in pairs(v) do vl = vl + 1 end

			value = 'Table ('..vl.."x)"

			-- if it's none of those
		else
			value = tostring(v)
		end

		-- if it's a pair
		if t == "pair" then
			thing = thing.."*"..k.." => "..value

			-- if it's just a normal entry
		else
			thing = thing..value
		end

		if i < self:Length() then
			thing = thing..joiner
		end

	end)

	return thing
end


--< Every >--
function Bucket:Every(func)
	for i, v in pairs(self) do
		if not func(v.Key, v.Value, i, v.Type) then
			return false
		end
	end

	return true
end



--< Some >--
function Bucket:Some(func)
	for i, v in pairs(self) do
		if func(v.Key, v.Value, i, v.Type) then
			return true
		end
	end

	return false
end



--< Keys >--
function Bucket:Keys()
	local keys = {}

	for i, v in pairs(self) do
		table.insert(keys, v.Key)
	end

	return Bucket.new(keys)
end



--< Values >--
function Bucket:Values()
	local vals = {}

	for i, v in pairs(self) do
		table.insert(vals, v.Value)
	end

	return Bucket.new(vals)
end



--< Entries >--
function Bucket:Entries()
	local ents = {}

	for i, v in pairs(self) do
		table.insert(ents, v)
	end

	return Bucket.new(ents)
end



--< IndexOf >--
function Bucket:IndexOf(Key)
	for i, v in pairs(self) do
		if v.Type == "pair" then
			if v.Key == Key then
				return i
			end
		else
			if v.Value == Key then
				return i
			end
		end
	end

	return nil
end



--< IndexOf >--
function Bucket:IndexOfVal(Value)
	for i, v in pairs(self) do
		if v.Value == Value then
			return i
		end
	end

	return nil
end



--< LastIndexOf >--
function Bucket:LastIndexOf(Key)
	for i = self:Length(), 1, -1 do
		local v = self[i]

		if v.Type == "pair" then
			if v.Key == Key then
				return i
			end
		else
			if v.Value == Key then
				return i
			end
		end
	end

	return nil
end



--< LastIndexOf >--
function Bucket:LastIndexOfVal(Value)
	for i = self:Length(), 1, -1 do
		local v = self[i]

		if v.Value == Value then
			return i
		end
	end

	return nil
end



--< Has >--
function Bucket:Has(...)
	local args = {...}

	for _, Key in pairs(args) do
		for i, v in pairs(self) do
			if v.Type == "pair" then
				if v.Key == Key then
					return true
				end
			else
				if v.Value == Key then
					return true
				end
			end
		end
	end

	return false
end



--< HasVal >--
function Bucket:HasVal(...)
	local args = {...}

	for _, Value in pairs(args) do
		for i, v in pairs(self) do
			if v.Value == Value then
				return true
			end
		end
	end

	return false
end



--< StartsWith >--
function Bucket:StartsWith(...)
	local args = {...}

	for _, Key in pairs(args) do
		if self:FirstType() == "pair" then
			if self:FirstKey() == Key then
				return true
			end
		else
			if self:First() == Key then
				return true
			end
		end
	end

	return false
end



--< StartsWithVal >--
function Bucket:StartsWithVal(...)
	local args = {...}

	for _, Value in pairs(args) do
		if self:First() == Value then
			return true
		end
	end

	return false
end



---< EndsWith >--
function Bucket:EndsWith(...)
	local args = {...}

	for _, Key in pairs(args) do
		if self:LastType() == "pair" then
			if self:LastKey() == Key then
				return true
			end
		else
			if self:Last() == Key then
				return true
			end
		end
	end
end



--< EndsWithVal >--
function Bucket:EndsWithVal(...)
	local args = {...}

	for _, Value in pairs(args) do
		if self:Last() == Value then
			return true
		end
	end

	return false
end



--< Rename >--
function Bucket:Rename(Key, New)
	for i, v in pairs(self) do
		if v.Type == "pair" then
			if v.Key == Key then
				v.Key = New
				break
			end
		else
			if v.Key == Key then
				v.Key = New
				break
			end
		end
	end
end



--< RenameAt >--
function Bucket:RenameAt(Index, New)
	for i, v in pairs(self) do
		if i == Index then
			v.Key = New
			break
		end
	end
end



--< Pour >--
function Bucket:Pour()
	local thing = {}

	for i, v in pairs(self) do
		if v.Type == "uni" then
			thing[i] = v.Value
		else
			thing[i] = { [v.Key] = v.Value }
		end
	end

	return thing
end



--< Dump >--
function Bucket:Dump()
	local thing = {}
	
	self:ForEach(function(k, v)
		thing[k] = v
	end)
	

	return thing
end



--< Clone >--
function Bucket:Clone()
	return Bucket.new( self:Pour() )
end



--< Filter >--
function Bucket:Filter(func)
	local thing = Bucket.new()

	for i, v in pairs(self) do
		if func(v.Key, v.Value, i, v.Type) then
			if v.Type == "uni" then
				thing:Push(v.Value)
			else
				thing:Push({ [v.Key] = v.Value })
			end
		end
    end

	return thing
end



--< Reverse >--
function Bucket:Reverse()
	local thing = Bucket.new()

	for i = self:Length(), 1, -1 do
		local v = self[i]

		if v.Type == "uni" then
			thing:Push(v.Value)
		else
			thing:Push({ [v.Key] = v.Value })
		end
	end

	return thing
end



--< ForBack >--
function Bucket:ForBack(func)
	local stuff = Bucket.new()

	for i, v in pairs(self) do
		local thing = func(v.Key, v.Value, i, v.Type)

		if thing then
			stuff:Push(thing)
		end
	end

	return stuff
end



--< Map >--
function Bucket:Map(func)
	local clone = self:Clone()

	clone:ForEach(function(k, v, i, t)
		local thing = func(k, v, i, t)

		clone:SetAt(i, thing)
	end)

	return clone
end



--< Map >--
function Bucket:MapKeys(func)
	local clone = self:Clone()

	clone:ForEach(function(k, v, i, t)
		local thing = func(k, v, i, t)

		clone:RenameAt(i, thing)
	end)

	return clone
end



--< Is >--
function Bucket.is(tbl)
    local str = tostring(tbl)
    
    return string.sub(str,1,string.len("(("))=="(("
end



--< Merge >--
function Bucket:Merge(...)
    local clone = self:Clone()
    local args = Bucket.new({...})
    
    args:ForEach(function(k0, v0)
        if Bucket.is(v0) then
            v0:ForEach(function(k1, v1, i, t)
                if t == "uni" then
                    clone:Push(v1)
                else
                    clone:Push({ [k1] = v1 })
                end
            end)
        elseif type(v0) == "table" then
            v0 = Bucket.new(v0)
            
            v0:ForEach(function(k1, v1, i, t)
                if t == "uni" then
                    clone:Push(v1)
                else
                    clone:Push({ [k1] = v1 })
                end
            end)
        end
    end)

    return clone
end



--< Sort >--
function Bucket:Sort(func)
    local new = Bucket.new()
    
    if not func then
        func = function(a, b)
            return a < b
        end
    end


    local strings = self:Filter(function(k, v, i, t)
        if t == "uni" and type(v) == "string" then return true
        elseif t == "pair" and type(k) == "string" then return true
        else return false end
    end)
    
    local numbers = self:Filter(function(k, v, i, t)
        if t == "uni" and type(v) == "number" then return true
        elseif t == "pair" and type(k) == "number" then return true
        else return false end
    end)
    
    
    table.sort(strings, function(a, b)
        local aValue, bValue
        
        if a.Type == "uni" then aValue = a.Value
        else aValue = a.Key end
        if b.Type == "uni" then bValue = b.Value
        else bValue = b.Key end
        
        return func(aValue, bValue)
    end)
    
    table.sort(numbers, function(a, b)
        local aValue, bValue
        
        if a.Type == "uni" then aValue = a.Value
        else aValue = a.Key end
        if b.Type == "uni" then bValue = b.Value
        else bValue = b.Key end
        
        return func(aValue, bValue)
    end)
    
    return strings:Merge(numbers)
end



--< ToLowerCase >--
function Bucket:ToLowerCase(...)
    local clone = self:Clone()
    local args = Bucket.new({...})
    
    clone = clone:Map(function(k, v, i, t)
        if args:Length() > 0 then
            if args:Has(i) and type(v) == "string" then
                return v:lower()
            else
                return v
            end
        elseif type(v) == "string" then
            return v:lower()
        else
            return v
        end
    end)

    return clone
end



--< ToUpperCase >--
function Bucket:ToUpperCase(...)
    local clone = self:Clone()
    local args = Bucket.new({...})
    
    clone = clone:Map(function(k, v, i, t)
        if args:Length() > 0 then
            if args:Has(i) and type(v) == "string" then
                return v:upper()
            else
                return v
            end
        elseif type(v) == "string" then
            return v:upper()
        else
            return v
        end
    end)

    return clone
end



--< Replace >--
function Bucket:Replace(x, y)
	local clone = self:Clone()
	
	for i, v in pairs(clone) do
		if type(v.Key) == "string" then
			local r = v.Key:gsub(x, y)
			clone:RenameAt(i, r)
		end
		
		if type(v.Value) == "string" then
			local r = v.Value:gsub(x, y)
			clone:SetAt(i, r)
		end
	end
	
	return clone
end



--< ReplaceKeys >--
function Bucket:ReplaceKeys(x, y)
	local clone = self:Clone()
	
	for i, v in pairs(clone) do
		if type(v.Key) == "string" then
			local r = v.Key:gsub(x, y)
			clone:RenameAt(i, r)
		end
	end
	
	return clone
end



--< ReplaceValues >--
function Bucket:ReplaceVals(x, y)
	local clone = self:Clone()
	
	for i, v in pairs(clone) do
		if type(v.Value) == "string" then
			local r = v.Value:gsub(x, y)
			clone:SetAt(i, r)
		end
	end
	
	return clone
end



--< SortBy >--
function Bucket:SortBy(tbl, func)
	local clone = self:Clone()
	
	if not func then
        func = function(a, b)
            return a < b
        end
	end
	
	local stuff = Bucket.new()
	
	if not Bucket.is(tbl) then
	    tbl = Bucket.new(tbl)
	end
	
	tbl:Sort(function(a, b)
		stuff:Push( func(a, b) )
		return func(a, b)
	end)
	
	local i = 1
	
	return clone:Sort(function()
		local thing = stuff:At(i)
		i = i+1
		
		return thing
	end)
end



return Bucket
