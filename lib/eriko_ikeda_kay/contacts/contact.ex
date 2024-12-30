defmodule ErikoIkedaKay.Contacts.Contact do
  use Ecto.Schema

  import Ecto.Changeset

  embedded_schema do
    field :name, :string
    field :email, :string
    field :message, :string
  end

  def changeset(%__MODULE__{} = schema, params \\ %{}) do
    schema
    |> cast(params, [
      :name,
      :email,
      :message
    ])
    |> validate_required([
      :name,
      :email,
      :message
    ])
  end

  def validate(%__MODULE__{} = schema, params \\ %{}) do
    schema
    |> changeset(params)
    |> apply_action(:validate)
  end
end
