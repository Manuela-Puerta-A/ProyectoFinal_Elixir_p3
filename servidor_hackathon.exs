# servidor_hackathon.exs
# SERVIDOR CENTRAL DE LA HACKATHON CODE4FUTURE

Code.require_file("domain/participante.ex", __DIR__)
Code.require_file("domain/equipo.ex", __DIR__)
Code.require_file("domain/proyecto.ex", __DIR__)
Code.require_file("domain/mentor.ex", __DIR__)

Code.require_file("adapters/almacenamiento.ex", __DIR__)
Code.require_file("adapters/procesador_comandos.ex", __DIR__)

Code.require_file("servicios/servicio_participantes.ex", __DIR__)
Code.require_file("servicios/servicio_equipos.ex", __DIR__)
Code.require_file("servicios/servicio_proyectos.ex", __DIR__)
Code.require_file("servicios/servicio_mentoria.ex", __DIR__)

defmodule ServidorHackathon do
  @moduledoc """
  Servidor central de la Hackathon Code4Future.
  Maneja todas las peticiones de los clientes conectados.
  """

  alias Adaptadores.Almacenamiento
  alias Servicios.{ServicioParticipantes, ServicioEquipos, ServicioProyectos, ServicioMentoria}

  @nombre_servicio :hackathon_server

  def main() do

    IO.puts("   SERVIDOR HACKATHON CODE4FUTURE - INICIADO  ")


    Process.register(self(), @nombre_servicio)

    # Inicializar todos los servicios
    IO.puts("  Iniciando servicios...")
    {:ok, _} = Almacenamiento.iniciar()
    IO.puts("    Almacenamiento")

    {:ok, _} = ServicioParticipantes.iniciar()
    IO.puts("    Servicio de Participantes")

    {:ok, _} = ServicioEquipos.iniciar()
    IO.puts("    Servicio de Equipos")

    {:ok, _} = ServicioProyectos.iniciar()
    IO.puts("    Servicio de Proyectos")

    {:ok, _} = ServicioMentoria.iniciar()
    IO.puts("    Servicio de Mentoría")

    cargar_datos_ejemplo()

    IO.puts("\n Todos los servicios activos")
    IO.puts(" Esperando conexiones de clientes...")
    IO.puts(" Nodo: #{Node.self()}\n")

    bucle_servidor(%{clientes_chat: %{}})
  end

  defp cargar_datos_ejemplo() do
    IO.puts("\n Cargando datos de ejemplo...")

    # Crear participantes
    ServicioParticipantes.solicitar_registrar("Juan Pérez", "juan@hackathon.com", :participante)
    ServicioParticipantes.solicitar_registrar("María García", "maria@hackathon.com", :participante)
    ServicioParticipantes.solicitar_registrar("Pedro López", "pedro@hackathon.com", :participante)

    # Crear equipos (SIN proyectos automáticos)
    ServicioEquipos.solicitar_crear("Innovadores", "Educacion", "Juan Pérez")
    ServicioEquipos.solicitar_crear("EcoTech", "Ambiental", "María García")

    # Crear mentores
    ServicioMentoria.solicitar_registrar("Dr. Carlos Ruiz", "carlos@hackathon.com", "Inteligencia Artificial")
    ServicioMentoria.solicitar_registrar("Ing. Ana López", "ana@hackathon.com", "Desarrollo Web")

    IO.puts(" Datos de ejemplo cargados")
  end
end
