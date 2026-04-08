<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->decimal('required_hours', 8, 2)->default(0)->change();
            $table->decimal('rendered_hours', 8, 2)->default(0)->change();
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->integer('required_hours')->default(0)->change();
            $table->integer('rendered_hours')->default(0)->change();
        });
    }
};