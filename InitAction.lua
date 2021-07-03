local EXPOS = {}


EXPOS.S1correct = function(score)
    local scoreExpo = 4.379*(10^-7)*(score^3)-0.001542*(score^2)+2.4*score-859.2
    score = tonumber(string.format("%." .. 0 .. "f", scoreExpo))
    return score > 0 and score or 0
end

EXPOS.ExpoCorrect = function(score)
    if score <= 0 then return score end;
    local scoreExpo = 3.18*(10^-7)*(score^3)-0.0006889*(score^2)+0.9659*score+447.4
    score = tonumber(string.format("%." .. 0 .. "f", scoreExpo))
    return score > 0 and score or 0
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
        [1] = { ["score"] = 3575, ["color"] = { 1.00, 0.50, 0.00 } },        -- |cffff80003575+|r
        [2] = { ["score"] = 3465, ["color"] = { 1.00, 0.50, 0.04 } },        -- |cffff7f0b3465+|r
        [3] = { ["score"] = 3440, ["color"] = { 1.00, 0.49, 0.08 } },        -- |cfffe7e143440+|r
        [4] = { ["score"] = 3420, ["color"] = { 1.00, 0.49, 0.10 } },        -- |cfffe7d1a3420+|r
        [5] = { ["score"] = 3395, ["color"] = { 0.99, 0.49, 0.12 } },        -- |cfffd7c1f3395+|r
        [6] = { ["score"] = 3370, ["color"] = { 0.99, 0.48, 0.14 } },        -- |cfffd7b243370+|r
        [7] = { ["score"] = 3345, ["color"] = { 0.99, 0.48, 0.16 } },        -- |cfffc7a283345+|r
        [8] = { ["score"] = 3320, ["color"] = { 0.99, 0.48, 0.17 } },        -- |cfffc7a2c3320+|r
        [9] = { ["score"] = 3300, ["color"] = { 0.98, 0.47, 0.19 } },        -- |cfffb79303300+|r
        [10] = { ["score"] = 3275, ["color"] = { 0.98, 0.47, 0.20 } },        -- |cfffa78343275+|r
        [11] = { ["score"] = 3250, ["color"] = { 0.98, 0.47, 0.22 } },        -- |cfffa77373250+|r
        [12] = { ["score"] = 3225, ["color"] = { 0.98, 0.46, 0.23 } },        -- |cfff9763a3225+|r
        [13] = { ["score"] = 3200, ["color"] = { 0.98, 0.46, 0.24 } },        -- |cfff9753e3200+|r
        [14] = { ["score"] = 3180, ["color"] = { 0.97, 0.45, 0.25 } },        -- |cfff874413180+|r
        [15] = { ["score"] = 3155, ["color"] = { 0.97, 0.45, 0.27 } },        -- |cfff873443155+|r
        [16] = { ["score"] = 3130, ["color"] = { 0.97, 0.45, 0.28 } },        -- |cfff772473130+|r
        [17] = { ["score"] = 3105, ["color"] = { 0.96, 0.44, 0.29 } },        -- |cfff671493105+|r
        [18] = { ["score"] = 3080, ["color"] = { 0.96, 0.44, 0.30 } },        -- |cfff6704c3080+|r
        [19] = { ["score"] = 3060, ["color"] = { 0.96, 0.44, 0.31 } },        -- |cfff56f4f3060+|r
        [20] = { ["score"] = 3035, ["color"] = { 0.96, 0.43, 0.32 } },        -- |cfff56e523035+|r
        [21] = { ["score"] = 3010, ["color"] = { 0.96, 0.43, 0.33 } },        -- |cfff46d543010+|r
        [22] = { ["score"] = 2985, ["color"] = { 0.95, 0.43, 0.34 } },        -- |cfff36d572985+|r
        [23] = { ["score"] = 2960, ["color"] = { 0.95, 0.42, 0.35 } },        -- |cfff36c5a2960+|r
        [24] = { ["score"] = 2940, ["color"] = { 0.95, 0.42, 0.36 } },        -- |cfff26b5c2940+|r
        [25] = { ["score"] = 2915, ["color"] = { 0.95, 0.42, 0.37 } },        -- |cfff16a5f2915+|r
        [26] = { ["score"] = 2890, ["color"] = { 0.95, 0.41, 0.38 } },        -- |cfff169612890+|r
        [27] = { ["score"] = 2865, ["color"] = { 0.94, 0.41, 0.39 } },        -- |cfff068642865+|r
        [28] = { ["score"] = 2840, ["color"] = { 0.94, 0.40, 0.40 } },        -- |cffef67662840+|r
        [29] = { ["score"] = 2820, ["color"] = { 0.93, 0.40, 0.41 } },        -- |cffee66692820+|r
        [30] = { ["score"] = 2795, ["color"] = { 0.93, 0.40, 0.42 } },        -- |cffee656b2795+|r
        [31] = { ["score"] = 2770, ["color"] = { 0.93, 0.39, 0.43 } },        -- |cffed646e2770+|r
        [32] = { ["score"] = 2745, ["color"] = { 0.93, 0.39, 0.44 } },        -- |cffec63702745+|r
        [33] = { ["score"] = 2720, ["color"] = { 0.92, 0.38, 0.45 } },        -- |cffeb62732720+|r
        [34] = { ["score"] = 2700, ["color"] = { 0.92, 0.38, 0.46 } },        -- |cffeb61752700+|r
        [35] = { ["score"] = 2675, ["color"] = { 0.92, 0.38, 0.47 } },        -- |cffea60772675+|r
        [36] = { ["score"] = 2650, ["color"] = { 0.91, 0.37, 0.48 } },        -- |cffe95f7a2650+|r
        [37] = { ["score"] = 2625, ["color"] = { 0.91, 0.37, 0.49 } },        -- |cffe85f7c2625+|r
        [38] = { ["score"] = 2600, ["color"] = { 0.91, 0.37, 0.50 } },        -- |cffe75e7f2600+|r
        [39] = { ["score"] = 2580, ["color"] = { 0.90, 0.36, 0.51 } },        -- |cffe65d812580+|r
        [40] = { ["score"] = 2555, ["color"] = { 0.90, 0.36, 0.51 } },        -- |cffe55c832555+|r
        [41] = { ["score"] = 2530, ["color"] = { 0.90, 0.36, 0.53 } },        -- |cffe55b862530+|r
        [42] = { ["score"] = 2505, ["color"] = { 0.89, 0.35, 0.53 } },        -- |cffe45a882505+|r
        [43] = { ["score"] = 2480, ["color"] = { 0.89, 0.35, 0.55 } },        -- |cffe3598b2480+|r
        [44] = { ["score"] = 2460, ["color"] = { 0.89, 0.35, 0.55 } },        -- |cffe2588d2460+|r
        [45] = { ["score"] = 2435, ["color"] = { 0.88, 0.34, 0.56 } },        -- |cffe1578f2435+|r
        [46] = { ["score"] = 2410, ["color"] = { 0.88, 0.34, 0.57 } },        -- |cffe056922410+|r
        [47] = { ["score"] = 2385, ["color"] = { 0.87, 0.33, 0.58 } },        -- |cffdf55942385+|r
        [48] = { ["score"] = 2360, ["color"] = { 0.87, 0.33, 0.59 } },        -- |cffde54962360+|r
        [49] = { ["score"] = 2340, ["color"] = { 0.87, 0.33, 0.60 } },        -- |cffdd53992340+|r
        [50] = { ["score"] = 2315, ["color"] = { 0.86, 0.33, 0.61 } },        -- |cffdc539b2315+|r
        [51] = { ["score"] = 2290, ["color"] = { 0.85, 0.32, 0.62 } },        -- |cffda529d2290+|r
        [52] = { ["score"] = 2265, ["color"] = { 0.85, 0.32, 0.63 } },        -- |cffd951a02265+|r
        [53] = { ["score"] = 2240, ["color"] = { 0.85, 0.31, 0.64 } },        -- |cffd850a22240+|r
        [54] = { ["score"] = 2220, ["color"] = { 0.84, 0.31, 0.65 } },        -- |cffd74fa52220+|r
        [55] = { ["score"] = 2195, ["color"] = { 0.84, 0.31, 0.65 } },        -- |cffd64ea72195+|r
        [56] = { ["score"] = 2170, ["color"] = { 0.84, 0.30, 0.66 } },        -- |cffd54da92170+|r
        [57] = { ["score"] = 2145, ["color"] = { 0.83, 0.30, 0.67 } },        -- |cffd34cac2145+|r
        [58] = { ["score"] = 2120, ["color"] = { 0.82, 0.29, 0.68 } },        -- |cffd24bae2120+|r
        [59] = { ["score"] = 2100, ["color"] = { 0.82, 0.29, 0.69 } },        -- |cffd14ab02100+|r
        [60] = { ["score"] = 2075, ["color"] = { 0.82, 0.29, 0.70 } },        -- |cffd04ab32075+|r
        [61] = { ["score"] = 2050, ["color"] = { 0.81, 0.29, 0.71 } },        -- |cffce49b52050+|r
        [62] = { ["score"] = 2025, ["color"] = { 0.80, 0.28, 0.72 } },        -- |cffcd48b72025+|r
        [63] = { ["score"] = 2000, ["color"] = { 0.80, 0.28, 0.73 } },        -- |cffcb47ba2000+|r
        [64] = { ["score"] = 1980, ["color"] = { 0.79, 0.27, 0.74 } },        -- |cffca46bc1980+|r
        [65] = { ["score"] = 1955, ["color"] = { 0.79, 0.27, 0.75 } },        -- |cffc945be1955+|r
        [66] = { ["score"] = 1930, ["color"] = { 0.78, 0.27, 0.76 } },        -- |cffc744c11930+|r
        [67] = { ["score"] = 1905, ["color"] = { 0.78, 0.26, 0.76 } },        -- |cffc643c31905+|r
        [68] = { ["score"] = 1880, ["color"] = { 0.77, 0.26, 0.77 } },        -- |cffc443c51880+|r
        [69] = { ["score"] = 1860, ["color"] = { 0.76, 0.26, 0.78 } },        -- |cffc242c81860+|r
        [70] = { ["score"] = 1835, ["color"] = { 0.76, 0.25, 0.79 } },        -- |cffc141ca1835+|r
        [71] = { ["score"] = 1810, ["color"] = { 0.75, 0.25, 0.80 } },        -- |cffbf40cd1810+|r
        [72] = { ["score"] = 1785, ["color"] = { 0.74, 0.25, 0.81 } },        -- |cffbd3fcf1785+|r
        [73] = { ["score"] = 1760, ["color"] = { 0.74, 0.24, 0.82 } },        -- |cffbc3ed11760+|r
        [74] = { ["score"] = 1740, ["color"] = { 0.73, 0.24, 0.83 } },        -- |cffba3ed41740+|r
        [75] = { ["score"] = 1715, ["color"] = { 0.72, 0.24, 0.84 } },        -- |cffb83dd61715+|r
        [76] = { ["score"] = 1690, ["color"] = { 0.71, 0.24, 0.85 } },        -- |cffb63cd81690+|r
        [77] = { ["score"] = 1665, ["color"] = { 0.71, 0.23, 0.86 } },        -- |cffb43bdb1665+|r
        [78] = { ["score"] = 1640, ["color"] = { 0.70, 0.23, 0.87 } },        -- |cffb23add1640+|r
        [79] = { ["score"] = 1620, ["color"] = { 0.69, 0.23, 0.88 } },        -- |cffb03ae01620+|r
        [80] = { ["score"] = 1595, ["color"] = { 0.68, 0.22, 0.89 } },        -- |cffae39e21595+|r
        [81] = { ["score"] = 1570, ["color"] = { 0.67, 0.22, 0.89 } },        -- |cffac38e41570+|r
        [82] = { ["score"] = 1545, ["color"] = { 0.67, 0.22, 0.91 } },        -- |cffaa37e71545+|r
        [83] = { ["score"] = 1520, ["color"] = { 0.66, 0.21, 0.91 } },        -- |cffa836e91520+|r
        [84] = { ["score"] = 1500, ["color"] = { 0.65, 0.21, 0.93 } },        -- |cffa536ec1500+|r
        [85] = { ["score"] = 1475, ["color"] = { 0.64, 0.21, 0.93 } },        -- |cffa335ee1475+|r
        [86] = { ["score"] = 1445, ["color"] = { 0.59, 0.26, 0.93 } },        -- |cff9643ec1445+|r
        [87] = { ["score"] = 1420, ["color"] = { 0.53, 0.31, 0.91 } },        -- |cff884ee91420+|r
        [88] = { ["score"] = 1395, ["color"] = { 0.47, 0.34, 0.91 } },        -- |cff7957e71395+|r
        [89] = { ["score"] = 1370, ["color"] = { 0.41, 0.37, 0.89 } },        -- |cff695ee41370+|r
        [90] = { ["score"] = 1345, ["color"] = { 0.33, 0.40, 0.89 } },        -- |cff5565e21345+|r
        [91] = { ["score"] = 1325, ["color"] = { 0.23, 0.42, 0.87 } },        -- |cff3b6bdf1325+|r
        [92] = { ["score"] = 1300, ["color"] = { 0.00, 0.44, 0.87 } },        -- |cff0070dd1300+|r
        [93] = { ["score"] = 1250, ["color"] = { 0.15, 0.46, 0.84 } },        -- |cff2576d71250+|r
        [94] = { ["score"] = 1230, ["color"] = { 0.20, 0.49, 0.82 } },        -- |cff347cd01230+|r
        [95] = { ["score"] = 1205, ["color"] = { 0.25, 0.51, 0.79 } },        -- |cff3f82ca1205+|r
        [96] = { ["score"] = 1180, ["color"] = { 0.28, 0.53, 0.77 } },        -- |cff4788c41180+|r
        [97] = { ["score"] = 1155, ["color"] = { 0.31, 0.56, 0.74 } },        -- |cff4e8ebd1155+|r
        [98] = { ["score"] = 1130, ["color"] = { 0.33, 0.58, 0.72 } },        -- |cff5394b71130+|r
        [99] = { ["score"] = 1110, ["color"] = { 0.34, 0.60, 0.69 } },        -- |cff579ab11110+|r
        [100] = { ["score"] = 1085, ["color"] = { 0.35, 0.63, 0.67 } },        -- |cff5aa0aa1085+|r
        [101] = { ["score"] = 1060, ["color"] = { 0.36, 0.65, 0.64 } },        -- |cff5ca6a31060+|r
        [102] = { ["score"] = 1035, ["color"] = { 0.37, 0.67, 0.61 } },        -- |cff5eac9c1035+|r
        [103] = { ["score"] = 1010, ["color"] = { 0.37, 0.70, 0.58 } },        -- |cff5fb3951010+|r
        [104] = { ["score"] = 990, ["color"] = { 0.37, 0.73, 0.56 } },        -- |cff5fb98e990+|r
        [105] = { ["score"] = 965, ["color"] = { 0.37, 0.75, 0.53 } },        -- |cff5fbf87965+|r
        [106] = { ["score"] = 940, ["color"] = { 0.37, 0.77, 0.50 } },        -- |cff5ec57f940+|r
        [107] = { ["score"] = 915, ["color"] = { 0.36, 0.80, 0.47 } },        -- |cff5ccc78915+|r
        [108] = { ["score"] = 890, ["color"] = { 0.35, 0.82, 0.44 } },        -- |cff5ad26f890+|r
        [109] = { ["score"] = 870, ["color"] = { 0.34, 0.85, 0.40 } },        -- |cff57d867870+|r
        [110] = { ["score"] = 845, ["color"] = { 0.32, 0.87, 0.36 } },        -- |cff52df5d845+|r
        [111] = { ["score"] = 820, ["color"] = { 0.30, 0.90, 0.33 } },        -- |cff4de553820+|r
        [112] = { ["score"] = 795, ["color"] = { 0.27, 0.93, 0.28 } },        -- |cff46ec47795+|r
        [113] = { ["score"] = 770, ["color"] = { 0.24, 0.95, 0.23 } },        -- |cff3df23a770+|r
        [114] = { ["score"] = 750, ["color"] = { 0.19, 0.98, 0.15 } },        -- |cff31f927750+|r
        [115] = { ["score"] = 725, ["color"] = { 0.12, 1.00, 0.00 } },        -- |cff1eff00725+|r
        [116] = { ["score"] = 700, ["color"] = { 0.25, 1.00, 0.15 } },        -- |cff3fff26700+|r
        [117] = { ["score"] = 675, ["color"] = { 0.33, 1.00, 0.22 } },        -- |cff53ff39675+|r
        [118] = { ["score"] = 650, ["color"] = { 0.39, 1.00, 0.28 } },        -- |cff63ff48650+|r
        [119] = { ["score"] = 625, ["color"] = { 0.44, 1.00, 0.33 } },        -- |cff71ff55625+|r
        [120] = { ["score"] = 600, ["color"] = { 0.49, 1.00, 0.38 } },        -- |cff7dff61600+|r
        [121] = { ["score"] = 575, ["color"] = { 0.54, 1.00, 0.42 } },        -- |cff89ff6c575+|r
        [122] = { ["score"] = 550, ["color"] = { 0.58, 1.00, 0.47 } },        -- |cff93ff77550+|r
        [123] = { ["score"] = 525, ["color"] = { 0.62, 1.00, 0.51 } },        -- |cff9dff81525+|r
        [124] = { ["score"] = 500, ["color"] = { 0.65, 1.00, 0.55 } },        -- |cffa6ff8c500+|r
        [125] = { ["score"] = 475, ["color"] = { 0.69, 1.00, 0.59 } },        -- |cffafff96475+|r
        [126] = { ["score"] = 450, ["color"] = { 0.72, 1.00, 0.62 } },        -- |cffb7ff9f450+|r
        [127] = { ["score"] = 425, ["color"] = { 0.75, 1.00, 0.66 } },        -- |cffbfffa9425+|r
        [128] = { ["score"] = 400, ["color"] = { 0.78, 1.00, 0.70 } },        -- |cffc7ffb3400+|r
        [129] = { ["score"] = 375, ["color"] = { 0.81, 1.00, 0.74 } },        -- |cffcfffbc375+|r
        [130] = { ["score"] = 350, ["color"] = { 0.84, 1.00, 0.78 } },        -- |cffd6ffc6350+|r
        [131] = { ["score"] = 325, ["color"] = { 0.87, 1.00, 0.82 } },        -- |cffddffd0325+|r
        [132] = { ["score"] = 300, ["color"] = { 0.89, 1.00, 0.85 } },        -- |cffe4ffd9300+|r
        [133] = { ["score"] = 275, ["color"] = { 0.92, 1.00, 0.89 } },        -- |cffebffe3275+|r
        [134] = { ["score"] = 250, ["color"] = { 0.95, 1.00, 0.93 } },        -- |cfff2ffec250+|r
        [135] = { ["score"] = 225, ["color"] = { 0.98, 1.00, 0.96 } },        -- |cfff9fff6225+|r
        [136] = { ["score"] = 200, ["color"] = { 1.00, 1.00, 1.00 } },        -- |cffffffff200+|r
    }
    
    -- otherwise we use regular color table
    for i = 1, #colors do
        local tier = colors[i]
        if score >= tier.score then
            return tier.color[1], tier.color[2], tier.color[3]
        end
    end
    -- fallback to gray color if nothing else returned anything
    return 0.62, 0.62, 0.62
end


-- tooltip
aura_env.OnTooltipSetUnit = function(self)
    local _, unit = self:GetUnit()
    if not unit then return end
    
    if (UnitIsPlayer(unit)) then
        local data = C_PlayerInfo.GetPlayerMythicPlusRatingSummary(unit)
        local seasonScore = data and data.currentSeasonScore
        
        if seasonScore and seasonScore > 0 then
            local s1Score = EXPOS.S1correct(seasonScore)
            local epxoScore = EXPOS.ExpoCorrect(seasonScore)
            
            self:AddLine(" ", 1, 1, 1) 
            self:AddDoubleLine("S1 | ExpoScore", s1Score .. ' | ' .. epxoScore  , 0, 1, 0.75, EXPOS.GetScoreColor(s1Score) )
        end
    end
end

-- lfg tool: admin
aura_env.UpdateApplicantMember = function(member, appID, memberIdx, status, pendingStatus)
    local _, _, _, _, _, _, _, _, _, _, _, dungeonScore = C_LFGList.GetApplicantMemberInfo(appID, memberIdx);
    
    local s1Score = EXPOS.S1correct(dungeonScore)
    local epxoScore = EXPOS.ExpoCorrect(dungeonScore)
    
    member.DungeonScore:SetText(EXPOS.GetColorString(s1Score) .. EXPOS.ShortenScore(s1Score) .. ' | '  .. EXPOS.ShortenScore(epxoScore));    
    member.DungeonScore:Show();
    member:SetWidth(256);
end

-- lfg tool: search
aura_env.SearchEntry_Update = function(group)
    local searchResultInfo = C_LFGList.GetSearchResultInfo(group.resultID)
    local _, _, _, _, _, _, _, _, _, _, _, _, isMythicPlusActivity = C_LFGList.GetActivityInfo(searchResultInfo.activityID, nil, searchResultInfo.isWarMode);
    
    if ( isMythicPlusActivity and searchResultInfo.leaderOverallDungeonScore) then 
        local s1Score = EXPOS.S1correct(searchResultInfo.leaderOverallDungeonScore)
        local epxoScore = EXPOS.ExpoCorrect(searchResultInfo.leaderOverallDungeonScore)
        
        local oldText = group.Name:GetText()
        local newGrpText = string.format("%s [%s | %s]\124r  %s", EXPOS.GetColorString(s1Score), EXPOS.ShortenScore(s1Score), EXPOS.ShortenScore(epxoScore), oldText);
        group.Name:SetText(newGrpText)
    end 
end


--- bind hook
GameTooltip:HookScript('OnTooltipSetUnit', aura_env.OnTooltipSetUnit)
hooksecurefunc("LFGListApplicationViewer_UpdateApplicantMember", aura_env.UpdateApplicantMember)
hooksecurefunc("LFGListSearchEntry_Update", aura_env.SearchEntry_Update)