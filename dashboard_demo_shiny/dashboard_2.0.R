library(shiny)
library(shinydashboard)

# read source
source('./test_gloable_nlp_2.0.R', local = TRUE)
source('./test_gloable_sales_2.0.R', local = TRUE)

#1. headef####
header <- dashboardHeader(title = 'ABC Delicate')

#2. sidebar####
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem('NLP', tabName = 'id_1', icon = icon('alien')),
    menuItem('Sales', tabName = 'id_2', icon = icon('alien')),
    menuItem("Operation", tabName = 'id_3', icon = icon('alien'))
  )
)
#3. body####
body <- dashboardBody(
  tabItems(
    tabItem(tabName = 'id_1',
            
            fluidRow(
              
              box(
                textInput(
                  inputId = 'key_word',
                  label = NULL,
                  value = '請輸入關鍵字'),
                
                sliderInput(
                  inputId = 'char_len',
                  label = '期望出現詞彙最短長度',
                  min = 0,
                  max = 5,
                  value = '1'),
                
                sliderInput(
                  inputId = 'char_freq',
                  label = '期望最低詞彙出現最低頻率',
                  min = 0,
                  max = 5,
                  value = '1'),
                
              ), 
              
              box(wordcloud2Output('wc'))
            )
    ),
    
    tabItem(tabName = 'id_2', 
            
            fluidRow(
              box(
                dateRangeInput("date_range", "請選擇日期:",
                               min = '2005-01-01', max = '2018-12-31',
                               #start = '2005-01-01', end = '2018-12-31',
                               format = "yyyy-mm-dd"),
                
                selectInput(
                  inputId = 'prod_name',
                  label = '請輸入產品名稱',
                  c('家具' = 'Furniture',
                    '辦公用品' = 'Office Supplies',
                    '科技產品' = 'Technology'))
              ),
              box(
                plotOutput('sales_series_prod')
              ))
    ),
    
    tabItem(tabName = 'id_3',
            infoBox('OuOC')
    )
  )
  
)

#1+2+3 = ui####
ui <- dashboardPage(header, sidebar, body)
#server####
server <- function(input, output, session){
  
  # nlp
  
  output$wc = renderWordcloud2({
    plot_word_cloud(df_nlp$excerpt, input$key_word, input$char_len, input$char_freq) 
  })
  
  # sales
  
  output$sales_series_prod = renderPlot({
    plot_prod_serie(df_sales_col,input$prod_name, start = input$date_range[1], end = input$date_range[2])
  })
  
  # "inDateRange"
  
  
  
  
  
}
#runapp####
shinyApp(ui = ui, server = server)
