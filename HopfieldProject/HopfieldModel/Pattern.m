classdef Pattern
    properties
        pattern_vector;
        weights;
    end
    methods
        function new_pattern = Pattern(model_version, pattern_1, pattern_2)
            if nargin == 2
                new_pattern.pattern_vector = pattern_1;
                if model_version == ModelVersion.SetThreshold_ArrayWeight || model_version == ModelVersion.VarThreshold_ArrayWeight
                    new_pattern.weights = ones(length(pattern_1), 1);
                else
                    new_pattern.weights = 1;
                end
            end
            if nargin == 3
                if model_version == ModelVersion.SetThreshold_ArrayWeight || model_version == ModelVersion.VarThreshold_ArrayWeight
                    rand_vals = rand(length(pattern_1.pattern_vector),1);
                    for iNeuron = 1:length(pattern_1.pattern_vector)
                        if pattern_1.pattern_vector(iNeuron) ~= pattern_2.pattern_vector(iNeuron)
                            if rand_vals(iNeuron) > pattern_1.weights(iNeuron) / (pattern_1.weights(iNeuron)+ pattern_2.weights(iNeuron))
                                  pattern_1.pattern_vector(iNeuron) = pattern_1.pattern_vector(iNeuron) * -1;
                            end
                            pattern_1.weights(iNeuron) = max(1, abs(pattern_1.weights(iNeuron) - pattern_2.weights(iNeuron)));
                        else
                            pattern_1.weights(iNeuron) = pattern_1.weights(iNeuron) + pattern_2.weights(iNeuron);
                        end
                    end
                else
                    diffs = find(pattern_1.pattern_vector ~= pattern_2.pattern_vector);
                    rand_vals = rand(length(diffs),1);
                    for iNeuron = 1:length(diffs)
                        if rand_vals(iNeuron) > pattern_1.weights / (pattern_1.weights + pattern_2.weights)
                            pattern_1.pattern_vector(diffs(iNeuron)) = pattern_1.pattern_vector(diffs(iNeuron)) * -1;

                        end
                    end
                    pattern_1.weights = pattern_1.weights + pattern_2.weights;
                end
                new_pattern = pattern_1;
            end
        end
    end
end