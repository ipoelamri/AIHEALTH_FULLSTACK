<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\GPTKesehatanController;
use App\Http\Controllers\GPTConttroller;
use App\Http\Controllers\Api\MentaalHealthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;



Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');
Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');
Route::post('/tanya', [GPTKesehatanController::class, 'tanya']);
Route::post('/mental-health', [MentaalHealthController::class, 'check']);
//Route::post('/tanya', [GPTConttroller::class, 'tanya']);