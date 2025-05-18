<?php
namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class UserDataController extends Controller
{
    public function updateBMI(Request $request)
    {
        $request->validate([
            'bmi' => 'nullable|string',
            'height' => 'nullable|numeric',
            'weight' => 'nullable|numeric',
            'total_bmi' => 'nullable|numeric',
        ]);

        $user = Auth::user();
        $user->bmi = $request->bmi;
        $user->height = $request->height;
        $user->weight = $request->weight;
        $user->total_bmi = $request->total_bmi;
        $user->save();

        return response()->json(['success' => true,'message' => 'BMI berhasil diupdate']);
    }

    public function updateMentalHealth(Request $request)
    {
        $request->validate([
            'mental_health' => 'nullable|string',
        ]);

        $user = Auth::user();
        $user->mental_health = $request->mental_health;
        $user->save();

        return response()->json([
            'success' => true,'message' => 'Kondisi mental berhasil diupdate']);
    }

    public function getUserProfile()
    {
        $user = Auth::user();
        return response()->json([
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'bmi' => $user->bmi,
            'mental_health' => $user->mental_health,
            'height' => $user->height,
            'weight' => $user->weight,
            'total_bmi' => $user->total_bmi,
        ]);
    }
}
