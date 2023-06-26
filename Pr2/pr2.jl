include("polynom.jl")


function pow(x::T,n) where {T}
    if n==0 
        return one(T) 
    end
    ans=x
    n-=1
    while n>0
        if mod(n,2) == 0
            x*=x
            n//=2
        end
        ans*=x
        n-=1
    end
    return ans
end


function fib(n)
    return Int((pow(((1+sqrt(5))/2),n)-pow(((1-sqrt(5))/2),n))/sqrt(5))
end


function log_(a,x,eps=0.001)
    if a==1
        return nothing
    end
    if a<1
        return -log_(1/a,x)
    end

    z=x
    t=1
    y=0
     #a^y=a^~y*z^t
    while z < 1/a || z > a || t > eps 
        if z<1/a
            z*=a
            y-=t
        elseif z>a
            z/=a
            y+=t
        elseif t>eps
            t/=2
            z*=z
        end
    end
    return y 
end


function bisection(f::Function,a,b,eps=0.001)
    f_a=f(a)
    f_b=f(b)
    if f_a*f_b>=0
        println("WRONG CONDITIONS")
    end
    #f(a)*f(b)<0
    while abs(a-b)>eps
        m=(a+b)/2
        f_m=f(m)
        if f_a*f_m<0
            b=m
            f_b=f_m
        else
            a=m
            f_a=f_m
        end
    end
    return (a+b)/2
end



function f1(x)
    return x-4
end


function f2(x)
    return cos(x)-x
end

#println(bisection(x->cos(x)-x,0,pi,0.0001))


function r1(x)
    return (cos(x)-x)/(-sin(x)-1)
end


function newton(r::Function, x, epsilon; num_max = 50)
    k=0
    dx = -r(x)
    while abs(dx) > epsilon && k <= num_max
        dx = -r(x)
        x += dx
        k += 1
    end
    k > num_max && @warn("Требуемая точность не достигнута")
    return x
end



# function r2(x)
#     p1=Make_Polynom([-6,1,1])
#     p2=Make_Polynom([2,2])
#     return p1(x)/p2(x)
# end


function PolDer(p::Polynom{T,D},x) where {T,D}
    D==0 && @warn("Многочлен нулевой степени")

    #k(n)=a(n)
    #k'(n)=0
    #k(i)=x*k(i+1)+a(i)
    #k'(i)=x*k'(i+1)+k(i+1)

    k=p.A[D+1]
    k_=0
    for i in D:-1:1
        k_=x*k_+k
        k=k*x+p.A[i]
    end

    return k,k_
end


function r2(x)
    p=Make_Polynom([1,2,1])
    a,b= PolDer(p,x)
    return a/b
end

p1=Make_Polynom([2,3,5])

#println(newton(r1,1,0.0001))
#println(newton(r2,1,0.001))
