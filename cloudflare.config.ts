import { defineConfig } from "cf/config";

export default defineConfig({
  worker: {
    name: "go-withmatt-com",
    compatibilityDate: "2026-10-01",
    assets: {
      // Serve public/404.html for paths that match no asset.
      notFoundHandling: "404-page",
    },
    // Domain cutover from the old Pages project:
    //   1. remove go.withmatt.com from the go-withmatt-com Pages project
    //   2. uncomment this, then `just deploy`
    domains: ["go.withmatt.com"],
    observability: {
      enabled: true,
    },
  },
});
