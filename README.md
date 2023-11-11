# Pre-requisites
* Ruby 2.7.4/3.0.2
* bundler

# How to run the code

We have provided scripts to execute the code. 

Use `run.sh` if you are Linux/Unix/macOS Operating systems and `run.bat` if you are on Windows.  Both the files run the commands silently and prints only output from the input file `sample_input/input1.txt`. You are supposed to add the input commands in the file from the appropriate problem statement. 

Internally both the scripts run the following commands 

 * `bundle install` - We will install the dependencies and then build the solution by using the following command.
 * We will execute the program using the command `ruby -W0 geektrust.rb sample_input/input1.txt`

We expect your program to take the location to the text file as parameter. Input needs to be read from a text file, and output should be printed to the console. The text file will contain only commands in the format prescribed by the respective problem.

Create a Rakefile with a `default task`. The rake file should import the `main` ruby file, which is the starting point of your application and the call the main method within the `default task`. Also create a `Gemfile` to add your dependencies, if any. The `main file` should read the file path from the `ARGV` variable and then execute the program.

 # Running the code for multiple test cases

 Please fill `input1.txt` and `input2.txt` with the input commands and use those files in `run.bat` or `run.sh`. Replace `ruby -W0 geektrust.rb sample_input/input1.txt` with `ruby -W0 geektrust.rb sample_input/input2.txt` to run the test case from the second file. 

 # How to execute the unit tests

 We support only `RSpec` library for unit testing your Ruby code. We also use the code coverage tool `simple-cov` to calculate the unit test coverage. You are not expected to add the `simple-cov` library to your `Gemfile`, as it will be taken care by us.

 We expect the unit tests to be in either of these four folders:

* spec
* specs
* test
* tests

We run the unit tests and calculate the coverage executing the command

`rspec`

# Help

You can refer our help documents [here](https://help.geektrust.com)
You can read build instructions [here](https://github.com/geektrust/coding-problem-artefacts/tree/master/Ruby)