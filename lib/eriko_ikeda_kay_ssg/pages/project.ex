defmodule ErikoIkedaKaySSG.Pages.Project do
  use ErikoIkedaKaySSG

  import ErikoIkedaKaySSG.Templates.Layouts
  import ErikoIkedaKaySSG.Templates.Pages

  def meta(%{locale: locale, project: project}) do
    %{
      permalink: localize_path(locale, "/works/#{project.slug}")
    }
  end

  def template(assigns) do
    ~H"""
    <.root locale={@locale} data={@data} profile={@data.profile}>
      <.page
        locale={@locale}
        data={@data}
        profile={@data.profile}
        current_path={@meta.permalink}
      >
        <.project locale={@locale} project={@project} />
      </.page>
    </.root>
    """
  end
end
