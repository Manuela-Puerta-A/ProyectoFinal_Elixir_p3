defmodule Servicios.ServicioEquipos do
  @moduledoc """
  Servicio para gestionar equipos.
  Implementa concurrencia usando spawn, send y receive.
  """

  alias Dominio.Equipo
  alias Adaptadores.Almacenamiento

  @nombre_servicio :servicio_equipos

  @doc """
  Inicia el servicio de equipos
  """
  def iniciar() do
    pid = spawn(fn -> ciclo() end)
    Process.register(pid, @nombre_servicio)
    {:ok, pid}
  end
