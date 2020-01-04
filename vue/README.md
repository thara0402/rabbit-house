# Vue.js

## Vue CLI 3

### Install
```shell-session
$ npm uninstall -g vue-cli
$ npm install -g @vue/cli
```

### Hello World
```shell-session
$ vue create my-project
$ cd my-project

? Please pick a preset:
  default (babel, eslint)
❯ Manually select features

? Check the features needed for your project:
◯ Babel
❯◉ TypeScript
◯ Progressive Web App (PWA) Support
◉ Router
◯ Vuex
◯ CSS Pre-processors
◯ Linter / Formatter
◯ Unit Testing
◯ E2E Testing

Use class-style component syntax? No

? Use Babel alongside TypeScript for auto-detected polyfills? No
? Use history mode for router? (Requires proper server setup for index fallback in production) Yes
? Where do you prefer placing config for Babel, PostCSS, ESLint, etc.? In dedicated config files
? Save this as a preset for future projects? No
? Pick the package manager to use when installing dependencies:
 Use Yarn
❯ Use NPM

$ npm run serve
```

### Deploy
```shell-session
$ npm run build
```

### Add Buefy
```shell-session
$ vue add buefy
```

### Add Element
```shell-session
$ vue add element
? How do you want to import Element? Fully import
? Do you wish to overwrite Element's SCSS variables? Yes
? Choose the locale you want to load ja
```

### Add axios
```shell-session
$ vue add axios
```

## Nuxt.js

### Install
```shell-session
$ npm install -g @vue/cli-init
```

### Hello World
```shell-session
$ vue init nuxt-community/starter-template my-nuxt
$ cd my-nuxt
$ npm install
$ npm run dev
```
