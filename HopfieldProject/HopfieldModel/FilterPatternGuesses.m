function return_patterns = FilterPatternGuesses(pattern_map, noisy_pattern_map, noise_map)
    k = keys(pattern_map);
    return_noisy_patterns = nargin > 1;
    pattern_guesses = dictionary;
    initial_pattern_map = dictionary;
    noise_map_ = dictionary;
    for i = 1:numEntries(pattern_map)
        if mean(pattern_map(k(i)).weights) > 1
            pattern_guesses(k(i)) = pattern_map(k(i));
            if return_noisy_patterns
                initial_pattern_map(k(i)) = noisy_pattern_map(k(i));
                noise_map_(k(i)) = noise_map(k(i));
            end
        end 
    end
    if ~return_noisy_patterns
        return_patterns = pattern_guesses;
    else
        return_patterns{1} = pattern_guesses;
        return_patterns{2} = initial_pattern_map;
        return_patterns{3} = noise_map_;
end