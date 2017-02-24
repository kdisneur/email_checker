defmodule EmailChecker.MX do

  defp max_timeout(), do: Application.get_env(:email_checker, :timeout_milliseconds, :infinity)

  def valid?(email) do
    email
    |> EmailChecker.Tools.domain_name
    |> EmailChecker.MX.lookup
    |> present?
  end

  def lookup(nil) do
    nil
  end
  def lookup(domain_name) do
    domain_name
    |> lookup_all
    |> take_lowest_mx_record
  end

  defp lookup_all(domain_name) do
    domain_name
    |> String.to_char_list
    |> :inet_res.lookup(:in, :mx, [], max_timeout)
    |> normalize_mx_records_to_string
  end

  defp normalize_mx_records_to_string(nil) do
    []
  end
  defp normalize_mx_records_to_string(domains) do
    normalize_mx_records_to_string(domains, [])
  end
  defp normalize_mx_records_to_string([], normalized_domains) do
    normalized_domains
  end
  defp normalize_mx_records_to_string([{ priority, domain }|domains], normalized_domains) do
    normalize_mx_records_to_string(domains, [{ priority, to_string(domain)}|normalized_domains])
  end

  defp present?(nil) do
    false
  end
  defp present?(string) do
    String.length(string) > 0
  end

  defp sort_mx_records_by_priority(nil) do
    []
  end
  defp sort_mx_records_by_priority(domains) do
    Enum.sort(domains, fn({ priority, _domain }, { other_priority, _other_domain}) ->
      priority < other_priority
    end)
  end

  defp take_lowest_mx_record(mx_records) do
    case mx_records |> sort_mx_records_by_priority do
      [{_lower_priority, domain}|_rest] ->
        domain
      _ ->
        nil
    end
  end
end
