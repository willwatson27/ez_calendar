defmodule EZCalendar.QueryRunner do
  import Ecto.Query

  defmodule QueryParams do
    defstruct [:key, :query, :repo, :starting, :ending, :field, :results]
  end
  
  def run(queries, repo, starting, ending, _opts) when is_list(queries) do
    build_multi_query(queries, repo, starting, ending)
    |> fetch_results
  end 

  def run(query, repo, starting, ending, opts) do
    build_query(query, repo, starting, ending, opts)
    |> fetch_results
  end

  defp build_query query, repo, starting, ending, opts do
    field = opts[:field] || Application.get_env(:ez_calendar, :default_field, :date)

    %QueryParams{
      query: query,
      repo: repo,
      starting: starting,
      ending: ending,
      field: field,
    } 
  end

  defp build_multi_query queries, repo, starting, ending do
    queries
    |> Enum.map(fn({key, [query, field]})->
      %QueryParams{
        key: key,
        query: query,
        repo: repo,
        starting: starting,
        ending: ending,
        field: field,
      }
    end)
  end

  ###
  # Results
  ###

  defp fetch_results(queries) when is_list(queries), do: Enum.map(queries, &fetch_results/1)

  defp fetch_results(query) do
    results =
    try do
      do_query_results(query, query.starting, query.ending)
    rescue
      _e in Ecto.Query.CastError ->
        start_date = query.starting |> Ecto.Date.cast! |> Ecto.DateTime.from_date
        end_date = query.ending |> Ecto.Date.cast! |> Ecto.DateTime.from_date       
        do_query_results(query, start_date, end_date)
    end
    
    %{query | results: results}
  end

  defp do_query_results params, starting, ending do
     case params.field do
      {_, _} -> params |> range_query_results(starting, ending)
      _  -> params |> query_results(starting, ending)
    end   
  end

  defp query_results params, starting, ending do
    from( q in params.query, 
      where: field(q, ^params.field) >= ^starting
        and  field(q, ^params.field) <= ^ending 
    )
    |> params.repo.all
  end

  defp range_query_results params, starting, ending do
    {starting_field, ending_field} = params.field

    from( q in params.query,
      where: (field(q, ^starting_field) >= ^starting 
              and  field(q, ^starting_field) <= ^ending) 
            or (field(q, ^ending_field) >= ^starting 
              and  field(q, ^ending_field) <= ^ending)
    )
    |> params.repo.all
  end

end