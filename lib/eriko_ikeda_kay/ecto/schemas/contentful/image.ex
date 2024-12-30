defmodule ErikoIkedaKay.Ecto.Schemas.Contentful.Image do
  use Ecto.Schema

  import Ecto.Changeset

  alias ErikoIkedaKay.Ecto.Types

  embedded_schema do
    field :title, :string
    field :description, :string
    field :content_type, :string
    field :file_name, :string
    field :file_size, :integer
    field :file_url, Types.URI
    field :image_width, :integer
    field :image_height, :integer
  end

  def changeset(%__MODULE__{} = schema, params \\ %{}) do
    schema
    |> cast(params, [
      :id,
      :title,
      :description,
      :content_type,
      :file_name,
      :file_size,
      :file_url,
      :image_width,
      :image_height
    ])
    |> validate_required([
      :id,
      :title,
      :content_type,
      :file_name,
      :file_size,
      :file_url,
      :image_width,
      :image_height
    ])
  end

  def validate(%__MODULE__{} = schema, params \\ %{}) do
    changeset(schema, params)
    |> apply_action(:validate)
  end

  def from_contentful_assets(assets) do
    {data, errors} =
      Extra.Enum.partition_map(
        assets,
        &from_contentful_asset/1
      )

    if length(errors) > 0 do
      {:error, length(errors)}
    else
      {:ok, data}
    end
  end

  def from_contentful_asset(asset) do
    validate(%__MODULE__{}, params_from_contentful_asset(asset))
  end

  def params_from_contentful_asset(asset) do
    %{
      id: get_in(asset, ["sys", "id"]),
      title: get_in(asset, ["fields", "title"]),
      description: get_in(asset, ["fields", "description"]),
      content_type: get_in(asset, ["fields", "file", "contentType"]),
      file_name: get_in(asset, ["fields", "file", "fileName"]),
      file_size: get_in(asset, ["fields", "file", "details", "size"]),
      file_url: get_in(asset, ["fields", "file", "url"]),
      image_width:
        get_in(asset, ["fields", "file", "details", "image", "width"]),
      image_height:
        get_in(asset, ["fields", "file", "details", "image", "height"])
    }
  end
end
