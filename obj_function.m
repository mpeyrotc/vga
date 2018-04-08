function result = obj_function(varargin)

persistent positions production evaluation N

if length(varargin)==3
    positions = varargin{1};
    production = varargin{2};
    evaluation = varargin{3};
    N = length(positions);
else
    result = 0;
    hijo = dec2base(varargin{1}, 8, N); % esto es un string
    hijo_aux = zeros(1, length(hijo));
    
    for i = 1:length(hijo)
       hijo_aux(1, i) = str2num(hijo(i));
    end
    
    hijo = hijo_aux;
    
    N = length(hijo);
    A = zeros(N);
    hijo(1) = 0;
    
    for i=1:N
        if hijo(i)~=0
            A(i,hijo(i)) = 1;
        end
    end
    
    Aux = A;
    envia = zeros(N);       % potencia que envía cada nodo a su padre
    continuar = 1;
   
    for i = 2:length(hijo)
        if hijo(i) == 0
            continuar = 0;
            result = result + Inf;
            break
        end
        
        if hijo(i) == i
            continuar = 0;
            result = result + Inf;
            break
        end
    end
    
    skip = true;
    
    if continuar
        if has_cycles(hijo)
            result = result + Inf; 
            skip = false;
            continuar = false;
        end
    end
    
    while continuar
        hojas = find(sum(Aux,1)==0);  % si el nodo raíz es hoja,
        if isequal(hojas,1)           % salir
            break
        end
        envia(hojas) = envia(hojas) + production(hojas);  
        for i=1:length(hojas)
            envia(hijo(hojas(i))) = envia(hijo(hojas(i))) + envia(hojas(i));
            Aux(hojas(i),:) = zeros(size(hijo));
        end
        Aux(1,hojas) = 1;
    end
    
    if skip && continuar
        for i = 2:N
            % si algún nodo no está conectado
            if hijo(i) == 0
                result = result + Inf;
                break
            end
        
            originX = positions(i, 1);
            originY = positions(i, 2);
            destinationX = positions(hijo(i), 1);
            destinationY = positions(hijo(i), 2);
            distance = sqrt((destinationX - originX).^2 + (destinationY - originY).^2);
            result = result + (distance * evaluation(envia(i)));
        end
    end
end