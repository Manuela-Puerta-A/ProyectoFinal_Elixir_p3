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
