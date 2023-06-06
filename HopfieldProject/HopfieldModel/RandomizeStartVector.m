function randomized_start_vector = RandomizeStartVector(start_vector, randomness) %randomness is number between 0 and 1, describing how much of the vector should be randomized
    rand_size = floor(length(start_vector)*randomness)
    rand_inds = randperm(length(start_vector), rand_size);
    values = [-1, 1];
    start_vector(rand_inds) = datasample(values, rand_size);
    randomized_start_vector = start_vector;
end