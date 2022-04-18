# Install Node.js
curl -L https://git.io/n-install | bash
n lts


# Swith npm mirrors
npm install -g yarn
yarn global add yrm
yrm test
yrm use taobao


# Install vue (deprecated, please use vue with vite to save your life)
# yarn global add @vue/cli
# vue create xxx
# cd xxx
# yarn serve
# # Error: ENOSPC: System limit for number of file watchers reached
# echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
# # install vue router plugin, history mode: true
# vue use router
#
# Use vite instead
# https://vitejs.dev/guide/#scaffolding-your-first-vite-project
# Difference between vue cli project and vite project
# https://github.com/danielkellyio/vue-cli-to-vite-migration-example/commit/0cb953ccf2d73d39ca811a4a084e10dddbafb438
yarn create vite


# Import ant-vue-design
# https://www.antdv.com/docs/vue/getting-started
yarn add ant-design-vue


# Import TailwindCSS
# https://tailwindcss.com/docs/installation/using-postcss
yarn add tailwindcss postcss autoprefixer
npx tailwindcss init
""" postcss.config.js
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  }
}
"""
""" tailwind.config.js
module.exports = {
  content: ["./src/**/*.{html,vue,js}"],
  theme: {
    extend: {},
  },
  plugins: [],
}
"""
""" src/main.css
@tailwind base;
@tailwind components;
@tailwind utilities;
"""
""" src/main.js
import './main.css';
"""


# Move to vite


# Visualize and analyze your Rollup bundle to see which modules are taking up space
# https://github.com/btd/rollup-plugin-visualizer#usage


# Import ant-design-vue on demand, to reduce the bundle size
# https://www.antdv.com/docs/vue/getting-started/#Import-on-Demand
# by using unplugin-vue-components with its AntDesignVueResolver
# https://github.com/antfu/unplugin-vue-components
""" vite.config.js
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
const path = require("path");
import Components from 'unplugin-vue-components/vite'
import {
  AntDesignVueResolver,
} from 'unplugin-vue-components/resolvers'
import { visualizer } from "rollup-plugin-visualizer";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    Components({
      resolvers: [
        AntDesignVueResolver(),
      ]
    }),
    visualizer(),
  ],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
})
"""


# Try to further reduce bundle size, by only imporing used functions from lodash
# https://github.com/onebay/vite-plugin-imp
""" vite.config.js
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
const path = require("path");
import Components from 'unplugin-vue-components/vite'
import {
  AntDesignVueResolver,
} from 'unplugin-vue-components/resolvers'
import { visualizer } from "rollup-plugin-visualizer";
import vitePluginImp from 'vite-plugin-imp'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    Components({
      resolvers: [
        AntDesignVueResolver(),
      ]
    }),
    vitePluginImp(),
    visualizer(),
  ],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
})
"""
