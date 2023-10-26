using Documenter
format = Documenter.HTML(assets=["assets/css/notes.css"])

Optimization = map(file -> joinpath("Optimization", file), readdir(joinpath(@__DIR__, "src", "Optimization")))


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
    ],
    format=format,
)


deploydocs(
    repo="https://ccchhhddd.github.io/study-note";
    push_preview=true
    #    target = "../build",
)
