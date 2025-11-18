# Cargar el procesador de comandos
Code.require_file("adapters/procesador_comandos.ex", __DIR__)

defmodule ClienteHackathon do
  @moduledoc """
  Cliente para conectarse al servidor de la Hackathon.
  Permite ejecutar todos los comandos de forma remota.
  """

  alias Adaptadores.ProcesadorComandos

  # CONFIGURACIÓN - Modificar con la IP del servidor
  @servidor_nodo :"servidor@192.168.1.58"
  @servidor_remoto {:hackathon_server, @servidor_nodo}

  def main() do
    mostrar_banner()
    conectar_servidor()
  end

  defp mostrar_banner() do
    IO.puts("\nCLIENTE HACKATHON CODE4FUTURE\n")
  end

  defp conectar_servidor() do
    IO.puts("Conectando al servidor: #{@servidor_nodo}")

    case Node.connect(@servidor_nodo) do
      true ->
        IO.puts(" Conectado exitosamente al servidor")
        IO.puts(" Escribe /ayuda para ver los comandos disponibles\n")
        ciclo_principal()

      false ->
        IO.puts(" No se pudo conectar al servidor")
        IO.puts("Verifica que:")
        IO.puts("  1. El servidor esté ejecutándose")
        IO.puts("  2. La IP sea correcta: #{@servidor_nodo}")
        IO.puts("  3. La cookie sea la misma: hackathon_secret\n")

      :ignored ->
        IO.puts(" Ya estabas conectado al servidor")
        ciclo_principal()
    end
  end

  defp ciclo_principal() do
    entrada = IO.gets("hackathon> ") |> String.trim()

    case ProcesadorComandos.parsear(entrada) do
      {:salir, _} ->
        IO.puts("\n Gracias por usar el sistema.\n")
        :ok

      {:ayuda, _} ->
        IO.puts(ProcesadorComandos.mostrar_ayuda())
        ciclo_principal()

      {:registrar, _} ->
        manejar_registro_remoto()
        ciclo_principal()

      {:registrar_mentor, _} ->
        manejar_registro_mentor_remoto()
        ciclo_principal()

      {:listar_participantes, _} ->
        manejar_listar_participantes_remoto()
        ciclo_principal()

      {:listar_equipos, _} ->
        manejar_listar_equipos_remoto()
        ciclo_principal()

      {:crear_equipo, datos} ->
        manejar_crear_equipo_remoto(datos)
        ciclo_principal()

      {:crear_proyecto, datos} ->
        manejar_crear_proyecto_remoto(datos)
        ciclo_principal()

      {:unirse_equipo, nombre_equipo} ->
        manejar_unirse_equipo_remoto(nombre_equipo)
        ciclo_principal()

      {:ver_proyecto, nombre_equipo} ->
        manejar_ver_proyecto_remoto(nombre_equipo)
        ciclo_principal()

      {:agregar_avance, nombre_equipo} ->
        manejar_agregar_avance_remoto(nombre_equipo)
        ciclo_principal()

      {:abrir_chat, canal} ->
        manejar_chat_remoto(canal)
        ciclo_principal()

      {:listar_mentores, _} ->
        manejar_listar_mentores_remoto()
        ciclo_principal()

      {:activar_equipo, nombre_equipo} ->
        manejar_activar_equipo_remoto(nombre_equipo)
        ciclo_principal()

      {:desactivar_equipo, nombre_equipo} ->
        manejar_desactivar_equipo_remoto(nombre_equipo)
        ciclo_principal()

      {:listar_proyectos, _} ->
        manejar_listar_proyectos_remoto()
        ciclo_principal()

      {:listar_proyectos_activos, _} ->
        manejar_listar_proyectos_activos_remoto()
        ciclo_principal()

      {:listar_proyectos_inactivos, _} ->
        manejar_listar_proyectos_inactivos_remoto()
        ciclo_principal()

      {:listar_proyectos_categoria, categoria} ->
        manejar_listar_proyectos_categoria_remoto(categoria)
        ciclo_principal()

      {:actualizar_proyecto, nombre_equipo} ->
        manejar_actualizar_proyecto_remoto(nombre_equipo)
        ciclo_principal()

      {:monitorear_proyecto, nombre_equipo} ->
        manejar_monitorear_proyecto_remoto(nombre_equipo)
        ciclo_principal()

      {:desconocido, _} ->
        IO.puts(" Comando no reconocido. Usa /ayuda para ver los comandos disponibles.")
        ciclo_principal()

      {:error, msg} ->
        IO.puts(" Error: #{msg}")
        ciclo_principal()
    end
  end
