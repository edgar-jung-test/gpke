window.onload = function() {
  //<editor-fold desc="Changeable Configuration Block">

  // the following lines will be replaced by docker/configurator, when it runs in a docker-container
  window.ui = SwaggerUIBundle({
    url: "./openapi-bundled.yaml",
    dom_id: '#swagger-ui',
    deepLinking: true,
    presets: [
      SwaggerUIBundle.presets.apis,
      SwaggerUIStandalonePreset
    ],
    plugins: [
      SwaggerUIBundle.plugins.DownloadUrl
    ],
    layout: "StandaloneLayout"
  });

  //</editor-fold>
};

// GPKE / UTILMD customisation – appended by CI
window.onload = function () {
  window.ui = SwaggerUIBundle({
    url:          "./openapi-bundled.yaml",
    dom_id:       '#swagger-ui',
    presets: [
      SwaggerUIBundle.presets.apis,
      SwaggerUIStandalonePreset
    ],
    layout:        "StandaloneLayout",
    docExpansion:  "list",
    deepLinking:   true,
    displayRequestDuration: true,
    filter:        true,
    showExtensions: true,
    showCommonExtensions: true,
  });
};
