defmodule TidbitsWeb.UserView do
  use TidbitsWeb, :view

  def gravatar(email) do
    hash = email
    |> String.trim()
    |> String.downcase()
    |> :erlang.md5()
    |> Base.encode16(case: :lower)

    img = "https://www.gravatar.com/avatar/#{hash}?s=150&d=identicon"
    img_tag(img)
  end

end
