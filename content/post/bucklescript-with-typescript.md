+++
date = "2017-09-30T13:19:24+02:00"
draft = true
title = "Integrating bucklescript with typescript"
tags = ["typescript","bucklescript"]
image = ""
comments = true	# set false to hide Disqus
share = true	# set false to hide share buttons
menu= ""		# set "main" to add this content to the main menu
author = ""
+++

Recently I've started using [Bucklescript](http://bucklescript.github.io/bucklescript/) (and [Reason](https://reasonml.github.io/)) over [Elm](http://elm-lang.org/) for various reasons (Something I might blog about later). In this post I'm exploring integrating Bucklescript with [Typescript](https://www.typescriptlang.org/).

### Let's start with a blank typescript project with webpack

You can find the inital commit of a Typescript project [here]( https://github.com/tcoopman/bucklescript-with-typescript/commit/1d19580c032703aceb51c08c9bf2c48ba5b527d8).

There is nothing special in this commit, some npm dependencies: `source-map-loader, ts-loader, typescript, webpack, webpack-dev-server`. The ts-config.json file is generated with `tsc --init`, nothing is changed.
In the `webpack.config.js` I have one entry file `./src/index.ts` that get's compiled to `./dist`. 

The index.html is just a bare html file that loads that compiled javascript. So if you run `npm start` and open your browser on the url that `webpack-dev-server` hosts, you should see **Hello from Typescript** in your console.

The first step was really easy, let's see if the next step is any harder?

### Integrating Bucklescript and Reason

Let's first install `bs-loader` and `bs-platform` locally. `bs-platform` contains the bucklescript compiler.

To work with bucklescript we need a `bsconfig.json` file:

```json
{
  "name": "typescript-with-bucklescript",
  "version": "0.1.0",
  "sources": [
    "src"
  ],
  "package-specs": ["es6"],
  "bsc-flags": [ "-bs-super-errors -no-alias-deps", "-color", "always"]
}
```

Nothing to special in here, we look for our source files in `src`, compile to `es6` and enable some compiler flags.

In `webpack.config.js` we add the `bs-loader` and resolve `.ml` and `.re` files:

```diff
--- a/webpack.config.js
+++ b/webpack.config.js
@@ -14,7 +14,7 @@ module.exports = {
         publicPath: '/dist/',
     },
     resolve: {
-        extensions: ['.js', '.ts'],
+        extensions: ['.js', '.ts', '.ml', '.re'],
     },
     module: {
         rules: [
@@ -30,6 +30,15 @@ module.exports = {
                 loaders: ['ts-loader'],
                 exclude: /node_modules/
             },
+            {
+                test: /\.(re|ml)$/,
+                use: {
+                    loader: 'bs-loader',
+                    options: {
+                        module: 'es6',
+                    }
+                }
+            },
         ]
     }
 };
\ No newline at end of file
```

Now we are able to create 2 files: `src/Bucklescript.ml`:

```ocaml
let hello name =
  Js.log {j|Hi $(name), from Bucklescript.|j}
```

and `src/Reason.re`:

```reason
let hello name => Js.log {j|Hi $(name), from Reason.|j};
```

both of which can be called from `index.ts`:

```typescript
const helloBucklescript = require('./Bucklescript').hello;
const helloReason = require('./Reason').hello;

helloBucklescript('Typescript');
helloReason('Typescript');
```

When you run `npm start` you will get an error from typescript `Cannot find name 'require'`, to solve this we need to install `@types/node`

Now you can run `npm start` and everything should work. The full commit of this step can be found [here](https://github.com/tcoopman/bucklescript-with-typescript/commit/b22bacef7629ae574282c31a46e9445ba7759456).

You might wonder why I'm using `require` to import the modules. That's because I didn't get `import {x} from module` syntax working. Maybe I need typescript type definitions for this?

### A strange bug

While I was playing with this setup I noticed something strange. It looks like the compilation phase is always one step late. If I change something in the Bucklescript file, it only get's picked up after a next webpack build. I'm not sure why this is the case.

The easiest way to show the problem is like this:

```diff
"scripts": {
+    "clean": "bsb -clean",
+    "build": "webpack",
     "start": "webpack-dev-server --inline --hot"
},
```

If we first run `npm run clean` and then `npm run build` we get the error that `.../lib/es6/src/Reason.js` does not exist.  If you would run `npm run build` again the build would succeed because the file will be there.

Well, after some searching, it looks like this is a bug in `bs-loader` so I submitted a [PR](https://github.com/reasonml-community/bs-loader/pull/31). The bug only manifests itself because we load 2 files and `bs-loader` won't wait for the compiler for the second file.

After this fix everything works as intended, and you can start using Bucklescript/Reason together with Typescript.

### Conclusion

Apart from 2 things: 

* Why doesn't the `import` syntax work? (I'm sure I'm missing something here...)
* The bug in `bs-loader`

integrating Bucklescript/Reason with Typescript was trivial and I'm planning on using it in some projects to have some real integrations.




