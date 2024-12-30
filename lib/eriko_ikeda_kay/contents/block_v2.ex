defmodule ErikoIkedaKay.Contents.BlockV2 do
  use Ecto.Schema

  import Ecto.Changeset

  alias ErikoIkedaKay.Ecto.Schemas

  @primary_key {:slug, :string, autogenerate: false}

  embedded_schema do
    field :index, :integer
    field :title, :string
    field :body, :string

    embeds_one :image, Schemas.Contentful.Image
    embeds_many :attachments, Schemas.Contentful.File
  end

  def changeset(%__MODULE__{} = schema, params \\ %{}) do
    schema
    |> cast(params, [
      :slug,
      :index,
      :title,
      :body
    ])
    |> cast_embed(:image, with: &Schemas.Contentful.Image.changeset/2)
    |> cast_embed(:attachments,
      with: &Schemas.Contentful.File.changeset/2
    )
    |> validate_required([
      :slug,
      :index,
      :title,
      :body
    ])
  end

  def validate(%__MODULE__{} = schema, params \\ %{}) do
    changeset(schema, params)
    |> apply_action(:validate)
  end

  def from_contentful_entries(records, assets) do
    Extra.Either.sequence_map(
      records,
      &from_contentful_entry(&1, assets)
    )
  end

  def from_contentful_entry(
        %{"fields" => fields},
        assets
      ) do
    validate(
      %__MODULE__{
        image:
          assets
          |> Enum.find(&(&1.id == get_in(fields, ["image", "sys", "id"]))),
        attachments:
          (fields["attachments"] || [])
          |> Enum.map(&get_in(&1, ["sys", "id"]))
          |> Enum.map(fn id ->
            assets
            |> Enum.find(&(&1.id == id))
          end)
          |> Enum.filter(& &1)
      },
      %{
        slug: fields["slug"],
        index: fields["index"],
        title: fields["title"],
        body: fields["body"]
      }
    )
  end
end
