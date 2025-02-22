defmodule ErikoIkedaKay.Contents do
  alias ErikoIkedaKay.Contentful
  alias ErikoIkedaKay.Contents.BlockV2
  alias ErikoIkedaKay.Contents.ProfileV2
  alias ErikoIkedaKay.Contents.ProjectV2
  alias ErikoIkedaKay.Contents.ProjectTag
  alias ErikoIkedaKay.Ecto.Schemas

  def list_assets() do
    {:ok, assets} =
      ErikoIkedaKay.Contentful.list_assets()
      |> Extra.Either.sequence_map(
        &Extra.Either.alt(
          Schemas.Contentful.Image.from_contentful_asset(&1),
          Schemas.Contentful.File.from_contentful_asset(&1)
        )
      )

    assets
  end

  def get_profile_v2(context) do
    list_profiles_v2(context)
    |> Enum.find(&(&1.slug == "eriko_ikeda_kay"))
  end

  def list_profiles_v2(context) do
    {:ok, profiles} =
      context
      |> Map.merge(%{content_type: "profile"})
      |> Contentful.list_entries()
      |> ProfileV2.from_contentful_entries()

    profiles
  end

  def list_projects_v2(context) do
    {:ok, projects} =
      context
      |> Map.merge(%{content_type: "project"})
      |> Contentful.list_entries()
      |> ProjectV2.from_contentful_entries(list_assets())

    projects
    |> Enum.sort_by(& &1.published_at, {:desc, DateTime})
  end

  def list_project_tags_v2(context) do
    list_projects_v2(context)
    |> Enum.reduce(%{}, fn project, acc ->
      project.tags
      |> Enum.reduce(acc, fn tag, accc ->
        Map.update(accc, tag, [project], &Enum.concat(&1, [project]))
      end)
    end)
    |> Map.to_list()
    |> Enum.map(fn {name, projects} ->
      %ProjectTag{name: name, projects: projects}
    end)
    |> Enum.sort_by(& &1.name, :asc)
  end

  def list_blocks_v2(context) do
    {:ok, blocks} =
      context
      |> Map.merge(%{content_type: "block"})
      |> Contentful.list_entries()
      |> BlockV2.from_contentful_entries(list_assets())

    blocks
    |> Enum.sort_by(& &1.index, :asc)
  end
end
