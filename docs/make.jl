using Documenter
format = Documenter.HTML(assets=["assets/css/notes.css"])

Optimization = map(file -> joinpath("Optimization", file), readdir(joinpath(@__DIR__, "src", "Optimization")))
Front_end = map(file -> joinpath("Front_end", file), readdir(joinpath(@__DIR__, "src", "Front_end")))
Mac_share = map(file -> joinpath("Mac_share", file), readdir(joinpath(@__DIR__, "src", "Mac_share")))
Web_build = map(file -> joinpath("Web_build", file), readdir(joinpath(@__DIR__, "src", "Web_build")))
Marxism_Principle = map(file -> joinpath("Marxism_Principle", file), readdir(joinpath(@__DIR__, "src", "Marxism_Principle")))

makedocs(
    sitename="study notes",
    strict=[
             :doctest,
             :linkcheck,
             :parse_error,
             :example_block,
             # Other available options are
             # :autodocs_block, :cross_references, :docs_block, :eval_block, :example_block, :footnote, :meta_block, :missing_docs, :setup_block
    ],
    pages=[
        "Home" => "index.md",
        "Optimization" => Optimization,
        "Front_end"=>Front_end,
        "Mac_share"=>Mac_share,
        "Web_build"=>Web_build,
        "Marxism_Principle"=>Marxism_Principle,
    ],
    format=format,
)


deploydocs(
    repo="https://github.com/ccchhhddd/study-notes";
    push_preview=true
    #    target = "../build",
)
