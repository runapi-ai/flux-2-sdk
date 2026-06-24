package ai.runapi.flux2.types;

import com.fasterxml.jackson.annotation.JsonCreator;

/** Model slug for remix image operations. */
public final class RemixImageModel extends Flux2Value {
  /** flux-2-flex-remix-image model slug. */
  public static final RemixImageModel FLUX_2_FLEX_REMIX_IMAGE = new RemixImageModel("flux-2-flex-remix-image");
  /** flux-2-pro-remix-image model slug. */
  public static final RemixImageModel FLUX_2_PRO_REMIX_IMAGE = new RemixImageModel("flux-2-pro-remix-image");

  /** Creates a model value from a literal model slug. */
  @JsonCreator
  public RemixImageModel(String value) {
    super(value);
  }
}
