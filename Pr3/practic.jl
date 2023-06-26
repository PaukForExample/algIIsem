
function isprime_(x::Integer)::Bool
	if x < 2
		return false
	end

	for n in 2:sqrt(x)
		if x % n == 0
			return false
		end
	end

	return true
end

println(isprime_(11))


function eratosthenes(m::Integer)::Array{Integer}
	if m < 2
		return Vector{Integer}(undef,0)
	end
	
	count = m

	primes = fill(true,m)

	primes[1] = false

	for i in 1:Int(ceil(sqrt(m)))
		if primes[i]
			for j in i*i:i:m
				primes[j] = false
			end
		end
		
		count += 1
	end

	result = Vector{Integer}(undef,0)

	for i in 1:m
		if primes[i]
			push!(result,i)
		end
	end

	return result
end


function factor(n::Integer)::Tuple{Array{Integer},Array{Integer}}
	primes = Vector{Integer}(undef,0)
	degrees = Vector{Integer}(undef,0)

	m = 2

	while m * m <= n
		degree = 0

		while n % m == 0
			n /= m
			degree += 1
		end

		if degree > 0
			push!(primes,m)
			push!(degrees,degree)
		end
		
		m += 1
	end

	if n > 1
		push!(primes,n)
		push!(degrees,1)
	end

	return primes, degrees
end

println(factor( 2^5 * 3^2 * 131 ))


function mean_(nums::Array{Number})::Number
	n = length(nums)

	sum = 0

	for i in 1:n
		sum += nums[i]
	end

	return sum / n
end


function variance_(nums::Array{T})::T where T <: Number
	n = length(nums)

	if n <= 0
		return 0
	end

	mean = 0
	var = 0

	for i in 1:n
		delta = nums[i] - mean
		mean += delta / ( i + 1 )
		var += delta * ( nums[i] - mean ) * i / (i+1)
	end

	var /= n

	return var
end
