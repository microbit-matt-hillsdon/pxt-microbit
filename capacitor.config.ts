import type { CapacitorConfig } from "@capacitor/cli";

const config: CapacitorConfig = {
  appId: "com.example.app",
  appName: "staticpkg-pxt-microbit",
  webDir: "built/packaged",
  plugins: {
    CapacitorHttp: {
      enabled: true,
    },
  },
};

export default config;
