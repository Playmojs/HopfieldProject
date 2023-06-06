function noised_pattern = MakeNoisyPattern(pattern_vector, noise_level, model_version) %noise_level is number between 0 and 0.5, describing how much of the vector should be randomized
    num_elements = length(pattern_vector);
    rand_size = floor(num_elements*noise_level);
    rand_inds = randperm(num_elements, rand_size);
    values = [-1, 1];
    pattern_vector(rand_inds) = datasample(values, rand_size);
    noised_pattern = Pattern(model_version, pattern_vector);
end