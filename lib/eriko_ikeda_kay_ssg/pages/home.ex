defmodule ErikoIkedaKaySSG.Pages.Home do
  use ErikoIkedaKaySSG

  import ErikoIkedaKaySSG.Templates.Layouts
  import ErikoIkedaKaySSG.Templates.Pages

  def meta(%{locale: locale}) do
    %{
      permalink: localize_path(locale, "/")
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
        <.home locale={@locale} blocks={@data.blocks} profile={@data.profile} />
      </.page>
    </.root>
    """
  end
end
