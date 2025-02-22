defmodule ErikoIkedaKaySSG.Pages.Tag do
  use ErikoIkedaKaySSG

  import ErikoIkedaKaySSG.Templates.Layouts
  import ErikoIkedaKaySSG.Templates.Pages

  def meta(%{locale: locale, tag: tag}) do
    %{
      permalink: localize_path(locale, "/tags/#{tag.name}")
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
        <.tag locale={@locale} tag={@tag} />
      </.page>
    </.root>
    """
  end
end
