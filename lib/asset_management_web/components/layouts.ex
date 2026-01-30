defmodule AssetManagementWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use AssetManagementWeb, :html

  embed_templates "layouts/*"

  @doc """
  Renders your app layout with modern, clean navigation
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"

  attr :current_scope, :map,
    default: nil,
    doc: "the current scope"

  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <div class="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      <header class="bg-white/80 dark:bg-slate-900/80 backdrop-blur-sm border-b border-slate-200 dark:border-slate-700 sticky top-0 z-50">
        <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="flex justify-between items-center h-16">
            <!-- Logo and Brand -->
            <div class="flex items-center gap-8">
              <a href="/" class="flex items-center gap-3 group">
                <div class="w-10 h-10 bg-gradient-to-br from-blue-600 to-indigo-600 rounded-lg flex items-center justify-center shadow-lg group-hover:shadow-xl transition-shadow">
                  <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                  </svg>
                </div>
                <span class="text-xl font-semibold text-slate-900 dark:text-slate-100">
                  Asset Management
                </span>
              </a>
              
              <!-- Navigation Links -->
              <div class="hidden md:flex items-center gap-1">
                <a href="/resources" class="px-4 py-2 text-sm font-medium text-slate-700 dark:text-slate-300 hover:text-blue-600 dark:hover:text-blue-400 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors">
                  Resources
                </a>
                <a href="/users" class="px-4 py-2 text-sm font-medium text-slate-700 dark:text-slate-300 hover:text-blue-600 dark:hover:text-blue-400 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors">
                  Users
                </a>
                <a href="/allocations" class="px-4 py-2 text-sm font-medium text-slate-700 dark:text-slate-300 hover:text-blue-600 dark:hover:text-blue-400 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors">
                  Allocations
                </a>
              </div>
            </div>

            <!-- Right side actions -->
            <div class="flex items-center gap-3">
              <.theme_toggle />
            </div>
          </div>
        </nav>
      </header>

      <!-- Main Content -->
      <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {render_slot(@inner_block)}
      </main>
    </div>

    <.flash_group flash={@flash} />
    """
  end

  @doc """
  Shows the flash group with modern styling
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} class="fixed top-20 right-4 z-50 space-y-2" aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title="Connection Lost"
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        Reconnecting...
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title="Something went wrong"
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        Reconnecting...
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc """
  Modern theme toggle with clean design
  """
  def theme_toggle(assigns) do
    ~H"""
    <div class="relative flex items-center bg-slate-100 dark:bg-slate-800 rounded-full p-1 border border-slate-200 dark:border-slate-700">
      <div class="absolute w-[calc(33.333%-4px)] h-[calc(100%-8px)] rounded-full bg-white dark:bg-slate-700 shadow-sm left-1 [[data-theme=light]_&]:left-[calc(33.333%+2px)] [[data-theme=dark]_&]:left-[calc(66.666%+3px)] transition-all duration-200 ease-in-out" />

      <button
        class="relative z-10 p-2 cursor-pointer transition-colors"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
        title="System theme"
      >
        <.icon name="hero-computer-desktop" class="size-4 text-slate-600 dark:text-slate-400" />
      </button>

      <button
        class="relative z-10 p-2 cursor-pointer transition-colors"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
        title="Light theme"
      >
        <.icon name="hero-sun" class="size-4 text-slate-600 dark:text-slate-400" />
      </button>

      <button
        class="relative z-10 p-2 cursor-pointer transition-colors"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark"
        title="Dark theme"
      >
        <.icon name="hero-moon" class="size-4 text-slate-600 dark:text-slate-400" />
      </button>
    </div>
    """
  end
end
