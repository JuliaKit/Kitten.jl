using Kit.Mathematical

# @test recvec([1,2,3,4,5,6,7,8,9,10]) == [1,-2,1]
# @test recvec([0,1,1,2,3,5,8,13], output=Float64) == [1.0,-1.0,-1.0]
# @test recvec([2^k for k=0:7], compute=Int128) == [1,-2]
# @test recvec([1//2^k for k=0:7], compute=Int128, output=Float64) == [2.0,-1.0]
# @test recvec([1]) == []
# @test recvec([1,2,3,4,5,6,7,8,9,10,42]) == []
# @test recvec([BigInt(2)^k + k%16 for k=1:64]) == [1,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,2]

# @test abs(transpose([0.75,BigFloat(1)])*pslq([0.75, 1],1e-10))[1] < 1e-10
# @test abs(transpose([0.5,BigFloat(1)])*pslq([0.5, 1],1e-10))[1] < 1e-10
