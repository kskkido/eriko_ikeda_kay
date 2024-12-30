defmodule ErikoIkedaKay.Contents.Block do
  use Ecto.Schema

  import Ecto.Changeset

  alias ErikoIkedaKay.Ecto.Schemas

  embedded_schema do
    field :index, :integer
    field :title, :string
    field :body, :string

    embeds_one :image, Schemas.Airtable.Image
    embeds_many :attachments, Schemas.Airtable.Attachment
  end

  def changeset(%__MODULE__{} = schema, params \\ %{}) do
    schema
    |> cast(params, [
      :id,
      :index,
      :title,
      :body
    ])
    |> cast_embed(:image, with: &Schemas.Airtable.Image.changeset/2)
    |> cast_embed(:attachments, with: &Schemas.Airtable.Attachment.changeset/2)
    |> validate_required([
      :id,
      :index,
      :title,
      :body
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
      index: fields["index"],
      title: fields["title"],
      body: fields["body"],
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
