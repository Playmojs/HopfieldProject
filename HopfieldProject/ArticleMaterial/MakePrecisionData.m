function precision_data_ = MakePrecisionData(hidden_patterns_list, model_version)
    AllTrialsMap = dictionary;
    for iNumPattern = 1:length(hidden_patterns_list)
        disp(append("Number of Hidden Patterns: ", num2str(hidden_patterns_list(iNumPattern))))
        pattern_result = zeros(10,1);
        for iTrial = 1:10 
            current_match = 0;
            disp(append("Trial number ", num2str(iTrial), " out of 10"))
            for i = 1:100
                V = CreatePatternCellArray(hidden_patterns_list(iNumPattern),256);
                pattern_maps = RecruitPatterns(V, hidden_patterns_list(iNumPattern)*10*iTrial, model_version);
                pattern_guess = FilterPatternGuesses(pattern_maps{1});
                if VerifyVectors(V, pattern_guess)
                    current_match = current_match + 1/100;
                end
            end
            pattern_result(iTrial) = current_match;
        end
        AllTrialsMap(iNumPattern) = {pattern_result};
    end
    precision_data_ = AllTrialsMap;
end