function result = has_cycles(hijo)

result = false;

s = [];
t = [];
for i = 2:(length(hijo))
    if hijo(i) ~= 1
        s = [s i-1];
        t = [t (hijo(i)-1)];
    end
end

s
t

G = digraph(s, t);

result = ~isdag(G);