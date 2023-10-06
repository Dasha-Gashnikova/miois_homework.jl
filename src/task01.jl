export getdigits, touppercase, firstnorm, secondnorm, infnorm, isleap, chesscolor

function getdigits(a)
    vec = Int[];
    while (a/10) > 1
        push!(vec, a%10); #добавляем последнюю цифру в вектор
        a = a÷10; #убираем последнюю цифру из числа
    end
    push!(vec, a);
    return vec[end:-1:1];
end

function touppercase(str_)
    vec = [];
    for x in str_ #идем по всем элементам строки
        if (x>='a')&&(x<='z') #задаем диапазон - только латиница в нижнем регистре по номерам в Hex
            push!(vec, x + ('A' - 'a')); #меняем на верхний регистр путем прибавления 20 символов юникода Hex
        else
            push!(vec, x); #в противном случае просто добавляем
        end
    end
    return join(vec); #получаем вектор из элементов и соединяем его join
end

function firstnorm(vec_::AbstractVector{<:Number}) #первая норма вектора - сумма модулей всех его элементов
    n1 = 0;
    for n in vec_
        n1 += abs(n);
    end
    return n1;
end

function secondnorm(vec_::AbstractVector{<:Number}) #вторая норма вектора - корень суммы квадратов всех его элементов
    n2 = 0;
    for n in vec_
        n2 += n^2;
    end
    return sqrt(n2);
end

function infnorm(vec_::AbstractVector{<:Number}) #третья норма вектора - максимальный элемент
    n3 = 0;
    for n in vec_
        if n > n3
            n3 = n;
        end
    end
    return n3;
end

#максимум по сумме столбцов
function firstnorm(mat_::AbstractMatrix{<:Number})
    nA1 = 0;
    for col in eachcol(mat_)
        x = 0
        for n in col
            x += n;
        end
        nA1 = nA1 < x ? x : nA1; #если сумма столбцов x больше предыдущей, то она и есть норма (находим максимум)
    end
    return nA1;
end

#максимум по сумме строк
function infnorm(mat_::AbstractMatrix{<:Number})
    nA = 0;
    for col in eachrow(mat_)
        x = 0
        for n in col
            x+=n;
        end
        nA = nA < x ? x : nA; #если сумма строк x больше предыдущей, то она и есть норма (находим максимум)
    end
    return nA;
end

#год високосный, если он делится на 4 без остатка, но если
# он делится на 100 без остатка, то он не високосный, если же делится на 400, то он високосный
function isleap(year)
    if (year % 400) == 0
        return true;
    elseif (year % 100) == 0
        return false
    elseif (year % 4) == 0
        return true
    end
    return false;
end

function chesscolor(cell1, cell2)
    a = cell1[1] - 'a' + 1;
    b = cell1[2];

    c = cell2[1] - 'a' + 1;
    d = cell2[2];

    if ((a+b+c+d) % 2) == 0
        return true;
    end
    return false; 
end