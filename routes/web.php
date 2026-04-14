<?php

use App\Http\Controllers\User\ProfileController as UserProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Models\Company;
use Illuminate\Support\Facades\Storage;
use App\Http\Controllers\Admin\StudentController;
use App\Http\Controllers\Admin\DashboardController as AdminDashboardController;
use App\Http\Controllers\User\AttendanceController;
use App\Http\Controllers\User\DashboardController as UserDashboardController;
use App\Http\Controllers\User\RecordController;
use App\Http\Controllers\User\SettingsController;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Admin\CompanyController;

// LANDING PAGE
Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});

// =========================
// ADMIN ROUTES
// =========================
Route::prefix('admin')->middleware(['auth', 'role:admin'])->group(function () {

    Route::get('/dashboard', [AdminDashboardController::class, 'index'])
        ->name('admin.dashboard');

    Route::get('/students', [StudentController::class, 'index'])->name('admin.students');
    Route::put('/students/{id}', [StudentController::class, 'update'])->name('admin.students.update');
    Route::delete('/students/{id}', [StudentController::class, 'destroy'])->name('admin.students.destroy');
    Route::get('/records', fn() => Inertia::render('Admin/Records/Index'))->name('admin.records');
    Route::get('/reports', fn() => Inertia::render('Admin/Reports/Index'))->name('admin.reports');
    Route::get('/attendance', fn() => Inertia::render('Admin/Attendance/Index'))->name('admin.attendance');
    Route::get('/notifications', fn() => Inertia::render('Admin/Notifications/Index'))->name('admin.notifications');
    Route::get('/settings', fn() => Inertia::render('Admin/Settings/Index'))->name('admin.settings');
    Route::get('/companies', [CompanyController::class, 'index'])
    ->name('admin.companies');
    Route::post('/companies', [CompanyController::class, 'store'])
    ->name('admin.companies.store');
    Route::put('/companies/{id}', [CompanyController::class, 'update'])
    ->name('admin.companies.update');
    Route::delete('/companies/{id}', [CompanyController::class, 'destroy'])
    ->name('admin.companies.delete');

});

// =========================
// USER ROUTES
// =========================
Route::prefix('user')->middleware(['auth', 'role:user'])->group(function () {

    Route::get('/dashboard', [UserDashboardController::class, 'index'])
        ->name('user.dashboard');

    Route::get('/records', [RecordController::class, 'index'])
    ->name('user.records');

    // ATTENDANCE
    Route::get('/attendance', [AttendanceController::class, 'index'])
        ->name('user.attendance');

    Route::post('/attendance', [AttendanceController::class, 'store']);

    // PROFILE (FIXED ✅)
    Route::get('/profile', [UserProfileController::class, 'index'])
        ->name('user.profile');

    Route::post('/profile/company', [UserProfileController::class, 'updateCompany']);
    Route::post('/profile/required-hours', [UserProfileController::class, 'updateRequiredHours']);

    Route::get('/settings', function () {
        return Inertia::render('User/Settings/Index', [
            'user' => Auth::user()
        ]);
    })->name('user.settings');
    Route::post('/settings/upload-profile', [SettingsController::class, 'uploadProfile'])
        ->name('settings.upload');
    Route::post('/settings/update-profile', [SettingsController::class, 'updateProfile']);
    Route::post('/settings/update-password', [SettingsController::class, 'updatePassword']);

    Route::post('/profile/signatory', [UserProfileController::class, 'updateSignatory']);

    Route::get('/records/pdf', [RecordController::class, 'exportPdf']);

});

require __DIR__.'/auth.php';