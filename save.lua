savefile = {}

function savefile:init()
    self.states = {}
    self.stateIndexMap = {
        highscore = 0
    }
end

function savefile:__newindex(index, value)
    dset(self.stateIndexMap[index], value)
    printh('__newindex')
    self.states[index] = value
end

function savefile:__index(index)
    printh('__index')
    return self.states[index]
end