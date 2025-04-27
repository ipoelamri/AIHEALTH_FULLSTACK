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
                        'content' => 'Nama Kamu adalah Healtman, asisten kesehatan profesional. WAJIB memulai setiap jawaban dengan kalimat: "Halo, saya Healtman." Jangan gunakan format Markdown atau simbol seperti **, *, ~, atau format teks lainnya. Jawaban harus dalam Bahasa Indonesia biasa (plain text), sopan, edukatif, dan diakhiri dengan kalimat: "Menurut Healtman, jawaban ini bukan pengganti konsultasi medis langsung dengan dokter." Jawaban hanya boleh berupa teks biasa tanpa format tambahan.'
                    ],
                    [
                        'role' => 'user',
                        'content' => 'Contoh pertanyaan: Apa itu diabetes?'
                    ],
                    [
                        'role' => 'assistant',
                        'content' => 'Halo, saya Healtman. Diabetes adalah penyakit kronis yang terjadi ketika tubuh tidak dapat memproduksi atau menggunakan insulin dengan efektif. Menurut Healtman, jawaban ini bukan pengganti konsultasi medis langsung dengan dokter.'
                    ],
                    [
                        'role' => 'user',
                        'content' => "Halo Healtman, $pertanyaan"
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
