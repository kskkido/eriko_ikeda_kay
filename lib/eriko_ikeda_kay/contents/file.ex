defmodule ErikoIkedaKay.Contents.File do
  use Ecto.Schema

  import Ecto.Changeset

  alias Contentful
  alias ErikoIkedaKay.Ecto.Types

  embedded_schema do
    field :title, :string
    field :description, :string
    field :content_type, :string
    field :file_name, :string
    field :file_size, :integer
    field :file_url, Types.URI
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
      :file_url
    ])
    |> validate_required([
      :id,
      :title,
      :content_type,
      :file_name,
      :file_size,
      :file_url
    ])
  end

  def validate(%__MODULE__{} = schema, params \\ %{}) do
    changeset(schema, params)
    |> apply_action(:validate)
  end

  def from_contentful_asset(%Contentful.Asset{} = asset) do
    validate(%__MODULE__{}, params_from_contentful_asset(asset))
  end

  def params_from_contentful_asset(%Contentful.Asset{} = asset) do
    %{
      id: asset.sys.id,
      title: asset.fields.title,
      description: asset.fields.description,
      content_type: asset.fields.file.content_type,
      file_name: asset.fields.file.file_name,
      file_size: asset.fields.file.details["size"],
      file_url: asset.fields.file.url
    }
  end
end
