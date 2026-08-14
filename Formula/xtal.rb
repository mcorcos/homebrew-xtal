# Fórmula generada automáticamente por packaging/homebrew/render-formula.sh.
# No la edites a mano: los cambios se pisan en el próximo release.
class Xtal < Formula
  desc "Análisis de circuitos y consolidación de datos en informes LaTeX"
  homepage "https://github.com/mcorcos/xtal"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.1.2/xtal-0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "d34f4570729ea4eda303d7a1f7d8923bd37d3832d1a1f298cd0543699efad473"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.1.2/xtal-0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "864f205c86d6290701499938befd238f745b37dbf5dce96e7e9dd8f43659da60"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.1.2/xtal-0.1.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5d30a60f5b73a4aca7771663ce406768fb6cf7da597b3331bb4adfa421828989"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.1.2/xtal-0.1.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "352d17558570d8ed9e5a5df4104776854f61a512d5b60ece3c32e16814ebc309"
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
