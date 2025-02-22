defmodule ErikoIkedaKaySSG.Pages.Tags do
  use ErikoIkedaKaySSG

  import ErikoIkedaKaySSG.Templates.Layouts
  import ErikoIkedaKaySSG.Templates.Pages

  def meta(%{locale: locale}) do
    %{
      permalink: localize_path(locale, "/tags")
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
        <.tags locale={@locale} tags={@data.tags} />
      </.page>
    </.root>
    """
  end
end
