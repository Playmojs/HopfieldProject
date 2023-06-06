function match_data_ = MakeMatchData(trial_iterations, num_hidden_patterns, model_version, add_input_vectors)
    match_data = {};
    input_data = {};
    for iTrial = 1:length(trial_iterations)
        output_match = [];
        input_match = [];
        for i = 1:round(100/num_hidden_patterns)
            V = CreatePatternCellArray(num_hidden_patterns,256);
            pattern_maps = RecruitPatterns(V, trial_iterations(iTrial), model_version);
            pattern_guess = FilterPatternGuesses(pattern_maps{1}, pattern_maps{2},pattern_maps{3});
            output_match = [output_match; GetAllMatches(V, pattern_guess{1})];
            input_match = [input_match; GetAllMatches(V, pattern_guess{2})];
        end
        match_data(iTrial) = {output_match};
        input_data(iTrial) = {input_match};
    end
    for iSum = 1:length(match_data)
        match_data(2, iSum) = {nanmean(match_data{1, iSum},"all")};
        match_data(3, iSum) = {nanvar(match_data{1, iSum}, 1, "all")};

        input_data(2, iSum) = {nanmean(input_data{1, iSum}, "all")};
        input_data(3, iSum) = {nanvar(input_data{1, iSum}, 1, "all")};
    end
    if add_input_vectors
        match_data_ = {match_data, input_data};
    else
        match_data_ = {match_data};
    end
end