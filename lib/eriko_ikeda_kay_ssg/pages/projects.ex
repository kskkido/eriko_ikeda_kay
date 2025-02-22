defmodule ErikoIkedaKaySSG.Pages.Projects do
  use ErikoIkedaKaySSG

  import ErikoIkedaKaySSG.Templates.Layouts
  import ErikoIkedaKaySSG.Templates.Pages

  def meta(%{locale: locale}) do
    %{
      permalink: localize_path(locale, "/works")
    }
  end

  def template(assigns) do
    ~H"""
    <.root locale={@locale} profile={@data.profile}>
      <.page locale={@locale} profile={@data.profile} current_path={@meta.permalink}>
        <.projects locale={@locale} projects={@data.projects} />
      </.page>
    </.root>
    """
  end
end
