# Fórmula generada automáticamente por packaging/homebrew/render-formula.sh.
# No la edites a mano: los cambios se pisan en el próximo release.
class Xtal < Formula
  desc "Análisis de circuitos y consolidación de datos en informes LaTeX"
  homepage "https://github.com/mcorcos/xtal"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.1.0/xtal-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "0b4fdb00e5cef52c72fdb639f643950fda0303a4c3a4afb64f13884991a3c6b9"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.1.0/xtal-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "849a1faddfc0e170165d1349d6ddab8e0796fdb399e1dabb1c545079ebc13781"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.1.0/xtal-0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5d83f4439b903bc55dfc62871dfcd0367358729831cbbda4ce50a5ae52d2356a"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.1.0/xtal-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "91304f7566dc35138b506b4cde25a5757883b0248365cd58d43903972e67bbf0"
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
