function matches = CheckMatch(pattern_map, vectors)
    K = keys(pattern_map);
    m = dictionary;
    for iPattern = 1:numEntries(pattern_map)
        pattern = pattern_map(K(iPattern)).pattern_vector;
        if isa(vectors, 'cell')
            match = null(numEntries(pattern_map), 1);
            for iState = 1:length(vectors)        
                assert (length(pattern) == length(vectors{iState}));
                match(iState) = sum (vectors{iState} .* pattern) / length(pattern);
            end
        else
            match = sum(vectors .* pattern) / length(pattern);
        end
        m(K(iPattern)) = {match};
    end 
    matches = m;        
end