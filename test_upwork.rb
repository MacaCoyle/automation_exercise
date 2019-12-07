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
  print"The user have made a search in the search input"
  sleep(3)
  search_submit_button.click
  print"The user have clicked in the submit search button"
  #Frelance search list
  sleep(5)
  #Elements
  freelancer_name = driver.find_elements(:xpath,'//*[@id="oContractorResults"]/div/div/section/div/div/article/div[2]/div/div/h4')
  freelancer_title = Array.new
  freelancer_title = driver.find_elements(:xpath,'//*[@id="oContractorResults"]/div/div/section/div/div/article/div[2]/div[1]/div/div/div/div/h4')
  freelancer_title_count = freelancer_title.length
  print "total amount of frelancers are", " ", (freelancer_title_count), ". "

  freelancer_title_text = freelancer_title.map { |e| e.text.downcase }
  #print (freelancer_title_text)
  test = Array.new
  test = freelancer_title.map { |word| word.include? (data[:search_text]) }
  print (test)

  sleep(1)
  card = freelancer_name.sample
  sleep(1)
  print"it is going to click a job title card randomly"
  card.click
  sleep(8)
  #Freelance detail page elements
  freelance_tags = Array.new
  sleep(2)
  freelance_tags = driver.find_elements(:xpath, '//*[@id="oProfilePage"]/div[1]/div/cfe-profile-skills-integration/div/div/div/section/div/cfe-profile-skills/div/div[1]')
  freelance_tags_text = freelance_tags.map { |e| e.text.downcase }
  #print(freelance_tags_text)
driver.close

