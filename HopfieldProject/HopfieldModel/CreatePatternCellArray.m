function CellArray = CreatePatternCellArray(number, size)
    Cell = {};
    for iPattern = 1:number
        PatternVector = CreateRandomPattern(size);
        Cell{iPattern} = PatternVector;
    end
    CellArray = Cell;
end