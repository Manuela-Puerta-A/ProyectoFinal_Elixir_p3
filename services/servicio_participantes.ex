defmodule Servicios.ServicioParticipantes do
  @moduledoc """
  Servicio para gestionar participantes.
  Usa procesos con spawn/send/receive como en los ejemplos del profesor.
  """

  alias Dominio.Participante
  alias Adaptadores.Almacenamiento

  @nombre_servicio :servicio_participantes

  @doc """
  Inicia el servicio de participantes
  """
  def iniciar() do
    pid = spawn(fn -> ciclo() end)
    Process.register(pid, @nombre_servicio)
    {:ok, pid}
  end
