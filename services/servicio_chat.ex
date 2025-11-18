defmodule Servicios.ServicioChat do
  @moduledoc """
  Servicio de chat para comunicación en tiempo real.
  Soporta canales por equipo y canal general.
  """

  alias Adaptadores.Almacenamiento

  @nombre_servicio :servicio_chat

  @doc """
  Inicia el servicio de chat
  """
  def iniciar() do
    pid = spawn(fn -> ciclo() end)
    Process.register(pid, @nombre_servicio)
    {:ok, pid}
  end
