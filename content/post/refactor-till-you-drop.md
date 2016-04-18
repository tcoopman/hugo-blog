+++
draft = true
date = "2015-12-04"
tags = ["elm", "modelling", "DDD"]
title = "Refactor till you drop"
+++

# Introduction



# Iteration 1

```js
function getSymbol(symbolName) {
    return 'replace';
}


function escapeRegExp(string) {
    return string.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1");
}



function SymbolReplacer(s) {
    this.alreadyReplaced = [];

    this.stringToReplace = s;
}

//iteration 1 https://sites.google.com/site/unclebobconsultingllc/one-thing-extract-till-you-drop
SymbolReplacer.prototype.replace = function() {
    var symbolPattern = /\$([a-zA-Z]\w*)/g;
    var matches;
    while (matches = symbolPattern.exec(this.stringToReplace)) {
        var symbolName = matches[1];
        if (getSymbol(symbolName) !== null && this.alreadyReplaced.indexOf(symbolName) === -1) {
            this.alreadyReplaced.push(symbolName);
            var toReplace = new RegExp(escapeRegExp(matches[0]), 'g');
            this.stringToReplace = this.stringToReplace.replace(toReplace, getSymbol(symbolName));
        }
    }
}

var x = new SymbolReplacer('dit $is een $test $test $test $is $complex gewoon woord');
console.log(x.stringToReplace);
x.replace();
console.log(x.stringToReplace);
var result = 'dit replace een replace replace replace replace replace gewoon woord';
console.log(result === x.stringToReplace);
```

# Iteration 2

```js
SymbolReplacer.prototype.replace = function() {
    var symbolPattern = /\$([a-zA-Z]\w*)/g;
    var matches;
    while (matches = symbolPattern.exec(this.stringToReplace)) {
        var symbolReplace = matches[0];
        var symbolName = matches[1];
        this.replaceAllInstances(symbolReplace, symbolName);
    }
};

SymbolReplacer.prototype.replaceAllInstances = function(symbolReplace, symbolName) {
    if (getSymbol(symbolName) !== null && this.alreadyReplaced.indexOf(symbolName) === -1) {
            this.alreadyReplaced.push(symbolName);
            var toReplace = new RegExp(escapeRegExp(symbolReplace), 'g');
            this.stringToReplace = this.stringToReplace.replace(toReplace, getSymbol(symbolName));
    }
};
```

# Iteration 3

I just tested the performance. I was wondering why you do the global replace.
It doesn't seem to have any performance difference (http://jsperf.com/replace-while-vs-replace-all)
so iteration 3

```js
function getSymbol(symbolName) {
    return 'replace';
}

function SymbolReplacer(s) {
    this.stringToReplace = s;
};

//iteration 1 https://sites.google.com/site/unclebobconsultingllc/one-thing-extract-till-you-drop
SymbolReplacer.prototype.replace = function() {
    var symbolPattern = /\$([a-zA-Z]\w*)/g;
    var matches;
    while (matches = symbolPattern.exec(this.stringToReplace)) {
        var symbolReplace = matches[0];
        var symbolName = matches[1];
        this.replaceAllInstances(symbolReplace, symbolName);
    }
};

SymbolReplacer.prototype.replaceInstance = function(symbolReplace, symbolName) {
  if (getSymbol(symbolName) !== null) {
    this.stringToReplace = this.stringToReplace.replace(symbolReplace, getSymbol(symbolName));
  }
};

var x = new SymbolReplacer('dit $is een $test $test $test $is $complex gewoon woord');
console.log(x.stringToReplace);
x.replace();
console.log(x.stringToReplace);
var result = 'dit replace een replace replace replace replace replace gewoon woord';
console.log(result === x.stringToReplace);
```

# Iteration 4 - remove mutable state

```js
function getSymbol(symbolName) {
    return 'replace';
}

function SymbolReplacer() {
    this.symbolPattern = /\$([a-zA-Z]\w*)/g;
};

//iteration 1 https://sites.google.com/site/unclebobconsultingllc/one-thing-extract-till-you-drop
SymbolReplacer.prototype.replace = function(stringToReplace) {
    var matches;
    while (matches = this.symbolPattern.exec(stringToReplace)) {
        var symbolReplace = matches[0];
        var symbolName = matches[1];
        stringToReplace = this.replaceInstance(symbolReplace, symbolName, stringToReplace);
    }
    return stringToReplace;
};

SymbolReplacer.prototype.replaceInstance = function(symbolReplace, symbolName, stringToReplace) {
    return getSymbol(symbolName) !== null ? stringToReplace.replace(symbolReplace, getSymbol(symbolName)) : stringToReplace;
};

var x = new SymbolReplacer();
console.log(x.replace('dit $is een $test $test $test $is $complex gewoon woord'));
var result = 'dit replace een replace replace replace replace replace gewoon woord';
console.log(result === x.replace('dit $is een $test $test $test $is $complex gewoon woord'));
```

# Iteration 5 - clean up

```js
function getSymbol(symbolName) {
    return 'replace';
}

//iteration 1 https://sites.google.com/site/unclebobconsultingllc/one-thing-extract-till-you-drop
function replaceSymbol(stringToReplace) {
    var symbolPattern = /\$([a-zA-Z]\w*)/g;
    var matches;
    while (matches = symbolPattern.exec(stringToReplace)) {
        var symbolReplace = matches[0];
        var symbolName = matches[1];
        stringToReplace = replaceInstance(symbolReplace, symbolName, stringToReplace);
    }
    return stringToReplace;
};

function replaceInstance(symbolReplace, symbolName, stringToReplace) {
    return getSymbol(symbolName) !== null ? stringToReplace.replace(symbolReplace, getSymbol(symbolName)) : stringToReplace;
};

var result = replaceSymbol('dit $is een $test $test $test $is $complex gewoon woord');
var expectedResult = 'dit replace een replace replace replace replace replace gewoon woord';
console.log(expectedResult === result);
```

Things to improve:

* symbolPattern as argument (make sure to run new regexp on it)
* don't call getSymbol 2 times

# References

[1](http://verraes.net/2013/09/extract-till-you-drop/)
[0](https://sites.google.com/site/unclebobconsultingllc/one-thing-extract-till-you-drop)
