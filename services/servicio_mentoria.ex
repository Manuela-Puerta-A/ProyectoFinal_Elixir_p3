defmodule Servicios.ServicioMentoria do
  @moduledoc """
  Servicio para gestionar mentores y su interacción con equipos.
  Los mentores pueden dar retroalimentación a los proyectos.
  """

  alias Dominio.Mentor
  alias Adaptadores.Almacenamiento

  @nombre_servicio :servicio_mentoria

  @doc """
  Inicia el servicio de mentoría
  """
  def iniciar() do
    pid = spawn(fn -> ciclo() end)
    Process.register(pid, @nombre_servicio)
    {:ok, pid}
  end
