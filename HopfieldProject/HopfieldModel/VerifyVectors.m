function vectors_match = VerifyVectors(true_vectors, pattern_guess)
    if numEntries(pattern_guess) == 0
        vectors_match = false;
        return
    end
    
    match = CheckMatch(pattern_guess, true_vectors);
    if numEntries(match) ~= length(true_vectors)
        vectors_match = false;
        return
    end

    num_matches = zeros(length(true_vectors), 1); 
    K = keys(match);
    for i = 1:numEntries(match)
        [s, ind] = sort(match{K(i)});
        if s(end) > 0.8
            num_matches(ind(end)) = num_matches(ind(end)) + 1;
        end
    end
    content = unique(num_matches);
    if(content==1) %This checks if each true vector had a matching guessed pattern
        vectors_match = true;
    else
        vectors_match=false;
    end
end