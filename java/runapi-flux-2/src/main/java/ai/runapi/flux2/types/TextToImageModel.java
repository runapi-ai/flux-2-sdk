package ai.runapi.flux2.types;

import com.fasterxml.jackson.annotation.JsonCreator;

/** Model slug for text to image operations. */
public final class TextToImageModel extends Flux2Value {
  /** flux-2-flex-text-to-image model slug. */
  public static final TextToImageModel FLUX_2_FLEX_TEXT_TO_IMAGE = new TextToImageModel("flux-2-flex-text-to-image");
  /** flux-2-max-text-to-image model slug. */
  public static final TextToImageModel FLUX_2_MAX_TEXT_TO_IMAGE = new TextToImageModel("flux-2-max-text-to-image");
  /** flux-2-pro-text-to-image model slug. */
  public static final TextToImageModel FLUX_2_PRO_TEXT_TO_IMAGE = new TextToImageModel("flux-2-pro-text-to-image");

  /** Creates a model value from a literal model slug. */
  @JsonCreator
  public TextToImageModel(String value) {
    super(value);
  }
}
