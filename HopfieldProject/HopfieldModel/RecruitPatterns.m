function pattern_maps = RecruitPatterns(true_vectors, num_inputs, model_version)
    pattern_map = dictionary;
    noisy_input_map = dictionary; % map storing the noise in each of the inputs
    noise_level_map = dictionary; % map storing the noisy input vectors, without concatenation
    combined_patterns_noise_map = dictionary; % map storing the keys to all combined patterns, and their noise level
    for iKey = 1:num_inputs
        ind = randi(length(true_vectors), 1); % pick one of the true vectors at random
        x = rand(1)/2; % decide noise level (0-50 %)
        noise_level_map(iKey)=x;

        noisy_pattern = MakeNoisyPattern(true_vectors{ind}, x, model_version);% create noisy vector
        pattern_map(iKey) = noisy_pattern; % assign noisy vector to map that will later be evaluated
        noisy_input_map(iKey) = noisy_pattern;

        check_match = true;
        current_pattern_key = iKey;
        while check_match
            is_match = EvaluateMatches(pattern_map, current_pattern_key, 0.9, model_version); % see if the vector is matching above given threshold. Returns 0 for no match, and key-value for a given match  
            if is_match ~= 0
              combined_patterns_noise_map(current_pattern_key) = noise_level_map(current_pattern_key);
              combined_patterns_noise_map(is_match) = noise_level_map(is_match);
              pattern_map = ConcatenatePatterns(pattern_map, is_match, current_pattern_key,model_version); % combines two patterns in the pattern map, assigns the new pattern to the lowest key value and deletes the higher key entry
              current_pattern_key = min(is_match, current_pattern_key); % uses the concatenated pattern as the test-pattern in the next while-loop iteration
            else
              check_match = false;
            end
        end   
    end
    pattern_maps = {pattern_map, noisy_input_map, noise_level_map, combined_patterns_noise_map};
end