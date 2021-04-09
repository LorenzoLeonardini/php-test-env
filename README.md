# :elephant: PHP test environment

- **What is this?**
In short, this repo is made to generate some docker images used to do unit testing in PHP. Keep reading for more info.

- **Why is this?** [nanesess/setup-php](https://github.com/nanasess/setup-php) is a great GitHub Action to install whichever PHP version you fancy. However, since I do unit testing on different versions, spending ~12 minutes each time to just compile PHP didn't seem that smart. Also, sometimes something changes in the environment setup and my tests fail just because xdebug needs to be installed differently.

- **What does this do?** A GitHub action executes and builds different PHP environments for different versions. Feel free to do a pull request to add the version you need. I use PHP official images as a starting point, and then I setup everything I need.

- **Should I use this?** If you don't rely on this, yes. **DON'T ever think of using this for production**. I wouldn't even use this to run a PHP server on my machine, there are plenty of Docker images for that. This sets up PHP, XDebug, Composer and everything needed for [PHPUnit](https://phpunit.de) tests. Also, everything runs as root.

- **I have improvements for this/I need some other setup** You are more than welcome to do a PR :heart:.

- **Why PHP?!?!** I made some bad life choices

## How to use

The following example is extracted from my GH Action for unit testing. It demonstrates the use with a matrix for different versions (which is obviously not needed).

```yml
jobs:
  unit-testing:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        operating-system: [ ubuntu-latest ]
        php: [ '8.0.0', '8.0.3' ]

    container:
      image: docker.pkg.github.com/lorenzoleonardini/php-test-env/php-test-env:${{ matrix.php }}
      credentials:
        username: ${{ github.actor }}
        password: ${{ secrets.ghcr_token }}

    name: Unit test on PHP ${{ matrix.php }}

    steps:
    - name: Pull repo
      uses: actions/checkout@v2
```