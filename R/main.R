library(shiny)
library(rredis)
redisConnect()

ui <- fluidPage(
    titlePanel("Aplicação Web"),
    textInput("login", "Informe o seu Login"),
    actionButton("Processar","Processar"),
    h1(textOutput("Resultado"))
)


server <- function(input, output) {
    
    observeEvent(input$Processar, {
       login =  input$login
       
       if (redisExists(login)==TRUE)
       {
         output$Resultado = renderText({paste("Login Ativo, criando em ", 
            as.character(redisGet(login)), "Tempo para Expirar:",  as.character(redisTTL(login)), 'segundo(s)', sep=" " )})
      }
       else
       {
         redisSet(login,Sys.time())
         redisExpire(login, 10)
         output$Resultado =  renderText({'Login Registrado'})
        
       }
    }) 
        
}

shinyApp(ui = ui, server = server)