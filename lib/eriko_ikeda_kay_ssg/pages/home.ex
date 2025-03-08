defmodule ErikoIkedaKaySSG.Pages.Home do
  use ErikoIkedaKaySSG

  import ErikoIkedaKaySSG.Templates.Layouts
  import ErikoIkedaKaySSG.Templates.Pages

  alias ErikoIkedaKay.Contents

  def meta(%{locale: locale}) do
    %{
      permalink: localize_path(locale, "/")
    }
  end

  def template(assigns) do
    assigns =
      Map.put_new_lazy(assigns, :metadata, fn ->
        description =
          case List.first(assigns.data.blocks, nil) do
            nil -> nil
            block -> Contents.get_block_description(block)
          end

        image =
          case List.first(assigns.data.blocks, nil) do
            nil -> nil
            block -> "https:#{block.image.file_url}"
          end

        [
          %{
            name: "description",
            content: description
          },
          %{
            property: "og:description",
            content: description
          },
          %{
            name: "image",
            content: image
          },
          %{
            property: "og:image",
            content: image
          }
        ]
        |> Enum.filter(fn metadata -> metadata.content end)
      end)

    ~H"""
    <.root
      locale={@locale}
      data={@data}
      profile={@data.profile}
      metadata={@metadata}
    >
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
