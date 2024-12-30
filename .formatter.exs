[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  import_deps: [:ecto, :phoenix],
  line_length: 80,
  locals_without_parens: [
    slot: 2
  ],
  plugins: [Phoenix.LiveView.HTMLFormatter]
]
