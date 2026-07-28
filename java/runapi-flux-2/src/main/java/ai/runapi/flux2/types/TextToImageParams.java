package ai.runapi.flux2.types;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/** Parameters for text to image operations. */
public final class TextToImageParams {
  private final String model;
  private final String prompt;
  private final String aspectRatio;
  private final String outputResolution;
  private final Integer outputCount;
  private final Boolean enableSafetyChecker;
  private final String callbackUrl;

  private TextToImageParams(Builder builder) {
    this.model = builder.model;
    this.prompt = Flux2ParamUtils.requireNonBlank(builder.prompt, "prompt");
    this.aspectRatio = builder.aspectRatio;
    this.outputResolution = builder.outputResolution;
    this.outputCount = builder.outputCount;
    this.enableSafetyChecker = builder.enableSafetyChecker;
    this.callbackUrl = builder.callbackUrl;
  }

  /** Creates a new TextToImageParams builder. */
  public static Builder builder() {
    return new Builder();
  }

  /** Returns the RunAPI action key for this request. */
  public String action() {
    return "flux-2/text-to-image";
  }

  /** Converts these parameters to the JSON request body shape. */
  public Map<String, Object> toMap() {
    Map<String, Object> raw = new LinkedHashMap<String, Object>();
    raw.put("model", Flux2ParamUtils.wireValue(model));
    raw.put("prompt", Flux2ParamUtils.wireValue(prompt));
    raw.put("aspect_ratio", Flux2ParamUtils.wireValue(aspectRatio));
    raw.put("output_resolution", Flux2ParamUtils.wireValue(outputResolution));
    raw.put("output_count", Flux2ParamUtils.wireValue(outputCount));
    raw.put("enable_safety_checker", Flux2ParamUtils.wireValue(enableSafetyChecker));
    raw.put("callback_url", Flux2ParamUtils.wireValue(callbackUrl));
    return Flux2ParamUtils.compact(raw);
  }



  /** Builder for {@link TextToImageParams}. */
  public static final class Builder {
    private String model;
    private String prompt;
    private String aspectRatio;
    private String outputResolution;
    private Integer outputCount;
    private Boolean enableSafetyChecker;
    private String callbackUrl;

    private Builder() {}

    /** Sets the model slug using a typed model value. */
    public Builder model(TextToImageModel value) {
      this.model = java.util.Objects.requireNonNull(value, "model").value();
      return this;
    }

    /** Sets the model slug using a string value. */
    public Builder model(String value) {
      this.model = Flux2ParamUtils.requireNonBlankTrim(value, "model");
      return this;
    }


    /** Sets the text prompt. */
    public Builder prompt(String value) {
      this.prompt = Flux2ParamUtils.requireNonBlank(value, "prompt");
      return this;
    }

    /** Sets the output aspect ratio. */
    public Builder aspectRatio(String value) {
      this.aspectRatio = Flux2ParamUtils.requireNonBlank(value, "aspectRatio");
      return this;
    }

    /** Sets the output resolution. */
    public Builder outputResolution(String value) {
      this.outputResolution = Flux2ParamUtils.requireNonBlank(value, "outputResolution");
      return this;
    }

    /** Sets the output count. Flux 2 Max supports only one output. */
    public Builder outputCount(int value) {
      this.outputCount = value;
      return this;
    }

    /** Sets the content safety checker toggle. */
    public Builder enableSafetyChecker(boolean value) {
      this.enableSafetyChecker = value;
      return this;
    }

    /** Sets the webhook URL for task completion notifications. */
    public Builder callbackUrl(String value) {
      this.callbackUrl = Flux2ParamUtils.requireNonBlank(value, "callbackUrl");
      return this;
    }

    /** Builds immutable text to image parameters. */
    public TextToImageParams build() {
      return new TextToImageParams(this);
    }
  }
}
