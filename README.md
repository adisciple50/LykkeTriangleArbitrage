# LykkeTriangleArbitrage
triangle arbitrage for lykke

only executes profitable trade sequences using the triangle arbitrage strategy.

## Prerequisites

* a copy of all the files except for .idea - theres no harm in downloading the .idea folder as well
* an installation of ruby 3.0 or above
* bundler installed as well - installed by defualt on ruby 3.0 or above.

## INSTALLATION

get an api key from lyke under the 'more' dropdown menu from your home dashboard

set the environmental variable:


LYKKE_KEY


copy and paste that into windows environmental variables by typing 'environmental variables' into the start search bar 
and then 'edit the system environment variables' before
setting it in user environmental variables.
the value should be your lykke api key


in linux,go to the end of your .bashrc in your home folder and append to the end
EXPORT LYKKE_KEY=
(after the equals (no spaces) put your api key)


the default trade is 40 pounds capital in GBP with a minumum profit of 5p per trade sequence.

if you want this skip to the 'RUNNING IT' section.

go to main.rb and set up your stake currency in iso 4217 currency code format (something Like GBP or USD or EUR ). 

MAKE SURE YOU PUT THE VALUE IN QUOTES LIKE THIS 'GBP' . 
the value to set is StakeCurrency.

For example 

StakeCurrency ='GBP'



also set the value StakeAmount,

also put a decimal value with 1.0 being £1 and the default £40 being 40.00

this represents your inital starting capital and how much of the money in your wallet to use to make a profit in one trade sequence. 


for example

StakeAmount = 40.00


set the Trading value to true or false. (no quotes)


set it to:


Trading = true


on line 5 to actually execute only profitable trades


or 


Trading = false


to not execute trades but to show the potential profit with the stake your thinking of using.


set the minimum profit per trade sequence by setting a decimal currency value (no quotes) on line 6.

for example:


MinimumProfitPerTrade = 0.05


## RUNNING IT

run this in a terminal/command prompt once youve installed ruby 3.0 or above. it might possibly work on older versions.

run


bundle install


then


bundle exec ruby main.rb


## LICENCE

COPYRIGHT 20203 Mr Jason Arthur Crockett and the Crown Of England.


Presented as a coronation gift to (at the time of writing - recently) His Royal Highness King Charles III and Queen Camilla.


Licenced Under The OGL3 Licence


https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/
