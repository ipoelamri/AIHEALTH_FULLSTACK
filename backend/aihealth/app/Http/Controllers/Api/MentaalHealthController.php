<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
//use Illuminate\Support\Facades\Http;

class MentaalHealthController extends Controller
{
    public function check (Request $request){
        //dd($request->all());
        $validated = $request->validate([
            'answer' => 'required|array|size:5',
            'answer.*' => 'required|in:iya,tidak',
        ]);
        $score = 0;
        foreach ($validated['answer'] as $answer) {
            if ( (strtolower($answer) === 'iya') ) {
                $score++;
            }
        }

        if ($score ==  0){
            $mood = 'Baik';
            $message = 'Kondisi mental Anda baik-baik saja. Terus jaga kesehatan mental Anda.';
        }elseif ($score <=2){
            $mood = 'Cemas Ringan';
            $message = 'Anda mungkin mengalami sedikit stres atau kelelahan ringan. Cobalah relaksasi atau waktu istirahat.';
        }elseif ($score <=4){
            $mood = 'Stress';
            $message = 'Tanda-tanda tekanan mental mulai muncul. Luangkan waktu untuk diri sendiri atau bicaralah dengan seseorang.';

        }else {
            $mood = 'Stress Berat';
            $message = 'Anda mungkin mengalami kecemasan yang lebih serius. Pertimbangkan untuk berbicara dengan seorang profesional kesehatan mental secepatnya.';
        }

        return response()->json([
            'success' => true,
            'score' => $score,
            'mood' => $mood,
            'message' => $message
        ]);
    }
}
