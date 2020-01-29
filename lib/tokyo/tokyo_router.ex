defmodule Tokyo.Router do
  use Plug.Router

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  alias Tokyo.ExerciseRecord
  alias Tokyo.Controller.ExerciseRecord, as: ExerciseRecController

  # User Endpoints

  # Exercise Endpoints

  get "/users/:user_id/exercise-records" do
    response =
      Task.async(ExerciseRecController, :get_all, [conn, user_id])
      |> Task.await
      |> Jason.encode!

    send_resp(conn, 200, response)
  end

  get "/users/:user_id/exercise-records/:ex_rec_id" do
    response = 
      Task.async(ExerciseRecController, :get_one, [user_id, ex_rec_id])
      |> Task.await
      |> Jason.encode!

    send_resp(conn, 200, response)
  end

  post "/users/:user_id/exercise-records" do
    response = 
      Task.async(ExerciseRecController, :save, [conn, user_id])
      |> Task.await
      |> Jason.encode!

    send_resp(conn, 201, response)
  end

  put "/users/:user_id/exercise-records/:ex_rec_id" do
    response =
      Task.async(ExerciseRecController, :save, [conn, user_id, ex_rec_id])
      |> Task.await
      |> Jason.encode!

    send_resp(conn, 200, response)
  end

  delete "/users/:user_id/exercise-records/:ex_rec_id" do
    response = 
      Task.async(ExerciseRecController, :delete, [conn, user_id, ex_rec_id])
      |> Task.await
      
    send_resp(conn, 204, "Success")
  end

  match _ do
    send_resp(conn, 404, "URI does not exists in Tokyo\r\n")
  end
end
