function match_data = GetAllMatches(hidden_patterns, pattern_guess)
    if VerifyVectors(hidden_patterns, pattern_guess)
        match = CheckMatch(pattern_guess, hidden_patterns);
        k = keys(match);
        top_matches = nan(numEntries(match), 1);
        for iMatch = 1:numEntries(match)
            top_matches(iMatch) = (max(match{k(iMatch)}) + 1) / 2;
        end
        match_data = top_matches;
    else
        match_data = nan;
    end
end