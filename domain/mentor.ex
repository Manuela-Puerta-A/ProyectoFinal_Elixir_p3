defmodule Dominio.Mentor do
  @moduledoc """
  Representa a un mentor que asesora a los equipos durante la Hackathon.
  Los mentores tienen especialidades y pueden dar retroalimentación.
  """

  defstruct [
    :id,
    :nombre,
    :correo,
    :especialidad,      # Área de expertise
    :disponible,        # true/false
    :equipos_asignados, # Lista de nombres de equipos
    :fecha_registro
  ]

  @doc """
  Crea un nuevo mentor
  """
  def nuevo(nombre, correo, especialidad) do
    case validar_correo(correo) do
      :ok ->
        {:ok, %__MODULE__{
          id: generar_id(),
          nombre: nombre,
          correo: correo,
          especialidad: especialidad,
          disponible: true,
          equipos_asignados: [],
          fecha_registro: DateTime.utc_now()
        }}

      {:error, mensaje} ->
        {:error, mensaje}
    end
  end
end
