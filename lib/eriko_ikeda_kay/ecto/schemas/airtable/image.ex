defmodule ErikoIkedaKay.Ecto.Schemas.Airtable.Image do
  use Ecto.Schema

  import Ecto.Changeset

  alias ErikoIkedaKay.Ecto.Types

  embedded_schema do
    field :filename, :string
    field :type, :string
    field :size, :integer
    field :width, :integer
    field :height, :integer
    field :url, Types.URI
    field :thumbnails, :map
  end

  def changeset(%__MODULE__{} = schema, params \\ %{}) do
    schema
    |> cast(params, [
      :id,
      :filename,
      :type,
      :size,
      :width,
      :height,
      :url,
      :thumbnails
    ])
    |> validate_required([
      :id,
      :filename,
      :type,
      :size,
      :width,
      :height,
      :url,
      :thumbnails
    ])
  end

  def validate(%__MODULE__{} = schema, params \\ %{}) do
    changeset(schema, params)
    |> apply_action(:validate)
  end

  def from_airtable_field(field) do
    validate(%__MODULE__{}, params_from_airtable_field(field))
  end

  def params_from_airtable_field(%{} = attachment) do
    %{
      id: attachment["id"],
      filename: attachment["filename"],
      type: attachment["type"],
      size: attachment["size"],
      width: attachment["width"],
      height: attachment["height"],
      url: attachment["url"],
      thumbnails: attachment["thumbnails"]
    }
  end

  def params_from_airtable_field(_) do
    nil
  end
end
