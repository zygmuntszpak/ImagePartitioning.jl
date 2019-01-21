module ImagePartitioning


abstract type PartitionScheme end
struct AllowContraction <: PartitionScheme end

include("partition.jl")

export
	# main functions
    partition_image,
	AllowContraction

end # module
