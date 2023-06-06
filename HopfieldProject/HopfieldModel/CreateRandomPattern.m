function Pattern = CreateRandomPattern(N)
    V = randi(2,N,1);
    V(V==2)=V(V==2)-3;
    Pattern = V;
end