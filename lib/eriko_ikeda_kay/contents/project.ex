defmodule ErikoIkedaKay.Contents.Project do
  use Ecto.Schema

  import Ecto.Changeset

  alias ErikoIkedaKay.Ecto.Schemas
  alias ErikoIkedaKay.Ecto.Types

  embedded_schema do
    field :title, :string
    field :description, :string
    field :link, Types.URI
    field :published_at, Types.Airtable.DateTime
    field :tags, {:array, :string}

    embeds_one :image, Schemas.Airtable.Image
    embeds_many :attachments, Schemas.Airtable.Attachment
  end

  def changeset(%__MODULE__{} = schema, params \\ %{}) do
    schema
    |> cast(params, [
      :id,
      :title,
      :description,
      :link,
      :published_at,
      :tags
    ])
    |> cast_embed(:image, with: &Schemas.Airtable.Image.changeset/2)
    |> cast_embed(:attachments, with: &Schemas.Airtable.Attachment.changeset/2)
    |> validate_required([
      :id,
      :title,
      :description,
      :link,
      :published_at,
      :tags
    ])
  end

  def validate(%__MODULE__{} = schema, params \\ %{}) do
    changeset(schema, params)
    |> apply_action(:validate)
  end

  def from_airtable_records(records) do
    {projects, errors} =
      Extra.Enum.partition_map(
        records,
        &from_airtable_record/1
      )

    if length(errors) > 0 do
      {:error, length(errors)}
    else
      {:ok, projects}
    end
  end

  def from_airtable_record(%{} = record) do
    validate(%__MODULE__{}, params_from_airtable_record(record))
  end

  def params_from_airtable_record(%{"fields" => fields}) do
    %{
      id: fields["id"],
      title: fields["title"],
      description: fields["description"],
      link: fields["link"],
      published_at: fields["published_at"],
      tags: fields["name (from tags)"],
      image:
        (fields["image"] || [])
        |> List.first()
        |> Schemas.Airtable.Image.params_from_airtable_field(),
      attachments:
        Enum.map(
          fields["attachments"] || [],
          &Schemas.Airtable.Attachment.params_from_airtable_field/1
        )
    }
  end
end
