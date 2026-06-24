package ai.runapi.flux2.types;

import ai.runapi.core.types.RunApiValue;

abstract class Flux2Value extends RunApiValue {
  Flux2Value(String value) {
    super(value);
  }
}
