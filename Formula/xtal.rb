# Fórmula generada automáticamente por packaging/homebrew/render-formula.sh.
# No la edites a mano: los cambios se pisan en el próximo release.
class Xtal < Formula
  desc "Análisis de circuitos y consolidación de datos en informes LaTeX"
  homepage "https://github.com/mcorcos/xtal"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.3.0/xtal-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "7b8fad7fc8a47c62a8db40d45238d402e6af743dea1b51ce189f83ead092a752"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.3.0/xtal-0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "10c63a00480e8ec2ab965df5e2f003dd0ccde2f8b47fd5c4e1313ceb39ce9dec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.3.0/xtal-0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9de9792b2f260b68f07ff41ed3cbca277275f2fa767839d65b8a293055aa73f3"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.3.0/xtal-0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7d8a60fdaa167439c7a14e6e51dc53924e394ba57c35fc3e55c865c19bbf4ee1"
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
