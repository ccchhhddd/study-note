using Documenter
format = Documenter.HTML(assets=["assets/css/notes.css"])

Optimization = map(file -> joinpath("Optimization", file), readdir(joinpath(@__DIR__, "src", "Optimization")))
Front_end = map(file -> joinpath("Front_end", file), readdir(joinpath(@__DIR__, "src", "Front_end")))
mac_share = map(file -> joinpath("mac_share", file), readdir(joinpath(@__DIR__, "src", "mac_share")))


makedocs(
    sitename="study-note",
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
        "mac_share"=>mac_share
    ],
    format=format,
)


deploydocs(
    repo="https://github.com/ccchhhddd/study-notes";
    push_preview=true
    #    target = "../build",
)
