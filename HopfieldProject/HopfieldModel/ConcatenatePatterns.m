function new_pattern_map = ConcatenatePatterns(pattern_map, key_1, key_2, model_version)
    K = keys(pattern_map);
    assert(isKey(pattern_map, key_1) & isKey(pattern_map, key_2));

    concatenated_pattern = Pattern(model_version, pattern_map(key_1), pattern_map(key_2));
    intermediary_pattern_map = dictionary;

    for i = 1:numEntries(pattern_map)
        if K(i) == max(key_1, key_2) % the highest key value is removed from the concatenated map
            continue;
        elseif K(i) == min(key_1,key_2)
            intermediary_pattern_map(K(i)) = concatenated_pattern;
        else
            intermediary_pattern_map(K(i)) = pattern_map(K(i));
        end
    end
    new_pattern_map = intermediary_pattern_map;
end
