<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\GPTKesehatanController;
use App\Http\Controllers\GPTConttroller;


Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');
Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');
// Route::post('/consult', [GPTKesehatanController::class, 'tanya']);
Route::post('/tanya', [GPTConttroller::class, 'tanya']);