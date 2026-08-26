# Fórmula generada automáticamente por packaging/homebrew/render-formula.sh.
# No la edites a mano: los cambios se pisan en el próximo release.
class Xtal < Formula
  desc "Análisis de circuitos y consolidación de datos en informes LaTeX"
  homepage "https://github.com/mcorcos/xtal"
  version "0.3.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.3.2/xtal-0.3.2-aarch64-apple-darwin.tar.gz"
      sha256 "9fe35a26dc8f902cd3895dcf1d2ae958b235e9b659ff899e53f608400a77a6b1"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.3.2/xtal-0.3.2-x86_64-apple-darwin.tar.gz"
      sha256 "406bb3d100f613447dbafe041e2c1c1b3fe48c71d84ece16b1a8ade6dc6e63b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.3.2/xtal-0.3.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4eabbc43043610b4926978bace34251e3eb7a9db614fbdd6a2764066a2006ff4"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.3.2/xtal-0.3.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "daab1aa2e49856152e9abe7ce0df2d632675a7f9fe18454e0d968eddeebd5836"
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
