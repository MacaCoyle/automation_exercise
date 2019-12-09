require 'selenium-webdriver'

#I've made a dictionary in order to make the search info dinamic
def data
  return{
  :search_text => "keyword"
  }
end
#We are going to run our test on firefox 
  driver = Selenium::WebDriver.for :firefox

#I've made a URL dictionary in order to make the URL dinamic
def url
  return{
  :url_test => "https://www.upwork.com/"
  }
end
#In this line we are going to open the site of upwork
driver.navigate().to(url[:url_test])

#Since the conection maybe too fast and does not give the test time to find the elements, I've added some sleeps
  sleep(0.05)
#name_of_the_element = element_location
#I've used xpath that it is not a good practice since is too expensive too maintain but the elements of the page haven't one specific id or class
  #Home elements page
  sleep(3)
  search_input = driver.find_element(:xpath, '/html/body/div[1]/div[2]/div/up-header-visitor-primary-nav/nav/div/div[2]/div[1]/up-header-search/up-c-on-click-outside/form/div/input[2]')
  search_submit_button = driver.find_element(:xpath, '/html/body/div[1]/div[2]/div/up-header-visitor-primary-nav/nav/div/div[2]/div[1]/up-header-search/up-c-on-click-outside/form/div/div/button[1]/span[1]')
  search_input.send_keys(data[:search_text])
 #I've used print to log info in the console. I'm used to use the gem 'logger' to log info
  print"The user have made a search in the search input.\n"
  sleep(3)
  search_submit_button.click
  print"The user have clicked in the submit search button\n"
  #Frelance search list
  sleep(5)
  #Elements
  freelancer_name = driver.find_elements(:xpath,'//*[@id="oContractorResults"]/div/div/section/div/div/article/div[2]/div/div/h4')
  freelancer_title = Array.new
  freelancer_title = driver.find_elements(:xpath,'//*[@id="oContractorResults"]/div/div/section/div/div/article/div[2]/div[1]/div/div/div/div/h4')
  freelancer_title_count = freelancer_title.length
  print " ", "The total amount of frelancers are", " ", (freelancer_title_count), ".\n"
  freelancer_title_text = freelancer_title.map { |e| e.text.downcase }

  #I've mave a loop with while to iterate the results
  x = 0
  while x <  freelancer_title_text.length  do
   if freelancer_title_text[x].split(/[^a-zA-Z]/).include?(data[:search_text])
       print "This frelancer has keyword in their title: ", (freelancer_title_text[x]), ".\n" 
     else 
      print "This frelancer has not keyword in their title: ", (freelancer_title_text[x]), ".\n"
   end
  x +=1 
  end

  sleep(1)
  card = freelancer_name.sample
  sleep(1)
  print"it is going to click a job title card randomly.\n"
  card.click
  sleep(6)
  print "The user enter to the freelancer person detail"
  #Freelance detail page elements
  freelance_tags = Array.new
  sleep(2)
  freelance_tags = driver.find_elements(:xpath, '//*[@id="oProfilePage"]/div[1]/div/cfe-profile-skills-integration/div/div/div/section/div/cfe-profile-skills/div/div[1]/span')
  freelance_tags_text = freelance_tags.map { |e| e.text.downcase }
  sleep(5)

  #I've repeated the function of the item 7 of the exercise, it is not appropriate for a OOP model/approach it should be a function
  y = 0
  while y <  freelance_tags_text.length  do
   if freelance_tags_text[y].split(/[^a-zA-Z]/).include?(data[:search_text])
       print "This tag has keyword : ", (freelance_tags_text[y]), ".\n" 
     else
      print "This tag has not keyword : ", (freelance_tags_text[y]), ".\n"
   end
  y +=1 
  end 

  sleep(2)
driver.close

