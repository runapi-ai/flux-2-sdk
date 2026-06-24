package ai.runapi.flux2.types;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/** Parameters for remix image operations. */
public final class RemixImageParams {
  private final String model;
  private final String prompt;
  private final List<String> sourceImageUrls;
  private final String aspectRatio;
  private final String outputResolution;
  private final Boolean enableSafetyChecker;
  private final String callbackUrl;

  private RemixImageParams(Builder builder) {
    this.model = builder.model;
    this.prompt = Flux2ParamUtils.requireNonBlank(builder.prompt, "prompt");
    this.sourceImageUrls = Flux2ParamUtils.requiredStrings(builder.sourceImageUrls, "sourceImageUrls");
    this.aspectRatio = builder.aspectRatio;
    this.outputResolution = builder.outputResolution;
    this.enableSafetyChecker = builder.enableSafetyChecker;
    this.callbackUrl = builder.callbackUrl;
  }

  /** Creates a new RemixImageParams builder. */
  public static Builder builder() {
    return new Builder();
  }

  /** Returns the RunAPI action key for this request. */
  public String action() {
    return "flux-2/remix-image";
  }

  /** Converts these parameters to the JSON request body shape. */
  public Map<String, Object> toMap() {
    Map<String, Object> raw = new LinkedHashMap<String, Object>();
    raw.put("model", Flux2ParamUtils.wireValue(model));
    raw.put("prompt", Flux2ParamUtils.wireValue(prompt));
    raw.put("source_image_urls", Flux2ParamUtils.wireValue(sourceImageUrls));
    raw.put("aspect_ratio", Flux2ParamUtils.wireValue(aspectRatio));
    raw.put("output_resolution", Flux2ParamUtils.wireValue(outputResolution));
    raw.put("enable_safety_checker", Flux2ParamUtils.wireValue(enableSafetyChecker));
    raw.put("callback_url", Flux2ParamUtils.wireValue(callbackUrl));
    return Flux2ParamUtils.compact(raw);
  }



  /** Builder for {@link RemixImageParams}. */
  public static final class Builder {
    private String model;
    private String prompt;
    private List<String> sourceImageUrls;
    private String aspectRatio;
    private String outputResolution;
    private Boolean enableSafetyChecker;
    private String callbackUrl;

    private Builder() {}

    /** Sets the model slug using a typed model value. */
    public Builder model(RemixImageModel value) {
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

    /** Sets the source image URLs. */
    public Builder sourceImageUrls(List<String> value) {
      this.sourceImageUrls = value;
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

    /** Builds immutable remix image parameters. */
    public RemixImageParams build() {
      return new RemixImageParams(this);
    }
  }
}
