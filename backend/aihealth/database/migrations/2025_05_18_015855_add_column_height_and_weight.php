<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('users', function (Blueprint $table) {
            $table->float('height')->nullable(); // Menambahkan kolom height
            $table->float('weight')->nullable(); // Menambahkan kolom weight
            $table->float('total_bmi')->nullable(); 
        });
    }

    public function down()
    {
        Schema::table('users', function (Blueprint $table) {
        $table->dropColumn(['height', 'weight','total_bmi']); // Menghapus kolom height dan weight
                    
        });
    }
    /**
     * Run the migrations.
     */
    // public function up(): void
    // {
    //     Schema::table('users', function (Blueprint $table) {
    //         $table->float('height')->nullable(); // Menambahkan kolom height
    //         $table->float('weight')->nullable(); // Menambahkan kolom weight
    //         $table->float('total_bmi')->nullable(); 
    //     });
    // }

    // /**
    //  * Reverse the migrations.
    //  */
    // public function down(): void
    // {
    //     Schema::table('users', function (Blueprint $table) {
    //         $table->dropColumn(['height', 'weight','total_bmi']); // Menghapus kolom height dan weight
    //     });
    // }
};
