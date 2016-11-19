defmodule EZCalendar.QueryRunner do
  import Ecto.Query
  
  alias EZCalendar.QueryRunner
  defstruct [:key, :query, :repo, :starting, :ending, :field, :results]

  def run(queries, repo, starting, ending, opts) when is_list(queries) do
    build_multi_query(queries, repo, starting, ending, opts)
    |> fetch_results
  end 

  def run(query, repo, starting, ending, opts) do
    build_query(query, repo, starting, ending, opts)
    |> fetch_results
  end

  defp build_query query, repo, starting, ending, opts do
    field = get_field(opts)

    %QueryRunner{
      query: query,
      repo: repo,
      starting: starting,
      ending: ending,
      field: field,
    } 
  end

  defp build_multi_query queries, repo, starting, ending, opts do
    queries
    |> Enum.map(fn({key, query})->
      # use default field if not given
      {query, field} =
      case to_tuple(query) do
        {q, field} -> 
          {q, field}
        q -> 
          field = get_field(opts)
          {q, field}
      end
      # build query
      %QueryRunner{
        key: key,
        query: query,
        repo: repo,
        starting: starting,
        ending: ending,
        field: field,
      }
    end)
  end


  defp get_field(opts) do
    opts[:field] || Application.get_env(:ez_calendar, :default_field, :date)
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
     case to_tuple(params.field)do
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
    {starting_field, ending_field} = to_tuple(params.field)

    from( q in params.query,
      where: (field(q, ^starting_field) >= ^starting 
              and  field(q, ^starting_field) <= ^ending) 
            or (field(q, ^ending_field) >= ^starting 
              and  field(q, ^ending_field) <= ^ending)
    )
    |> params.repo.all
  end

  defp to_tuple(list) when is_list(list),  do: List.to_tuple(list)
  defp to_tuple(list), do: list
end