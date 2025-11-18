defmodule Dominio.Proyecto do
  @moduledoc """
  Representa el proyecto que desarrolla un equipo durante la Hackathon.
  Incluye la idea, descripción, avances y retroalimentación.
  Auto-creado al crear un equipo.
  """

  defstruct [
    :id,
    :nombre_equipo,
    :titulo,
    :descripcion,
    :categoria,     # Educación, Ambiental, Social
    :estado,        # :registrado, :en_progreso, :completado
    :estado_equipo, # :activo, :inactivo (sincronizado con el equipo)
    :avances,       # Lista de avances realizados
    :retroalimentacion, # Comentarios de mentores
    :suscriptores,  # PIDs que escuchan cambios en tiempo real
    :fecha_registro,
    :fecha_actualizacion
  ]

  @doc """
  Crea un nuevo proyecto automáticamente al crear un equipo
  """
  def nuevo(nombre_equipo, categoria, estado_equipo \\ :activo) do
    %__MODULE__{
      id: generar_id(),
      nombre_equipo: nombre_equipo,
      titulo: "Proyecto #{nombre_equipo}",
      descripcion: "Proyecto en desarrollo para la categoría #{categoria}",
      categoria: categoria,
      estado: :registrado,
      estado_equipo: estado_equipo,
      avances: [],
      retroalimentacion: [],
      suscriptores: [],
      fecha_registro: DateTime.utc_now(),
      fecha_actualizacion: DateTime.utc_now()
    }
  end
end
