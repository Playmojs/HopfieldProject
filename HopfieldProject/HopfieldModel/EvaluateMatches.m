function pattern_match = EvaluateMatches(pattern_map, test_key, match_threshold, model_version)
    K = keys(pattern_map);
    n = numEntries(pattern_map);
    test_vector = pattern_map(test_key).pattern_vector;
    test_weight = mean(pattern_map(test_key).weights);
    if n == 0
        pattern_match = 0;
        return
    end
    
    for iPattern = 1:n
        if K(iPattern) == test_key
            continue;
        end
        p = pattern_map(K(iPattern)).pattern_vector;
        match = sum(p .* test_vector)/ length(test_vector);
        threshold = match_threshold;
        if model_version == ModelVersion.VarThreshold_IntegerWeight || model_version == ModelVersion.VarThreshold_ArrayWeight
            threshold = match_threshold - log(1 + abs(mean(pattern_map(K(iPattern)).weights) - test_weight))/50;
        end
        if abs(match) > threshold
            pattern_match = K(iPattern);
            return
        end
    end
    pattern_match = 0;
end