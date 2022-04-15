# Install Node.js
curl -L https://git.io/n-install | bash
n lts


# Swith npm mirrors
yarn global add yrm
yrm test
yrm use taobao


# Install vue
yarn global add @vue/cli
vue create xxx
cd xxx
yarn serve
# Error: ENOSPC: System limit for number of file watchers reached
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
# install vue router plugin, history mode: true
vue use router


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
