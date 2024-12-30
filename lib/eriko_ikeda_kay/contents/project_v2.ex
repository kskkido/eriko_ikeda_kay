defmodule ErikoIkedaKay.Contents.ProjectV2 do
  use Ecto.Schema

  import Ecto.Changeset

  alias ErikoIkedaKay.Ecto.Schemas
  alias ErikoIkedaKay.Ecto.Types

  @primary_key {:slug, :string, autogenerate: false}

  embedded_schema do
    field :title, :string
    field :description, :string
    field :body, :string
    field :published_at, Types.DateTime
    field :url, Types.URI
    field :tags, {:array, :string}

    embeds_one :image, Schemas.Contentful.Image
    embeds_many :attachments, Schemas.Contentful.File
  end

  def changeset(%__MODULE__{} = schema, params \\ %{}) do
    schema
    |> cast(params, [
      :slug,
      :title,
      :description,
      :body,
      :url,
      :published_at,
      :tags
    ])
    |> cast_embed(:image, with: &Schemas.Contentful.Image.changeset/2)
    |> cast_embed(:attachments,
      with: &Schemas.Contentful.File.changeset/2
    )
    |> validate_required([
      :slug,
      :title,
      :description,
      :body,
      :url,
      :published_at,
      :tags
    ])
  end

  def validate(%__MODULE__{} = schema, params \\ %{}) do
    schema
    |> changeset(params)
    |> apply_action(:validate)
  end

  def from_contentful_entries(records, assets) do
    Extra.Either.sequence_map(
      records,
      &from_contentful_entry(&1, assets)
    )
  end

  def from_contentful_entry(
        %{"fields" => fields, "metadata" => metadata},
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
        title: fields["title"],
        description: fields["description"],
        body: fields["body"],
        url: fields["url"],
        published_at: fields["publishedAt"],
        tags:
          (metadata["tags"] || [])
          |> Enum.map(&get_in(&1, ["sys", "id"]))
          |> Enum.filter(& &1)
      }
    )
  end
end
