


struct Polynom{T,D} 
    A::AbstractVector{T}
    Polynom{T,D}() where {T,D} = new(Vector{T}(undef,D+1) )
end


function Make_Polynom(a::Vector{T}) where{T}
    i=length(a)
    while (a[i]==zero(T)) && (i>1)
        i-=1
    end
    res=Polynom{T,i-1}()
    for i in 1:i
        res.A[i]=a[i]
    end
    return res
end


function Make_Polynom(a::Tuple) where{T}
    i=length(a)
    while (a[i]==zero(T)) && (i>1)
        i-=1
    end
    res=Polynom{T,i-1}()
    for i in 1:i
        res.A[i]=a[i]
    end
    return res
end


function Get_Degree(x::Polynom{T,D}) where {T,D}
    return D
end


function Base. +(x::Polynom{T,D1}, y::Polynom{T,D2}) where {T,D1,D2}
    if D1<D2
        x,y=y,x
    end
    a=Vector{T}(undef,max(D1,D2)+1)
    for i in 1:max(D1,D2)+1
        a[i]=x.A[i]
    end
    for i in 1:min(D1,D2)+1
        a[i]+=y.A[i]
    end
    return Make_Polynom(a)
end

function (p::Polynom{T,D})(x) where {T,D}
    if D==0
        return p.A[1]
    end

    #k(n)=a(n)
    #k(i)=x*k(i+1)+a(i)

    k=p.A[D+1]
    for i in D:-1:1
        k=k*x+p.A[i]
    end

    return k

end

function Base. -(x::Polynom{T,D}) where {T,D}
    res=Polynom{T,D}()
    for i in 1:D+1
        res.A[i]=-x.A[i]
    end
    return res
end


function Base. -(x::Polynom{T,D1}, y::Polynom{T,D2}) where {T,D1,D2}
    return x+(-y)
end


function Base. *(x::Polynom{T,D1}, y::Polynom{T,D2}) where {T,D1,D2}
    res=Vector{T}(undef,D1+D2+1)
    for i in 0:D1+D2
        c=0
        for j in 0:i
            if 0<j+1<=D1+1 && 0<i-j+1<=D2+1
                c+=x.A[j+1]*y.A[i-j+1]
            end
        end
        res[i+1]=c
    end
    return Make_Polynom(res)
end


# function Base. mod(x::Polynom{T,D1}, v::AbstractVector{T}) where {T,D1,D2}
#     y=Make_Polynom(v)
#     while Get_Degree(x)>=Get_Degree(y)
#         a=Polynom{T,Get_Degree(x)-Get_Degree(y)}()
#         #println(a)
#         #println(x)
#         #println(y)
#         a.A[Get_Degree(x)-Get_Degree(y)+1]=x.A[Get_Degree(x)+1]/y.A[Get_Degree(y)+1]
#         x-=a*y

#     end
#     return x
# end


function Base. mod(x::Polynom{T,D1}, t::Tuple) where {T,D1}
    v=[i for i in t]
    y=Make_Polynom(v)
    while Get_Degree(x)>=Get_Degree(y)
        a=Polynom{T,Get_Degree(x)-Get_Degree(y)}()
        #println(a)
        #println(x)
        #println(y)
        
        a.A[Get_Degree(x)-Get_Degree(y)+1]=x.A[Get_Degree(x)+1]/y.A[Get_Degree(y)+1]

        x-=y*a

    end
    return x
end


function Base. mod(x::Polynom{T,D1}, y::Polynom{T,D2}) where {T,D1,D2}

    while Get_Degree(x)>=Get_Degree(y)
        a=Polynom{T,Get_Degree(x)-Get_Degree(y)}()
        #println(a)
        #println(x)
        #println(y)
        a.A[Get_Degree(x)-Get_Degree(y)+1]=x.A[Get_Degree(x)+1]/y.A[Get_Degree(y)+1]
        x-=a*y

    end
    return x
end


function display(x::Polynom{T,D}) where {T,D}
    ans=""
    for i in 1:D+1
        ans*=display(x.A[i])*" t^"*string(i-1)*" "
    end
    return ans
end


a=Make_Polynom([1,0,2,0,0,0])

#println(a(5))
d=Make_Polynom([0,0,0,-1])
#println(d(3))


# b=Polynom{Int,3}()
# b.A[1]=2
# b.A[2]=1
# b.A[3]=0
# b.A[4]=1

# c=a+b 
# println(a)
# println(b)
# println(c)
# println(d)
# println(b+d)
# println(-a)
# println(b-a)
# println(a*b)
# println(a*Make_Polynom([0]))
# a=Polynom{Int,2}()
# println(a)
#println(mod(Make_Polynom([1.,-1.,2.,1.]),Make_Polynom([5.,0.,1.])))
# println(display(a))
p1=Make_Polynom([2.,3.,5.])
#println(mod(p1,(0.,2.,0.)))