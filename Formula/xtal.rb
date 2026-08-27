# Fórmula generada automáticamente por packaging/homebrew/render-formula.sh.
# No la edites a mano: los cambios se pisan en el próximo release.
class Xtal < Formula
  desc "Análisis de circuitos y consolidación de datos en informes LaTeX"
  homepage "https://github.com/mcorcos/xtal"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.5.0/xtal-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "2adab77d26bcb480402c8f98532aaa4408a64af6635ac31e6f2960941bdc0da8"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.5.0/xtal-0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "0557ebf01f4e71cf1835cd8d709208992bb3c40460d434f8e515d42a55ee3a6a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.5.0/xtal-0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0e499a3eb802bdaedd1808810cfd4b9c8b8089275eae984992ef8b90dd887b2b"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.5.0/xtal-0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "59ab85fb5f14ac25bea3bd01ceb1bae7a94f9507931589f742f1eada0768fb7b"
    end
  end

  # Las dos dependencias externas de Xtal, y las dos van adentro de la fórmula a
  # propósito: **un comando tiene que dejar todo andando**. Antes ngspice quedaba
  # afuera "porque no todo el mundo simula", y el resultado era que el que sí simulaba
  # se enteraba de que le faltaba recién cuando `xtal sim` fallaba, a mitad del TP.
  #
  #   tectonic — motor LaTeX. Sin él `xtal run` no compila el PDF.
  #   ngspice  — simulador. Sin él `xtal sim` no corre.
  depends_on "ngspice"
  depends_on "tectonic"

  def install
    bin.install "xtal"
    man1.install Dir["man/*.1"]
    zsh_completion.install "completions/_xtal"
    bash_completion.install "completions/xtal.bash" => "xtal"
    fish_completion.install "completions/xtal.fish"
  end

  def caveats
    <<~EOS
      Ya está todo: el motor LaTeX (tectonic) y el simulador (ngspice) vinieron
      con esta fórmula, y la configuración se escribe sola en el primer comando.

      Empezá por acá:
        xtal example --open

      ¿Querés también la app de escritorio?
        brew install --cask mcorcos/xtal/xtal-app
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xtal --version")
    system bin/"xtal", "doctor"
  end
end
