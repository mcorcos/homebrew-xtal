# homebrew-xtal

Tap de Homebrew de **[Xtal](https://github.com/mcorcos/xtal)** — análisis de circuitos
electrónicos y consolidación de datos en informes LaTeX. *by UNIT.*

## Instalación

Un comando por cosa, y cada uno se trae todo lo que necesita.

```bash
# La CLI
brew install mcorcos/xtal/xtal

# La app de escritorio (macOS)
brew install --cask mcorcos/xtal/xtal-app
```

La fórmula deja el binario `xtal`, los completions de shell, las man pages, **Tectonic**
(el motor LaTeX) y **ngspice** (el simulador). No hay ningún paso siguiente: la
configuración, los themes y el skill del agente se escriben en el primer comando que
corras.

El cask deja `Xtal.app` en Aplicaciones y **se trae la fórmula solo**, así que si querés
la app alcanza con ese comando. La app le habla al `xtal` que instaló la fórmula, así que
la app y la terminal nunca corren versiones distintas.

Para empezar:

```bash
xtal example --open   # un informe de ejemplo, compilado y abierto
```

### La app no está firmada por Apple

Xtal no tiene un Developer ID, así que la app va firmada **ad-hoc**. Instalada por el
cask no molesta: el cask le saca el atributo de cuarentena en su `postflight`. Bajada a
mano de la Release sí, y ahí macOS dice que no se puede abrir. El arreglo es:

```bash
xattr -dr com.apple.quarantine /Applications/Xtal.app
```

## Cómo se mantiene

`Formula/xtal.rb` y `Casks/xtal-app.rb` **se generan solos**. El workflow de este repo
mira cada hora si hay una Release nueva de Xtal, se baja el `SHA256SUMS` de esa Release,
y los regenera con las plantillas que viven en el repo principal
([`render-formula.sh`](https://github.com/mcorcos/xtal/blob/main/packaging/homebrew/render-formula.sh)
y [`render-cask.sh`](https://github.com/mcorcos/xtal/blob/main/packaging/homebrew/render-cask.sh)).

O sea: las plantillas están en un solo lugar, y acá no hay ningún token ni secret
cargado. Para forzar una actualización sin esperar la hora, se dispara el workflow a mano
desde la pestaña Actions.

**No edites la fórmula ni el cask a mano**: el próximo pase los pisa.
