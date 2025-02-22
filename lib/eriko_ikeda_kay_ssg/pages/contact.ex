defmodule ErikoIkedaKaySSG.Pages.Contact do
  use ErikoIkedaKaySSG

  import ErikoIkedaKaySSG.Templates.Layouts
  import ErikoIkedaKaySSG.Templates.Pages

  def meta(%{locale: locale}) do
    %{
      permalink: localize_path(locale, "/contact")
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
        <.contact locale={@locale} profile={@data.profile} />
      </.page>
    </.root>
    """
  end
end
