defmodule ErikoIkedaKay.Contents do
  alias ErikoIkedaKay.Airtable
  alias ErikoIkedaKay.Contentful
  alias ErikoIkedaKay.Contents.Block
  alias ErikoIkedaKay.Contents.BlockV2
  alias ErikoIkedaKay.Contents.Profile
  alias ErikoIkedaKay.Contents.ProfileV2
  alias ErikoIkedaKay.Contents.Project
  alias ErikoIkedaKay.Contents.ProjectV2
  alias ErikoIkedaKay.Contents.ProjectTag
  alias ErikoIkedaKay.Ecto.Schemas

  def get_profile do
    get_profile_by_id("eriko")
  end

  def get_profile_by_id(id) do
    Enum.find(list_profiles(), &(&1.id == id))
  end

  def list_profiles() do
    {:ok, profiles} =
      "profiles"
      |> Airtable.list_records()
      |> Profile.from_airtable_records()

    profiles
  end

  def get_project_by_id(id) do
    Enum.find(list_projects(), &(&1.id == id))
  end

  def list_projects() do
    {:ok, projects} =
      "projects"
      |> Airtable.list_records()
      |> Project.from_airtable_records()

    projects
    |> Enum.sort_by(& &1.published_at, :desc)
  end

  def get_project_tag_by_name(name) do
    list_project_tags()
    |> Enum.find(&(&1.name == name))
  end

  def list_project_tags() do
    list_projects()
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

  def get_about do
    get_block_by_id("about")
  end

  def get_block_by_id(id) do
    Enum.find(list_blocks(), &(&1.id == id))
  end

  def list_blocks() do
    {:ok, blocks} =
      "blocks"
      |> Airtable.list_records()
      |> Block.from_airtable_records()

    blocks
    |> Enum.sort_by(& &1.index, :asc)
  end

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

  def get_profile_v2() do
    list_profiles_v2()
    |> Enum.find(&(&1.slug == "eriko_ikeda_kay"))
  end

  def list_profiles_v2() do
    {:ok, profiles} =
      Contentful.list_entries_by_content_type("profile")
      |> ProfileV2.from_contentful_entries()

    profiles
  end

  def get_project_v2_by_slug(slug) do
    list_projects_v2()
    |> Enum.find(&(&1.slug == slug))
  end

  def list_projects_v2() do
    {:ok, projects} =
      Contentful.list_entries_by_content_type("project")
      |> ProjectV2.from_contentful_entries(list_assets())

    projects
    |> Enum.sort_by(& &1.published_at, :desc)
  end

  def get_project_tag_v2_by_name(name) do
    list_project_tags_v2()
    |> Enum.find(&(&1.name == name))
  end

  def list_project_tags_v2() do
    list_projects_v2()
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

  def list_blocks_v2() do
    {:ok, blocks} =
      Contentful.list_entries_by_content_type("block")
      |> BlockV2.from_contentful_entries(list_assets())

    blocks
    |> Enum.sort_by(& &1.index, :asc)
  end
end
