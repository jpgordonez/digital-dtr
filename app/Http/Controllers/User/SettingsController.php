<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;


class SettingsController extends Controller
{
    public function uploadProfile(Request $request)
    {
        $request->validate([
            'image' => 'required|image|mimes:jpg,jpeg,png,webp|max:5120'
        ]);

        /** @var \App\Models\User $user */
        $user = Auth::user();

        $path = $request->file('image')->store('profiles', 'public');

        $user->update([
            'profile_photo' => $path
        ]);

        return back();
    }



public function updateProfile(Request $request)
{
    $request->validate([
        'name' => 'required|string|max:255',
    ]);

    /** @var \App\Models\User $user */
    $user = Auth::user();

    $user->update([
        'name' => $request->name
    ]);

    return back();
}


public function updatePassword(Request $request)
{
    $request->validate([
        'current_password' => 'required',
        'password' => 'required|min:6|confirmed',
    ]);

    /** @var \App\Models\User $user */
    $user = Auth::user();

    // check current password
    if (!Hash::check($request->current_password, $user->password)) {
        return back()->withErrors([
            'current_password' => 'Incorrect current password'
        ]);
    }

    $user->update([
        'password' => Hash::make($request->password)
    ]);

    return back();
}
}