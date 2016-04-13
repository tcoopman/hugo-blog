+++
date = "2015-01-13"
tags = ["es6", "react", "webpack"]
title = "Testing ES6 code"
description = "Testing with webpack and ES6"
+++

Recently, I've changed my webpack workflow, and switched to [6to5](https://6to5.org/), to be able to write more of my React code in ES6 than the current jsx transpiler supports (and because 6to5 just rocks!). You can find this workflow in my [boilerplate-webpack-react](https://github.com/tcoopman/boilerplate-webpack-react) project. Switching was easy. I've just replaced jsx-loader with 6to5-loader and everything worked correctly.

Writing code and developing is a breeze with this workflow, especially with [react-hot-loader](https://github.com/gaearon/react-hot-loader). I didn't look into writing test though yet, and it took me a little while to find out how to do it, so I explain it here.

## Karma-webpack

Luckely, there exist a [karma](http://karma-runner.github.io/) plugin [webpack-karma](https://github.com/webpack/karma-webpack) that allows you to run webpack on files loaded by karma. This means, the test can be written in ES6 (or any other language you prefer that can be transpiled by a webpack loader), and your own code also gets transpiled.

Let me show my setup.

### Install dependencies
First you need to install all dependencies:

`npm install --save-dev karma karma-mocha karma-webpack karma-chrome-launcher should`

I use [mocha](http://mochajs.org/) as test framework and [should](https://github.com/shouldjs/should.js) as assertion library, but this should work with anything that karma supports.

### Karma configuration file

Next we need to create the karma config file _karma.conf.js_

```js
// Karma configuration
var path = require('path');

module.exports = function(config) {
  config.set({
    // ... normal karma configuration

    files: [
    // all files ending in "_test"
    'test/*_test.jsx',
    'test/**/*_test.jsx'
    // each file acts as entry point for the webpack configuration
    ],


    frameworks: ['mocha'],


    browsers: ['Chrome'],


    preprocessors: {
      // add webpack as preprocessor
      'test/data/*.jsx': ['webpack'],
      'test/*_test.jsx': ['webpack'],
      'test/**/*_test.jsx': ['webpack']
    },

    webpack: {
      // webpack configuration
      output: {
        path: path.join(__dirname, 'dist'),
        publicPath: '/',
        filename: 'app.js',
        chunkFilename: '[chunkhash].js'
      },


      resolve: {
        extensions: ['', '.js', '.jsx', '.styl'],
        packageMains: ["webpack", "browser", "web", "browserify", "main"]
      },


      module: {
        loaders: [
          {test: /\.jsx$/, loaders: ['6to5-loader'] }
        ]
      }
    },


    webpackMiddleware: {
      // webpack-dev-middleware configuration
      // i. e.
      noInfo: true
    },

    plugins: [
      require('karma-chrome-launcher'),
      require('karma-mocha'),
      require('karma-webpack')
    ]

  });
};
```

### First test

We also add a simple _sanity_test_ to make sure everything is setup correctly

```js
import should from 'should';

describe('sanity test', () => {
  it('true should be true', () => {
    true.should.be.ok;
  });
});
```

### First run

Now, if we want to run our test, we run:

`node node_modules/karma/bin/karma start karma.conf.js`

This should start Chrome (if you don't have chrome, see the [karma browser configuration](http://karma-runner.github.io/0.12/config/browsers.html)) and print this:
```bash
INFO [karma]: Karma v0.12.31 server started at http://localhost:9876/
INFO [launcher]: Starting browser Chrome
INFO [Chrome 39.0.2171 (Windows 7)]: Connected on socket xBMICOzH9lh3Eo9INXDA with id 55389724
Chrome 39.0.2171 (Windows 7): Executed 1 of 1 SUCCESS (0.009 secs / 0 secs)
```

Every time you change your code it will automatically rerun your tests.

To make it a bit easier to run the test, add the test command to npm:

```json
"scripts": {
  "test": "node node_modules/karma/bin/karma start karma.conf.js"
}
```

You could also add `--single-run` if you want to run the test only once and don't watch.

## Testing React code

The steps above give you a working testing environment, now we can test our code:

To test this we create a simple React component _Button.react.jsx_:

```js
import React from 'react';


export default React.createClass({
  displayName: 'Button',


  render() {
    return <div>button</div>;
  }
});
```

And we test it in _Button.react_test.jsx_:

```js
import React from 'react/addons';
import should from 'should';

import Button from '../app/jsx/components/Button.react';

const TestUtils = React.addons.TestUtils;


describe('Button', () => {
  it('renders button div', () => {
    const button = TestUtils.renderIntoDocument(
      <Button />
    );
    TestUtils.isCompositeComponent(button).should.be.ok;
    button.getDOMNode().textContent.should.be.eql('button');
  });
});
```

**Easy!**

### Remark

While testing, I ran into a problem. This line in HelloWorld.react.jsx: `var exampleImage = require('../../images/example.jpg');` proved to be a problem. But the problem was quiet obvious to solve, I just needed to add a image loader to the karma webpack configuration:

```js
module: {
  loaders: [
  {test: /\.jsx$/, loaders: ['6to5-loader'] },
  // Add the image loader
  {test: /.*\.(gif|png|jpg)$/, loaders: ['file?hash=sha512&digest=hex&size=16&name=[hash].[ext]', 'image-webpack-loader?optimizationLevel=7&interlaced=false']}
  ]
}
```

After this, I could test the HelloWorld component too.

## Conclusion

Once you have this up, you can test your code with the same setup you already have. Webpack rocks!

If you have any questions, please leave them as an issue at my boilerplate repository (https://github.com/tcoopman/boilerplate-webpack-react/issues)

## Commits

All steps and code above can be found in the commits between tag 0.0.9 and 0.0.10: https://github.com/tcoopman/boilerplate-webpack-react/commits/master
