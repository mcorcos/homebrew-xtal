# Fórmula generada automáticamente por packaging/homebrew/render-formula.sh.
# No la edites a mano: los cambios se pisan en el próximo release.
class Xtal < Formula
  desc "Análisis de circuitos y consolidación de datos en informes LaTeX"
  homepage "https://github.com/mcorcos/xtal"
  version "0.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.6.0/xtal-0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "e3ac6e203e2c345ab326f8c6edf9e7f209a5d6ba5fb5295b6e55d7b2e9189a76"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.6.0/xtal-0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "3f7514955c2f215b26dde9137c1d32036907650f56cebbe8868a20fc5d389f59"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.6.0/xtal-0.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "617028416e85a92a345133bb581df4b627338601d88d7e1e05b52361816a526b"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.6.0/xtal-0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a6a9c91dddb2b8b107cfa7b5625317da62076a4b83ad7def255321d862fdfd18"
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
