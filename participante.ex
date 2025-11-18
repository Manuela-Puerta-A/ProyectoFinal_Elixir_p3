defmodule Dominio.Participante do
  @moduledoc """
  Representa a un participante de la Hackathon.
  Puede ser un estudiante regular o un mentor.
  """

  # Estructura de datos del participante
  defstruct [
    :id,
    :nombre,
    :correo,
    :rol,           # :participante o :mentor
    :equipo,        # Nombre del equipo al que pertenece
    :habilidades,   # Lista de habilidades técnicas
    :fecha_registro
  ]

  @doc """
  Crea un nuevo participante
  """
  def nuevo(nombre, correo, rol \\ :participante) do
    case validar_correo(correo) do
      :ok ->
        {:ok, %__MODULE__{
          id: generar_id(),
          nombre: nombre,
          correo: correo,
          rol: rol,
          equipo: nil,
          habilidades: [],
          fecha_registro: DateTime.utc_now()
        }}

      {:error, mensaje} ->
        {:error, mensaje}
    end
  end
end
