# Fórmula generada automáticamente por packaging/homebrew/render-formula.sh.
# No la edites a mano: los cambios se pisan en el próximo release.
class Xtal < Formula
  desc "Análisis de circuitos y consolidación de datos en informes LaTeX"
  homepage "https://github.com/mcorcos/xtal"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.1.1/xtal-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "b8898ae7be248e8ca93ebfd398818730155e61a138e72ff018541e22a4377668"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.1.1/xtal-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "1d966a3c8635511ebac209d0b7b85113d8f272f849f1db4e9a560793493d3426"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.1.1/xtal-0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "be97bc4031c833ff71a706eec1ec42ba0f06deb52a13916702194d773af92237"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.1.1/xtal-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1ca4f5534dd0953e0344c1e4d175496517971b300f27cf577262a066ff24dd7d"
    end
  end

  # Tectonic es el motor LaTeX: sin él, `xtal run` no compila el PDF. Es la única
  # dependencia obligatoria. ngspice (simulación) queda opcional a propósito: no
  # todo el mundo simula, y es un paquete pesado. `xtal doctor` avisa si falta.
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
      Para simular circuitos hace falta ngspice:
        brew install ngspice

      Configurá Xtal en esta máquina (theme, formato, warmup de Tectonic):
        xtal setup

      Para usarlo desde Claude Desktop o Codex:
        xtal mcp install --client claude-desktop
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xtal --version")
    system bin/"xtal", "doctor"
  end
end
