# function iszero()

# end


function one(T)
    if T==Int
        return 1
    end
end



function gcd_(a::T,b::T) where T 
    while !iszero(b)
        a,b=b,rem(a,b)
    end
    return abs(a)
end


function isnegative(a::Int)
    if a<0
        return true
    end
    return false
end


function gcdx_(a::T,b::T) where T 
    s,s_=one(T),zero(T)
    t,t_=zero(T),one(T)

    #Инвариант
    #gcd(a,b) = gcd(a0,b0)  
    #a = s*a0 + t*b0 
    #b = s_* a0 + t_ * b0

    while !iszero(b)
        k,r=divrem(a,b)
        a,b=b,r
        s,s_=s_,s-k*s_
        t,t_=t_,t-k*t_
    end
    if isnegative(a)
        a,s,t=-a,-s,-t
    end
    return a,s,t
end


function invmod_(a::T,M::T) where T
    # a*x=1+M*y
    d,s,t=gcdx_(a,-M)
    if d!=1
        return nothing
    end
    return mod(s,M)
end


function diaphant_solve(a::T,b::T,c::T) where T
    d,s,t=gcdx_(a,b)
    if mod(c,d)!=0
        return nothing
    end
    k=div(c,d)
    return s*k,t*k
end


function display(x::Float64)
    return string(x)    
end


function display(x::Int64)
    return string(x)    
end


gcdx_(10,15)

