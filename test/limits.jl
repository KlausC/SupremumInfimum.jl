
@test IntInf == IntInf
@test IntInf != IntSup
@test IntInf == Float64(-Inf)
@test IntInf != 1
@test IntSup == IntSup
@test IntSup != IntInf
@test IntSup == BigFloat(Inf)
@test IntSup != 1

@test isless(IntInf, IntInf) == false
@test isless(IntInf, 0)
@test isless(IntInf, IntSup)
@test isless(IntInf, -Inf) == false
@test isless(IntInf, 0.0)
@test isless(IntInf, Inf)
@test isless(0, IntInf) == false
@test isless(IntSup, IntInf) == false
@test isless(-Inf, IntInf) == false
@test isless(0.0, IntInf) == false
@test isless(Inf, IntInf) == false

@test isless(IntSup, IntSup) == false
@test isless(IntSup, 0) == false
@test isless(IntSup, IntInf) == false
@test isless(IntSup, -Inf) == false
@test isless(IntSup, 0.0) == false
@test isless(IntSup, Inf) == false
@test isless(0, IntSup)
@test isless(-Inf, IntSup)
@test isless(0.0, IntSup)
@test isless(Inf, IntSup) == false

@test IntInf == typemin(Rational{Int})
@test IntSup == typemax(Rational{BigInt})
@test IntInf == typeinf(Rational)
@test IntSup == typesup(Rational)

@test IntInf + IntInf == IntInf
@test IntInf + 0 == IntInf
@test_throws ArgumentError IntInf + IntSup
@test 0 + IntInf == IntInf
@test_throws ArgumentError IntInf - IntInf
@test IntInf - 0 == IntInf
@test IntInf - IntSup == IntInf

@test IntSup + IntSup == IntSup
@test IntSup + 0 == IntSup
@test_throws ArgumentError IntSup + IntInf
@test 0 + IntSup == IntSup
@test_throws ArgumentError IntSup - IntSup
@test IntSup - 0 == IntSup
@test IntSup - IntInf == IntSup

@test -IntInf == IntSup
@test -IntSup == IntInf
