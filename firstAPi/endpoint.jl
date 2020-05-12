using Bukdu
using JSON

struct WelcomeController <: ApplicationController
    conn::Conn
end

function index(c::WelcomeController)
    render(JSON, "Hello World meu camarada")
end

function process_resource(c::WelcomeController)
    json = JSON.parse(String(c.conn.request.body))

    @show json

    render(JSON, json)
end

routes() do
    get("/", WelcomeController, index)
    post("/resource/process", WelcomeController, process_resource)
end

Bukdu.start(8080)

Base.JLOptions().isinteractive == 0 && wait()
