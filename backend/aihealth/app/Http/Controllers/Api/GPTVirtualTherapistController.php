<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class GPTVirtualTherapistController extends Controller
{
    public function therapist (Request $request){
        $pertanyaan = $request -> input('pertanyaan');
        $response = Http::withToken(env('OPENAI_API_KEY'))
            ->post('https://api.openai.com/v1/chat/completions', [
                'model' => 'gpt-4o',
                'messages' => [
                    [
                        'role' => 'system',
                        'content' => 'Nama Kamu adalah TheraMan, asisten kesehatan mental profesional. WAJIB memulai setiap jawaban dengan kalimat: "Halo, saya Theraman." Jangan gunakan format Markdown atau simbol seperti **, *, ~, atau format teks lainnya. Jawaban harus dalam Bahasa Indonesia biasa (plain text), sopan, edukatif ." Jawaban hanya boleh berupa teks biasa tanpa format tambahan.'
                    ],
                    [
                        'role' => 'user',
                        'content' => "Halo Theraman, mental saya $pertanyaan, saya ingin tahu lebih banyak tentang kesehatan mental saya. Apakah Anda bisa membantu saya untuk memberikan respons empatik, solusi, atau langkah-langkah praktis untuk mengatasi masalah?"
                    ]
                ]
                
            ]);
            $jawaban = $response['choices'][0]['message']['content'];

            // Bersihkan jaga-jaga kalau masih ada ** atau * atau ~
            $jawaban = str_replace(['**', '*', '~'], '', $jawaban);
         
        return response()->json([
            'jawaban' => $jawaban
        ]);
             
    }
}
