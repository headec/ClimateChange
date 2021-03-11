function(){
  tabPanel("About",
           HTML("<h1>Yong Kuk Lee</h1>
           <strong>About the Project</strong>
                <p >This project is to find out if there is any correlation between the CO2 level and Canadian climate.<br>
           <p name= 'data'>The following data will be used on this project:<br>
           - Worldwide CO2 Level<br>
           - Northern Hemisphere CO2 Level<br>
           - Canadian Mean Temperature<br>
           - Canadian Maximum Temperature<br>
           - Canadian Minimum Temperature<br>
           - Canadian Average Snowfall<br>
           - Canadian Mean Precipitation<br>
           </p>
           <p>
           This project is to observe if the increase in CO2 level will result in increasing temperature. The observation on 
           CO2 levels will be collected worldwide and from Northen Hemisphere regions. The comparing temperature will be based on
           Canadian climate. Since Canada is a huge continent which could vary in the temperature by its province or city, the collected data
           from each observatory will be averaged.
           </p>
           <strong>About Myself</strong>
           <p>I'm a statistics student at SFU. I do not have LinkedIn yet, but I will make one as soon as I get more specs on the relating field.
           I have accounts for Github, Twitter, and Facebook although I rarely use them. 
           The links will be provided below.
           <br>
           <em>(This field will be filled more with achievements I make in the future)</em>
                </p>"
           ),#end of html part 1.
           #Notice that I used double quotes (") above because otherwise it would interfere with
           # the single quote in the word (don't)
           HTML('
                <div style="clear: left;">
                <img src="http://farm8.staticflickr.com/7858/47498827012_06e2455f5a_b.jpg" alt="" style="height: 274px; width: 174px; "> </div>
                <p>
                Yong Kuk Lee<br>
                Undergraduate of Statistics and Actuarial Science<br>
                Simon Fraser University<br>

                <a href="https://github.com/headec" target="_blank">Github</a><br>
                <a href="https://twitter.com/Yong4006972" target="_blank">Twitter</a><br/>
                <a href="https://www.facebook.com/supmanlol" target="_blank">Facebook</a><br>
                </p>'),#End of html part 2
           value="about"
           )
}