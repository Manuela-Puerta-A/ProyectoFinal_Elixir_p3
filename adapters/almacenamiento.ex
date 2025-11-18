defmodule Adaptadores.Almacenamiento do
  @moduledoc """
  Módulo para almacenar datos en memoria usando Agent.
  Mantiene el estado de equipos, proyectos, participantes, mentores y mensajes.
  """

  use Agent

  @doc """
  Inicia el almacenamiento con datos vacíos
  """
  def iniciar() do
    estado_inicial = %{
      equipos: %{},
      proyectos: %{},
      participantes: %{},
      mentores: %{},
      mensajes: [],
      participante_actual: nil
    }

    Agent.start_link(fn -> estado_inicial end, name: __MODULE__)
  end

  #  OPERACIONES CON EQUIPOS

  def guardar_equipo(equipo) do
    Agent.update(__MODULE__, fn estado ->
      equipos = Map.put(estado.equipos, equipo.nombre, equipo)
      %{estado | equipos: equipos}
    end)
  end

  def obtener_equipo(nombre_equipo) do
    Agent.get(__MODULE__, fn estado ->
      Map.get(estado.equipos, nombre_equipo)
    end)
  end

  def listar_equipos() do
    Agent.get(__MODULE__, fn estado ->
      Map.values(estado.equipos)
    end)
  end

  # operaciones proyectos

  def guardar_proyecto(proyecto) do
    Agent.update(__MODULE__, fn estado ->
      proyectos = Map.put(estado.proyectos, proyecto.nombre_equipo, proyecto)
      %{estado | proyectos: proyectos}
    end)
  end

  def obtener_proyecto(nombre_equipo) do
    Agent.get(__MODULE__, fn estado ->
      Map.get(estado.proyectos, nombre_equipo)
    end)
  end
