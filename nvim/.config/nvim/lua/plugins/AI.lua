return {
    {
        "David-Kunz/gen.nvim",
        event = "VeryLazy",
        opts = {
            model = "qwenx", -- Menghubungkan langsung ke Gemma 2B
            quit_map = "q",
            retry_map = "<c-r>",
            display_mode = "float", -- Menampilkan jawaban AI dalam floating window
            show_prompt = false,
            show_model = false,
            no_auto_close = false,
            init = function()
                -- Memastikan Ollama server aktif secara otomatis jika belum berjalan
                pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
            end,
        },
    },
}
