import * as esbuild from "esbuild";
import postcss from "postcss";
import postcssPresetEnv from "postcss-preset-env";
import postcssReporter from "postcss-reporter";
import autoprefixer from "autoprefixer";
import stylelint from "stylelint";
import { sassPlugin } from "esbuild-sass-plugin";

const args = process.argv.slice(2);
const watch = args.includes("--watch");
const deploy = args.includes("--deploy");

const postcssPlugins = [
  autoprefixer,
  postcssPresetEnv(),
  postcssReporter({ clearReportedMessages: true }),
].filter((i) => i);

const plugins = [
  {
    name: "stylelint",
    setup: (build) => {
      build.onStart(async () => {
        const result = await stylelint.lint({
          files: "./css/**/*.scss",
          formatter: "string",
          quietDeprecationWarnings: true,
        });
        if (result.errored) {
          console.error(result.report);
        } else {
          console.log("Stylelint completed with no errors.");
        }
      });
    },
  },
  sassPlugin({
    async transform(source) {
      const { css } = await postcss(postcssPlugins).process(source, {
        from: undefined,
      });
      return css;
    },
    importers: [
      {
        findFileUrl(url) {
          if (url.startsWith("design-system/")) {
            const resolved = url.replace(
              "design-system/",
              "./design-system/build/scss/",
            );
            return new URL(resolved, import.meta.url);
          }
          return null;
        },
      },
    ],
  }),
];

let opts = {
  entryPoints: ["js/app.js"],
  bundle: true,
  logLevel: "info",
  target: "es2015",
  outdir: "../priv/static/assets",
  nodePaths: ["./node_modules"],
  plugins: plugins,
  define: {
    "process.env.NODE_ENV": JSON.stringify(
      deploy ? "production" : "development",
    ),
  },
  external: ["*.ttf", "*.woff", "*.woff2", "*.eot", "*.otf", "*.svg"],
};

if (deploy) {
  opts = {
    ...opts,
    minify: true,
  };
}

if (watch) {
  opts = {
    ...opts,
    sourcemap: "inline",
  };
  esbuild
    .context(opts)
    .then((ctx) => {
      ctx.watch();
    })
    .catch((_error) => {
      process.exit(1);
    });
} else {
  esbuild.build(opts);
}
