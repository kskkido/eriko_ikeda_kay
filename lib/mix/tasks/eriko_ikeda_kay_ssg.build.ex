defmodule Mix.Tasks.ErikoIkedaKaySsg.Build do
  use Mix.Task

  alias ErikoIkedaKay.Contents
  alias ErikoIkedaKaySSG.Pages

  @locales [:en, :ja]

  @impl Mix.Task
  def run(_) do
    Mix.Task.run("app.start")

    config =
      :eriko_ikeda_kay
      |> Application.fetch_env!(:ssg)
      |> Map.new()

    pages =
      @locales
      |> Enum.map(&build_context/1)
      |> Enum.map(&render_site/1)
      |> Enum.concat()

    File.mkdir_p!(config.outdir)

    for {meta, html} <- pages do
      write_page(config, permalink_to_path(meta.permalink), html)
    end

    if File.exists?(config.static_dir) do
      File.cp_r!(config.static_dir, config.outdir)
    end
  end

  def build_context(locale) do
    context = %{locale: locale}

    %{
      locale: locale,
      data: %{
        profile: Contents.get_profile_v2(context),
        blocks: Contents.list_blocks_v2(context),
        projects: Contents.list_projects_v2(context),
        tags: Contents.list_project_tags_v2(context)
      }
    }
  end

  def render_site(context) do
    Gettext.put_locale(Atom.to_string(context.locale))

    [
      [{Pages.Home, context}],
      [{Pages.Projects, context}],
      context.data.projects
      |> Enum.filter(&(&1.body != nil))
      |> Enum.map(&{Pages.Project, Map.merge(context, %{project: &1})}),
      [{Pages.Tags, context}],
      Enum.map(context.data.tags, fn tag ->
        {Pages.Tag, Map.merge(context, %{tag: tag})}
      end)
    ]
    |> Enum.concat()
    |> Enum.map(&render_page/1)
  end

  def render_page({mod, context}) do
    meta = apply(mod, :meta, [context])
    {meta, apply(mod, :template, [Map.merge(context, %{meta: meta})])}
  end

  def write_page(config, path, html) do
    html = Phoenix.HTML.Safe.to_iodata(html)
    path = Path.join([config.outdir, path])
    dir = Path.dirname(path)
    File.mkdir_p!(dir)
    File.write!(path, html)
  end

  defp permalink_to_path(permalink) do
    if Path.extname(permalink) in [".html"] do
      permalink
    else
      Path.join([permalink, "index.html"])
    end
  end
end
