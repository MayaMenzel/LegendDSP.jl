# This file is a part of LegendDSP.jl, licensed under the MIT License (MIT).

import Test

Test.@testset "Package LegendDSP" begin
    include("test_aqua.jl")
    include("test_haar_filter.jl")
    # include("test_SOMETHING.jl")
    include("test_multiintersect.jl")
    include("test_docs.jl")
    include("test_ms_filter.jl")
    include("test_sgw_filter.jl")
    include("test_wh_filter.jl")
    isempty(Test.detect_ambiguities(LegendDSP))
end # testset
