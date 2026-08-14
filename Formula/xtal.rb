# Fórmula generada automáticamente por packaging/homebrew/render-formula.sh.
# No la edites a mano: los cambios se pisan en el próximo release.
class Xtal < Formula
  desc "Análisis de circuitos y consolidación de datos en informes LaTeX"
  homepage "https://github.com/mcorcos/xtal"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.2.0/xtal-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "36f1baac5d5177d9a8c5332cc2b20bfb47c718f3369e3d26e3b48c5dc327846a"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.2.0/xtal-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "cfe29dcfcf2b6866b86b88c1a8448e9ea4b4d2aa28ac4b46cc75a199c7f201f6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.2.0/xtal-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aeeb0a8f8ba8fbda196e12a1dcc13cd5a4de4fb60a39be12a9b3919c4c9fd35e"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.2.0/xtal-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9d9c1fc4069dab2ec3495e3d31ba0f15d9f543e8642c0a516d5ae4da768200e7"
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
