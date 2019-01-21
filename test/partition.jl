
@testset "Image Partitioning" begin
    img = testimage("mandrill")
    # Window size divides image size without remainder.
    subdivision = partition_image(AllowContraction(), img, 32)
    size(subdivision) == (16,16)
    for i in subdivision
        @test length.(i) == (32,32)
    end

    # Window size divides image size with remainder.
    subdivision = partition_image(AllowContraction(), img, 31)
    for r = 1:18
        for c = 1:18
            t = subdivision[r,c]
            if c == 1 || c == 18
                @test length(t[2]) == 8
            end
            if  1 < c < 18
                @test length(t[2]) == 31
            end
            if r == 1 || r == 18
                @test length(t[1]) == 8
            end
            if  1 < r < 18
                @test length(t[1]) == 31
            end
        end
    end
end
