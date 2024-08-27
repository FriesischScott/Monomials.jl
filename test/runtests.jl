using Test

using Monomials


@testset "Orders" begin

    @testset "LexicographicOrder" begin
        m = monomials(["x1", "x2"], 2, LexicographicOrder())

        @test length(m) == 5

        @test m[1].α == [0, 1]
        @test m[2].α == [0, 2]
        @test m[3].α == [1, 0]
        @test m[4].α == [1, 1]
        @test m[5].α == [2, 0]

        m = monomials(["x1", "x2", "x3"], 2, LexicographicOrder())

        @test length(m) == 9

        @test m[1].α == [0, 0, 1]
        @test m[2].α == [0, 0, 2]
        @test m[3].α == [0, 1, 0]
        @test m[4].α == [0, 1, 1]
        @test m[5].α == [0, 2, 0]
        @test m[6].α == [1, 0, 0]
        @test m[7].α == [1, 0, 1]
        @test m[8].α == [1, 1, 0]
        @test m[9].α == [2, 0, 0]
    end

    @testset "GradedLexicographicOrder" begin
        m = monomials(["x1", "x2"], 2, GradedLexicographicOrder())

        @test length(m) == 5

        @test m[1].α == [0, 1]
        @test m[2].α == [1, 0]
        @test m[3].α == [0, 2]
        @test m[4].α == [1, 1]
        @test m[5].α == [2, 0]

        m = monomials(["x1", "x2", "x3"], 2, GradedLexicographicOrder())

        @test length(m) == 9

        @test m[1].α == [0, 0, 1]
        @test m[2].α == [0, 1, 0]
        @test m[3].α == [1, 0, 0]
        @test m[4].α == [0, 0, 2]
        @test m[5].α == [0, 1, 1]
        @test m[6].α == [0, 2, 0]
        @test m[7].α == [1, 0, 1]
        @test m[8].α == [1, 1, 0]
        @test m[9].α == [2, 0, 0]
    end

    @testset "GradedReverseLexicographicOrder" begin
        m = monomials(["x1", "x2"], 2, GradedReverseLexicographicOrder())

        @test length(m) == 5

        @test m[1].α == [0, 1]
        @test m[2].α == [1, 0]
        @test m[3].α == [0, 2]
        @test m[4].α == [1, 1]
        @test m[5].α == [2, 0]

        m = monomials(["x1", "x2", "x3"], 2, GradedReverseLexicographicOrder())

        @test length(m) == 9

        @test m[1].α == [0, 0, 1]
        @test m[2].α == [0, 1, 0]
        @test m[3].α == [1, 0, 0]

        @test m[4].α == [0, 0, 2]
        @test m[5].α == [0, 1, 1]
        @test m[6].α == [1, 0, 1]
        @test m[7].α == [0, 2, 0]
        @test m[8].α == [1, 1, 0]
        @test m[9].α == [2, 0, 0]


    end

end
