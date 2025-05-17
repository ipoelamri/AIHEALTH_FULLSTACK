<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\GPTKesehatanController;
use App\Http\Controllers\Api\GPTVirtualTherapistController;
use App\Http\Controllers\Api\MentaalHealthController;
use App\Http\Controllers\Api\UserDataController;
use App\Http\Controllers\GPTConttroller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', [UserDataController::class, 'getUserProfile']);
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::post('/tanya', [GPTKesehatanController::class, 'tanya']);
    Route::post('/mental-health', [MentaalHealthController::class, 'check']);
    Route::post('/therapist', [GPTVirtualTherapistController::class, 'therapist']);
    Route::post('/update-bmi', [UserDataController::class, 'updateBMI']);
    Route::post('/update-mental-health', [UserDataController::class, 'updateMentalHealth']);
});
Route::post('/tanya', [GPTKesehatanController::class, 'tanya']);
Route::post('/therapist', [GPTVirtualTherapistController::class, 'therapist']);