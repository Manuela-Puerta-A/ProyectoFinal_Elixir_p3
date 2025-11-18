defmodule Dominio.Equipo do
  @moduledoc """
  Representa un equipo participante en la Hackathon.
  Los equipos pueden tener múltiples miembros y trabajan en un proyecto.
  """

  defstruct [
    :id,
    :nombre,
    :tema,          # Categoría del proyecto (Educación, Ambiental, Social)
    :miembros,      # Lista de nombres de participantes
    :lider,         # Nombre del líder del equipo
    :estado,        # :activo, :inactivo
    :fecha_creacion
  ]

  @doc """
  Crea un nuevo equipo
  """
  def nuevo(nombre, tema, lider) do
    %__MODULE__{
      id: generar_id(),
      nombre: nombre,
      tema: tema,
      miembros: [lider],
      lider: lider,
      estado: :activo,
      fecha_creacion: DateTime.utc_now()
    }
  end
