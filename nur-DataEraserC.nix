let
  sha256 = "";
  rev = "d063c0a9cfd5696952e422514e2c357757a517b5";
in
builtins.trace "(Using pinned nur-DataEraserC at ${rev})"
import (builtins.fetchTarball {
      url = "https://github.com/DataEraserC/nur-packages/archive/${rev}.tar.gz";
    })

