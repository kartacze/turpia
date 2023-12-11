defmodule KinoCustoms.Iframe do
  use Kino.JS

  def new(source) do
    Kino.JS.new(__MODULE__, source)
  end

  asset "main.js" do
    """
    export function init(ctx, source) {
      var ifrm = document.createElement("iframe");
      ifrm.setAttribute("src", source);
      ifrm.style.width = "100%";
      ifrm.style.height = "900px";
      ifrm.style.border = "0";
      ctx.root.appendChild(ifrm);
    }
    """
  end
end
