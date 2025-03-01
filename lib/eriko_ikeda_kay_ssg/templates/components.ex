defmodule ErikoIkedaKaySSG.Templates.Components do
  use ErikoIkedaKaySSG

  alias Earmark
  alias Phoenix.HTML

  def rich_text(
        %{
          node: %{
            "nodeType" => "document"
          }
        } = assigns
      ) do
    ~H"""
    <.rich_text :for={node <- @node.contents} node={node} />
    """
  end

  def rich_text(
        %{
          node: %{
            "nodeType" => "paragraph"
          }
        } = assigns
      ) do
    ~H"""
    <p>
      <.rich_text :for={node <- @node.contents} node={node} />
    </p>
    """
  end

  def rich_text(
        %{
          node: %{
            "nodeType" => "heading-1"
          }
        } = assigns
      ) do
    ~H"""
    <h1>
      <.rich_text :for={node <- @node.contents} node={node} />
    </h1>
    """
  end

  def rich_text(
        %{
          node: %{
            "nodeType" => "heading-2"
          }
        } = assigns
      ) do
    ~H"""
    <h2>
      <.rich_text :for={node <- @node.contents} node={node} />
    </h2>
    """
  end

  def rich_text(
        %{
          node: %{
            "nodeType" => "heading-3"
          }
        } = assigns
      ) do
    ~H"""
    <h3>
      <.rich_text :for={node <- @node.contents} node={node} />
    </h3>
    """
  end

  def rich_text(
        %{
          node: %{
            "value" => _value
          }
        } = assigns
      ) do
    ~H"""
    {@node.value}
    """
  end

  attr(:image, :map, required: true)
  attr(:rest, :global)

  def image(assigns) do
    ~H"""
    <img
      src={URI.to_string(@image.url)}
      alt={@image.filename}
      width={@image.width}
      height={@image.height}
      {@rest}
    />
    """
  end

  attr(:image, :map, required: true)
  attr(:rest, :global)

  def contentful_image(assigns) do
    ~H"""
    <img
      src={URI.to_string(@image.file_url)}
      alt={@image.file_name}
      width={@image.image_width}
      height={@image.image_height}
      {@rest}
    />
    """
  end

  attr(:file, :map, required: true)
  attr(:rest, :global)

  def contentful_file_link(assigns) do
    ~H"""
    <a href={URI.to_string(@file.file_url)} target="_blank" download>
      {@file.file_name}
    </a>
    """
  end

  attr(:markdown, :string, required: true)

  def markdown(assigns) do
    ~H"""
    {HTML.raw(Earmark.as_html!(@markdown))}
    """
  end

  attr(:locale, :atom, required: true)
  attr(:project, :map, required: true)
  attr(:rest, :global)

  def project_record(assigns) do
    ~H"""
    <div class="project-record" {@rest}>
      <div>
        <span class="project-record-date">
          {@project.published_at |> DateTime.to_date() |> Date.to_iso8601()}
        </span>
      </div>
      <div class="project-record-details">
        <%= if @project.url do %>
          <a
            class="project-record-details-title"
            href={@project.url}
            target="_blank"
          >
            {@project.title}
            <.external_link_icon />
          </a>
        <% else %>
          <span class="project-record-details-title">
            {@project.title}
            <.external_link_icon />
          </span>
        <% end %>
        <ul class="tag-list project-record-details-tags">
          <li :for={tag <- @project.tags}>
            <.link navigate={localize_path(@locale, "/tags/#{tag}")}>
              #{tag}
            </.link>
          </li>
        </ul>
        <div :if={@project.description} class="project-record-details-description">
          <.markdown markdown={@project.description} />
        </div>
      </div>
    </div>
    """
  end

  def external_link_icon(assigns) do
    ~H"""
    <svg
      class="icon"
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 20 20"
      fill="currentColor"
    >
      <path
        fill-rule="evenodd"
        clip-rule="evenodd"
        d="M5.22 14.78a.75.75 0 001.06 0l7.22-7.22v5.69a.75.75 0 001.5 0v-7.5a.75.75 0 00-.75-.75h-7.5a.75.75 0 000 1.5h5.69l-7.22 7.22a.75.75 0 000 1.06z"
      >
      </path>
    </svg>
    """
  end

  attr(:active?, :boolean)
  attr(:navigate, :string, required: true)
  attr(:path, :string, required: true)
  attr(:rest, :global)
  slot(:inner_block)

  def nav_link(%{navigate: navigate, path: path} = assigns) do
    assigns =
      assign_new(assigns, :active?, fn -> subpath?(navigate, path) end)

    ~H"""
    <.link class={["nav-link", @active? && "active"]} navigate={@navigate}>
      {render_slot(@inner_block)}
    </.link>
    """
  end
end
