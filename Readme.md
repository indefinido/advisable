# Advisable

  Aspect oriented programming mixin

## Installation

    $ component install indefinido/advisable

## API

```javascript

  advisable = require('advisable').mixin;

  arthur = advisable({
    name     : function full_name () { return this.firstname + " " + this.surname; },
    firstname: "Arthur Philip",
    surname  : "Dent",
    species  : "Humam"
  });

  arthur.before('name', function () {
    console.log('excuted before arthur.name()');
  });

  arthur.after('name', function () {
    console.log('excuted after arthur.name()');
  });

  // You must manually call the actual function or
  // the callback chain will fail.
  arthur.around('name', function (full_name) {
    console.log('excuted before arthur.name()');
	full_name();
    console.log('excuted after arthur.name()');
  });


```

## TODO

 - Throw exception when user does not call adviced function
 - Implement tests
 - Send pull request for https://github.com/cujojs/meld sending component.json


## License

  WTFPL
