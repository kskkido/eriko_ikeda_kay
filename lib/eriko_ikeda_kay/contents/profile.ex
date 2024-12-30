defmodule ErikoIkedaKay.Contents.Profile do
  use Ecto.Schema

  import Ecto.Changeset

  alias ErikoIkedaKay.Ecto.Schemas

  embedded_schema do
    field :email, :string
    field :name, :string
    field :title, :string

    embeds_one :resume_en, Schemas.Airtable.Attachment
  end

  def changeset(%__MODULE__{} = schema, params \\ %{}) do
    schema
    |> cast(params, [
      :id,
      :name,
      :title,
      :email
    ])
    |> cast_embed(:resume_en, with: &Schemas.Airtable.Attachment.changeset/2)
    |> validate_required([
      :id,
      :name,
      :title,
      :email
    ])
  end

  def validate(%__MODULE__{} = schema, params \\ %{}) do
    changeset(schema, params)
    |> apply_action(:validate)
  end

  def from_airtable_records(records) do
    {profiles, errors} =
      Extra.Enum.partition_map(
        records,
        &from_airtable_record/1
      )

    if length(errors) > 0 do
      {:error, length(errors)}
    else
      {:ok, profiles}
    end
  end

  def from_airtable_record(%{} = record) do
    validate(%__MODULE__{}, params_from_airtable_record(record))
  end

  def params_from_airtable_record(%{"fields" => fields}) do
    %{
      id: fields["id"],
      email: fields["email"],
      name: fields["name"],
      title: fields["title"],
      resume_en:
        (fields["resume_en"] || [])
        |> List.first()
        |> Schemas.Airtable.Attachment.params_from_airtable_field()
    }
  end
end
