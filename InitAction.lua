local EXPOS = {}

EXPOS.dumpTable = function(tbl,ind)
    if type(tbl) ~= "table" then
        print(tbl)
        return
    end
    ind = ind or 0
    
    local indent = string.rep('    ',ind)
    
    for k,v in pairs(tbl) do
        if (type(v) == "table") then
            print(indent,k,"= {")
            EXPOS.dumpTable(v,ind+1)
            print(indent,"}")
        else
            print(indent,k,"=",v)
        end
    end
    
    return
end

EXPOS.ShortenScore = function(score)
    score = math.floor((score + 50) / 100)
    return score / 10.0 .. "k"
end

EXPOS.GetColorString = function(score)
    local r, b, g = EXPOS.GetScoreColor(score);
    local rString = string.format("%x", 255*r)
    local bString = string.format("%x", 255*b)
    local gString = string.format("%x", 255*g)
    
    if r*255 <= 15 then
        rString = rString .. "0"
    end
    
    if b*255 <= 15 then
        bString = bString .. "0"
    end
    
    if g*255 <= 15 then
        gString = gString .. "0"
    end
    
    local color = string.format("\124cff%s%s%s", rString, bString, gString)
    return color
end

EXPOS.GetScoreColor = function(score)
    local colors = {
        [1] = { ["score"] = 3000, ["color"]= { 1.00, 0.50, 0.00 } },
        [2] = { ["score"] = 2800, ["color"]= { 0.64, 0.21, 0.93 } },
        [3] = { ["score"] = 2000, ["color"]= { 0.00, 0.44, 0.87 } },
        [4] = { ["score"] = 1760, ["color"]= { 0.12, 1.00, 0.00 } },
        [5] = { ["score"] = 1600, ["color"]= { 1.00, 1.00, 1.00 } },
    }
    
    for i = 1, #colors do
        local tier = colors[i]
        if score >= tier.score then
            return tier.color[1], tier.color[2], tier.color[3]
        end
    end
    
    
    -- fallback to gray color if nothing else returned anything
    return 0.62, 0.62, 0.62
end

EXPOS.getScore = function(mScore)
    local mplusCurrent = 0;
    local maxScore = 0;
    
    if mScore and mScore > 0 then
        mplusCurrent = mScore --EXPOS.ExpoCorrect(mScore)
    end
    
    return mplusCurrent
end


EXPOS.chIdToName = function(id)
    local name = C_ChallengeMode.GetMapUIInfo(id);
    
    return name
end

-- tooltip
aura_env.OnTooltipSetUnit = function(self)
    local unitName,unit = self:GetUnit()
    
    if not unit then return end
    
    if UnitAffectingCombat("player") then return end
    
    if (UnitIsPlayer(unit)) then    
        local data = C_PlayerInfo.GetPlayerMythicPlusRatingSummary(unit)
        local seasonScore = data and data.currentSeasonScore
        
        local mplusCurrent = EXPOS.getScore(seasonScore) 
        self:AddDoubleLine("----- M+ Score ------", mplusCurrent, 1, 1, 1, EXPOS.GetScoreColor(mplusCurrent))
        
        local runs = data and data.runs
        if runs then
            for index,run in pairs(runs) do
                local name = "  " .. EXPOS.chIdToName(run.challengeModeID)
                if run.finishedSuccess then
                    self:AddDoubleLine(name, run.bestRunLevel , 0, 1, 0.75, 0, 1, 0)
                else
                    self:AddDoubleLine(name, run.bestRunLevel , 0, 1, 0.75, 1, 0, 0)
                end
            end
        end
        self:AddLine("------------------------", 1, 1, 1) 
    end
end
-- lfg tool: admin
aura_env.UpdateApplicantMember = function(member, appID, memberIdx, status, pendingStatus)
    local _, _, _, _, _, _, _, _, _, _, _, dungeonScore = C_LFGList.GetApplicantMemberInfo(appID, memberIdx);
    
    local mplusCurrent = EXPOS.getScore(dungeonScore);
    member.Rating:SetText(EXPOS.GetColorString(mplusCurrent) .. mplusCurrent);  
    member.Rating:Show();
    member:SetWidth(256);
end

-- lfg tool: search
aura_env.SearchEntry_Update = function(group)
    local searchResultInfo = C_LFGList.GetSearchResultInfo(group.resultID)
    
    local activityTable = C_LFGList.GetActivityInfoTable(searchResultInfo.activityIDs[1], nil, searchResultInfo.isWarMode);
    if ( activityTable.isMythicPlusActivity and searchResultInfo.leaderOverallDungeonScore) then 
        local mplusCurrent = EXPOS.getScore(searchResultInfo.leaderOverallDungeonScore)
        local oldText = group.Name:GetText()
        local newGrpText = string.format("%s %s\124r  %s", EXPOS.GetColorString(mplusCurrent), mplusCurrent, oldText);
        group.Name:SetText(newGrpText)
    end 
end

--- bind hook
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, aura_env.OnTooltipSetUnit)
hooksecurefunc("LFGListApplicationViewer_UpdateApplicantMember", aura_env.UpdateApplicantMember)
hooksecurefunc("LFGListSearchEntry_Update", aura_env.SearchEntry_Update)
