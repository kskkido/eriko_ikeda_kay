defmodule ErikoIkedaKay.Contents.About do
  use Ecto.Schema

  import Ecto.Changeset

  alias Contentful
  alias ErikoIkedaKay.Contents

  embedded_schema do
    field :title, :string
    field :body, :map
    field :description, :string

    embeds_one :image, Contents.File
  end

  def changeset(%__MODULE__{} = schema, params \\ %{}) do
    schema
    |> cast(params, [
      :id,
      :title,
      :body,
      :description
    ])
    |> cast_embed(:image, with: &Contents.File.changeset/2)
    |> validate_required([
      :id,
      :title,
      :body,
      :description
    ])
  end

  def validate(%__MODULE__{} = schema, params \\ %{}) do
    changeset(schema, params)
    |> apply_action(:validate)
  end

  def from_contentful_entry(%Contentful.Entry{} = entry) do
    validate(%__MODULE__{}, params_from_contentful_entry(entry))
  end

  def params_from_contentful_entry(%Contentful.Entry{} = entry) do
    %{
      id: entry.sys.id,
      title: entry.fields["title"],
      body: entry.fields["body"],
      description: entry.fields["description"],
      image: Contents.File.params_from_contentful_asset(entry.fields["image"])
    }
  end
end
