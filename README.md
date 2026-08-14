# homebrew-xtal

Tap de Homebrew de **[Xtal](https://github.com/mcorcos/xtal)** — análisis de circuitos
electrónicos y consolidación de datos en informes LaTeX. *by UNIT.*

## Instalación

```bash
brew install mcorcos/xtal/xtal
```

Eso instala el binario `xtal`, los completions de shell, las man pages y **Tectonic**
(el motor LaTeX, que es la única dependencia obligatoria).

Para simular circuitos hace falta además ngspice, que es opcional:

```bash
brew install ngspice
```

Después, configurá Xtal en la máquina:

```bash
xtal setup      # theme, formato y warmup de LaTeX
xtal example    # un proyecto de ejemplo, listo para compilar
```

## Cómo se mantiene

`Formula/xtal.rb` **se genera sola**. El workflow de este repo mira cada hora si hay una
Release nueva de Xtal, se baja el `SHA256SUMS` de esa Release, y regenera la fórmula con
la plantilla que vive en el repo principal
([`packaging/homebrew/render-formula.sh`](https://github.com/mcorcos/xtal/blob/main/packaging/homebrew/render-formula.sh)).

O sea: la plantilla está en un solo lugar, y acá no hay ningún token ni secret cargado.
Para forzar una actualización sin esperar la hora, se dispara el workflow a mano desde
la pestaña Actions.

**No edites la fórmula a mano**: el próximo pase la pisa.
