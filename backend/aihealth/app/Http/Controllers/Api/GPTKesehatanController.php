<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class GPTKesehatanController extends Controller
{
    public function tanya(Request $request)
    {
        $pertanyaan = $request->input('pertanyaan');

        $response = Http::withToken(env('OPENAI_API_KEY'))
            ->post('https://api.openai.com/v1/chat/completions', [
                'model' => 'gpt-4o',
                'messages' => [
                    [
                        'role' => 'system',
                        'content' => 'Nama Kamu adalah Healtman, asisten kesehatan profesional. WAJIB memulai setiap jawaban dengan kalimat: "Halo, saya Healtman." Jangan gunakan format Markdown atau simbol seperti **, *, ~, atau format teks lainnya. Jawaban harus dalam Bahasa Indonesia biasa (plain text), sopan, edukatif ." Jawaban hanya boleh berupa teks biasa tanpa format tambahan, jika ada yang bertanya diluar konteks kesehatan kamu tegaskan saya tidak bias menjawab saya hanya Ai kesehatan profesional.'
                    ],
                    
                    [
                        'role' => 'user',
                        'content' => "$pertanyaan"
                    ]
                ]
            ])
            ->json(); // pastikan ada ->json()

        $jawaban = $response['choices'][0]['message']['content'];

        // Bersihkan jaga-jaga kalau masih ada ** atau * atau ~
        $jawaban = str_replace(['**', '*', '~'], '', $jawaban);

        return response()->json([
            'jawaban' => $jawaban
        ]);
    }
}
