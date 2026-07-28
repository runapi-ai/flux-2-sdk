CONTRACT = {
    "remix-image": {
        "models": ["flux-2-flex-remix-image", "flux-2-max-remix-image", "flux-2-pro-remix-image"],
        "fields_by_model": {
            "flux-2-flex-remix-image": {
                "aspect_ratio": {
                    "enum": ["1:1", "4:3", "3:4", "16:9", "9:16", "3:2", "2:3", "auto"]
                },
                "model": {
                    "required": True
                },
                "output_resolution": {
                    "enum": ["1k", "2k"]
                },
                "prompt": {
                    "required": True,
                    "min": 3,
                    "max": 5000,
                    "length": True
                },
                "source_image_urls": {
                    "required": True,
                    "min_items": 1,
                    "max_items": 8
                }
            },
            "flux-2-max-remix-image": {
                "aspect_ratio": {
                    "enum": ["1:1", "4:3", "3:4", "16:9", "9:16", "3:2", "2:3"],
                    "required": True
                },
                "model": {
                    "required": True
                },
                "output_count": {
                    "enum": [1],
                    "type": "integer"
                },
                "output_resolution": {
                    "enum": ["1k"]
                },
                "prompt": {
                    "required": True,
                    "min": 3,
                    "max": 5000,
                    "length": True
                },
                "source_image_urls": {
                    "required": True,
                    "min_items": 1,
                    "max_items": 1
                }
            },
            "flux-2-pro-remix-image": {
                "aspect_ratio": {
                    "enum": ["1:1", "4:3", "3:4", "16:9", "9:16", "3:2", "2:3", "auto"]
                },
                "model": {
                    "required": True
                },
                "output_resolution": {
                    "enum": ["1k", "2k"]
                },
                "prompt": {
                    "required": True,
                    "min": 3,
                    "max": 5000,
                    "length": True
                },
                "source_image_urls": {
                    "required": True,
                    "min_items": 1,
                    "max_items": 8
                }
            }
        },
        "rules": [{
            "when": {
                "model": "flux-2-flex-remix-image"
            },
            "forbidden": ["output_count"]
        }, {
            "when": {
                "model": "flux-2-max-remix-image"
            },
            "forbidden": ["enable_safety_checker"]
        }, {
            "when": {
                "model": "flux-2-pro-remix-image"
            },
            "forbidden": ["output_count"]
        }]
    },
    "text-to-image": {
        "models": ["flux-2-flex-text-to-image", "flux-2-max-text-to-image", "flux-2-pro-text-to-image"],
        "fields_by_model": {
            "flux-2-flex-text-to-image": {
                "aspect_ratio": {
                    "enum": ["1:1", "4:3", "3:4", "16:9", "9:16", "3:2", "2:3"]
                },
                "model": {
                    "required": True
                },
                "output_resolution": {
                    "enum": ["1k", "2k"]
                },
                "prompt": {
                    "required": True,
                    "min": 3,
                    "max": 5000,
                    "length": True
                }
            },
            "flux-2-max-text-to-image": {
                "aspect_ratio": {
                    "enum": ["1:1", "4:3", "3:4", "16:9", "9:16", "3:2", "2:3"],
                    "required": True
                },
                "model": {
                    "required": True
                },
                "output_count": {
                    "enum": [1],
                    "type": "integer"
                },
                "output_resolution": {
                    "enum": ["1k"]
                },
                "prompt": {
                    "required": True,
                    "min": 3,
                    "max": 5000,
                    "length": True
                }
            },
            "flux-2-pro-text-to-image": {
                "aspect_ratio": {
                    "enum": ["1:1", "4:3", "3:4", "16:9", "9:16", "3:2", "2:3"]
                },
                "model": {
                    "required": True
                },
                "output_resolution": {
                    "enum": ["1k", "2k"]
                },
                "prompt": {
                    "required": True,
                    "min": 3,
                    "max": 5000,
                    "length": True
                }
            }
        },
        "rules": [{
            "when": {
                "model": "flux-2-flex-text-to-image"
            },
            "forbidden": ["output_count"]
        }, {
            "when": {
                "model": "flux-2-max-text-to-image"
            },
            "forbidden": ["enable_safety_checker"]
        }, {
            "when": {
                "model": "flux-2-pro-text-to-image"
            },
            "forbidden": ["output_count"]
        }]
    }
}
