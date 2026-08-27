# Cask generado automáticamente por packaging/homebrew/render-cask.sh.
# No lo edites a mano: los cambios se pisan en el próximo release.
cask "xtal-app" do
  version "0.5.0"
  sha256 "80e9c686c20efb7f846fc580ebe29bb9678a410033c852a23bf7c88fce1263fe"

  url "https://github.com/mcorcos/xtal/releases/download/v0.5.0/Xtal-#{version}-macos.zip"
  name "Xtal"
  desc "Editor e informes de electrónica: escribís, compilás y ves el PDF al lado"
  homepage "https://github.com/mcorcos/xtal"

  # El binario `xtal` NO viaja adentro del .app, al revés que en Windows.
  #
  # En Windows el instalador lo trae adentro porque ahí no hay un gestor de paquetes
  # de fábrica y "bajá el instalador y además pegá un comando" no es un instalador.
  # Acá sí lo hay: es este mismo. Homebrew instala la fórmula primero y la app le
  # habla a ESA, así que la app y la terminal nunca corren versiones distintas.
  # Ver `XtalCLI.rutaBinario()` en app/XtalPackage/.../Core/XtalCLI.swift.
  depends_on formula: "mcorcos/xtal/xtal"

  # La app declara MACOSX_DEPLOYMENT_TARGET = 15.0 en app/Config/Shared.xcconfig.
  # Sin esta línea, en una Mac vieja el cask instala una app que no abre y el error
  # que da macOS no dice que el problema es la version del sistema.
  depends_on macos: ">= :sequoia"

  app "Xtal.app"

  # Gatekeeper: la app está firmada ad-hoc, no con un Developer ID de Apple.
  #
  # Homebrew le pone el atributo de cuarentena a todo lo que baja. Sobre una app sin
  # firmar de Apple, ese atributo hace que macOS diga "no se puede abrir" o "está
  # dañada" y NO ofrezca el "Abrir igualmente" de Ajustes: el único camino queda ser
  # el `xattr` a mano, que es justo lo que un instalador tiene que evitar.
  #
  # Se saca acá, después de copiar la app. El día que haya un Developer ID ($99/año,
  # más notarización) esta línea se borra y no cambia nada más.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Xtal.app"],
                   sudo: false
  end

  # `zap` es lo que borra `brew uninstall --zap`. La config global y los themes NO
  # van acá: son de la CLI, no de la app, y los saca `xtal uninstall`. Los proyectos
  # tampoco: son carpetas del usuario, versionadas con git.
  zap trash: [
    "~/Library/Preferences/com.unit.xtal.plist",
    "~/Library/Saved Application State/com.unit.xtal.savedState",
  ]

  caveats <<~EOS
    Xtal quedó en Aplicaciones. Abrila y elegí "Informe nuevo".

    La app corre el comando `xtal` por abajo: ya vino con este cask,
    junto con el motor LaTeX (tectonic) y el simulador (ngspice).
  EOS
end
