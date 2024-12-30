defmodule ErikoIkedaKay.Contents.ProfileV2 do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:slug, :string, autogenerate: false}

  embedded_schema do
    field :email, :string
    field :name, :string
    field :title, :string
  end

  def changeset(%__MODULE__{} = schema, params \\ %{}) do
    schema
    |> cast(params, [
      :slug,
      :name,
      :title,
      :email
    ])
    |> validate_required([
      :slug,
      :name,
      :title,
      :email
    ])
  end

  def validate(%__MODULE__{} = schema, params \\ %{}) do
    changeset(schema, params)
    |> apply_action(:validate)
  end

  def from_contentful_entries(records) do
    Extra.Either.sequence_map(
      records,
      &from_contentful_entry/1
    )
  end

  def from_contentful_entry(%{"fields" => fields}) do
    validate(
      %__MODULE__{},
      %{
        slug: fields["slug"],
        email: fields["email"],
        name: fields["name"],
        title: fields["title"]
      }
    )
  end
end
