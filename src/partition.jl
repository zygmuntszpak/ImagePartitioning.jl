


function partition_image(scheme::AllowContraction, img::AbstractArray, w::Int)
    nrow, ncol = length.(axes(img))
    first_dimension = subdivide_interval(nrow, w)
    second_dimension = subdivide_interval(ncol, w)
    collect(Iterators.product(first_dimension, second_dimension))
end

function subdivide_interval(section::Int, w::Int)
    num_equal_segments = div(section,w)
    remaining_units = section - w*num_equal_segments
    if remaining_units == 0
        first_segment = 1:w
        last_segment = (section - w + 1):section
        total_segments = num_equal_segments
    else
        first_segment = 1:floor(Int,remaining_units / 2)
        v = ceil(Int, remaining_units / 2)
        last_segment = (section - v + 1):section
        total_segments = num_equal_segments + 2
        @show num_equal_segments, total_segments, remaining_units, first_segment, last_segment , v
    end

    segments = Array{UnitRange{Int},1}(undef,total_segments)
    segments[1] = first_segment
    segments[end] = last_segment
    for i = firstindex(segments) + 1 : lastindex(segments) - 1
        segments[i] = ((i-1)*w + 1):((i-1)*w + 1) + w - 1
    end

    segments
    # first_segment = floor(remaining_units / 2)
    # last_segment = ceil(remaining_units / 2)
    # prepad, equal_segments, postpad
end
