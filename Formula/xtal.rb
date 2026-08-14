# Fórmula generada automáticamente por packaging/homebrew/render-formula.sh.
# No la edites a mano: los cambios se pisan en el próximo release.
class Xtal < Formula
  desc "Análisis de circuitos y consolidación de datos en informes LaTeX"
  homepage "https://github.com/mcorcos/xtal"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.3.1/xtal-0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "013bff4469cf381d9a4a8d1ce8ec6d98472d085443ccaf9835cf9c616c035cdf"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.3.1/xtal-0.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "97b94644c92f2ef2edb891858df1882e674643c9a117d4cddc886a17be642ea6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mcorcos/xtal/releases/download/v0.3.1/xtal-0.3.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e864b3e4f011ee998694c9126e23d586ef0511b6386bae6a3c54a0bf7eeb6f04"
    end
    on_intel do
      url "https://github.com/mcorcos/xtal/releases/download/v0.3.1/xtal-0.3.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2546e1f345a84b48e795c58517bff03c3970d222598c3ab1569d76f1bda7599a"
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
