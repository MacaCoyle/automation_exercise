require 'selenium-webdriver'

#I've make a dictionary in order to make the search info dinamic
def data
  return{
  :search_text => "keyword"
  }
end
#We are going to run our test on firefox 
  driver = Selenium::WebDriver.for :firefox

#I've make a URL dictionary in order to make the URL dinamic
def url
  return{
  :url_test => "https://www.upwork.com/"
  }
end
#In this line we are going to open the site of upwork
driver.navigate().to(url[:url_test])

#Since the conection maybe too fast and does not give the test time to find the elements, I've added some sleeps
  sleep(0.05)
  #I've used xpath that it is not a good practice since is too expensive too maintain but the elements of the page haven't one specific id or class
  #name_of_the_element = element_location
  search_input = driver.find_element(:xpath, '/html/body/div[1]/div[2]/div/up-header-visitor-primary-nav/nav/div/div[2]/div[1]/up-header-search/up-c-on-click-outside/form/div/input[2]').send_keys(data[:search_text])
  sleep(2)
  print"The user have made a search in the search input"
  search_submit_button = driver.find_element(:xpath, '/html/body/div[1]/div[2]/div/up-header-visitor-primary-nav/nav/div/div[2]/div[1]/up-header-search/up-c-on-click-outside/form/div/div/button[1]/span[1]').click
  print"The user have clicked in the submit search button"
  sleep(10)

  #Frelance search list, I've created a hash to map all the card and only click one
  freelance_card = driver.find_element(:xpath, '/html/body/div[1]/div[2]/div/div[2]/div/div[3]/section/div/div/section[1]')

  def select_random_card
    return freelance_card.sample
  end
  sleep(2)
  select_random_card.click

  print"The user have clicked in a random freelance card"


driver.close

