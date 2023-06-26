include("gcd.jl")


struct Residue{T,M}
    a::T
    Residue{T,M}(a::T) where {T,M} = new(mod(a,M))
end


function Base. +(x::Residue{T,M} ,y::Residue{T,M}) where {T,M}
    return Residue{T,M}(x.a+y.a)
end


function Base.zero(::Type{Residue{T,M}}) where{T,M}
    return Residue{T,M}(zero(T))
end


function Base.zero(a::Residue{T,M}) where{T,M}
    return Residue{T,M}(zero(T))
end


function Base.one(::Type{Residue{T,M}}) where{T,M}
    return Residue{T,M}(one(T))
end


function Base.one(a::Residue{T,M}) where{T,M}
    return Residue{T,M}(one(T))
end


function Base. -(x::Residue{T,M} ,y::Residue{T,M}) where {T,M}
    return Residue{T,M}(x.a-y.a)
end


function Base. -(x::Residue{T,M}) where {T,M}
    return Residue{T,M}(-x.a)
end


function Base. *(x::Residue{T,M} ,y::Residue{T,M}) where {T,M}
    return Residue{T,M}(x.a*y.a)
end


function Base. *(x::Residue{T,M} ,y::Int) where {T,M}
    return Residue{T,M}(x.a*y)
end


function Base. *(x::Int ,y::Residue{T,M}) where {T,M}
    return Residue{T,M}(x*y.a)
end


function Base. ^(x::Residue{T,M} ,y::Int) where {T,M}
    ans=Residue{T,M}(1)  
    for i in 1:y 
        ans*=x
    end
    return ans
end


function inverse(x::Residue{T,M}) where {T,M}
    if (diaphant_solve(x.a,-M,1))!=nothing
        k1,_=diaphant_solve(x.a,-M,1)
        return Residue{T,M}(k1)
    end
    return nothing
end


function display(x::Residue{T,M}) where {T,M}
    return(display(x.a))
end

# a=Residue{Int,9}(5)
# b=Residue{Int,9}(2)
# c=b^0

# d=inverse(a)
# println(display(a))
# e=zero(a)
# println(e)
# println(zero(Residue{Int,9}))