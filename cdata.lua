CData = {}

function CData:new(index_map)
    self._states = {}
    self._stateindexmap = index_map
    return setmetatable(self, self)
end

function CData:load(file_name)
    printh('Loading Data from File: ' .. file_name)

    cartdata(file_name)

    for k, v in pairs(self._stateindexmap) do
        local val = dget(k)
        if val then
            self._states[k] = val
        end
    end
end

function CData:__newindex(index, value)
    printh(index)
    printh('Save Text Index: ' .. index)
    printh('Save Index: ' .. self._stateindexmap[index])
    printh('Save Val: ' .. value)
    dset(self._stateindexmap[index], value)
    self._states[index] = value
end

function CData:__index(index)
    return self._states[index]
end