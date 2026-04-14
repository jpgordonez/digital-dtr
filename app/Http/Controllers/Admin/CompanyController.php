<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Company;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;

class CompanyController extends Controller
{
    public function index()
    {
        return Inertia::render('Admin/Companies/Index', [
            'companies' => Company::latest()->get()
        ]);
    }

    public function store()
    {
        request()->validate([
            'name' => 'required|string|max:255',
            'address' => 'nullable|string|max:255',
            'logo' => 'nullable|image|max:2048',
        ]);

        $logoPath = null;

        if (request()->file('logo')) {
            $logoPath = request()->file('logo')->store('companies', 'public');
        }

        Company::create([
            'name' => request('name'),
            'address' => request('address'),
            'logo' => $logoPath
        ]);

        return redirect()->route('admin.companies');
    }

    public function update($id)
    {
        $company = Company::findOrFail($id);

        request()->validate([
            'name' => 'required|string|max:255',
            'address' => 'nullable|string|max:255',
            'logo' => 'nullable|image|max:2048',
        ]);

        if (request()->file('logo')) {
            if ($company->logo) {
                Storage::disk('public')->delete($company->logo);
            }

            $company->logo = request()->file('logo')->store('companies', 'public');
        }

        $company->name = request('name');
        $company->address = request('address');
        $company->save();

        return redirect()->route('admin.companies');
    }

    public function destroy($id)
    {
        $company = Company::findOrFail($id);

        if ($company->logo) {
            Storage::disk('public')->delete($company->logo);
        }

        $company->delete();

        return redirect()->route('admin.companies');
    }
}