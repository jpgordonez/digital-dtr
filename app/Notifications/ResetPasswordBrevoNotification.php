<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Support\Facades\Http;

class ResetPasswordBrevoNotification extends Notification
{
    use Queueable;

    public $token;

    public function __construct($token)
    {
        $this->token = $token;
    }

    public function via(object $notifiable): array
    {
        $this->sendBrevoEmail($notifiable);

        return [];
    }

    protected function sendBrevoEmail($notifiable): void
    {
        $resetUrl = url('/reset-password/' . $this->token . '?email=' . urlencode($notifiable->email));

        $response = Http::withHeaders([
            'api-key' => env('BREVO_API_KEY'),
            'Content-Type' => 'application/json',
            'Accept' => 'application/json',
        ])->post('https://api.brevo.com/v3/smtp/email', [
            'sender' => [
                'name' => 'Digital DTR',
                'email' => 'jpgordonez@gmail.com',
            ],
            'to' => [
                [
                    'email' => $notifiable->email,
                    'name' => $notifiable->name,
                ]
            ],
            'subject' => 'Reset Password Request',
            'htmlContent' => "
                <h2>Reset Password</h2>
                <p>Hello {$notifiable->name},</p>
                <p>Click below to reset password:</p>
                <p><a href='{$resetUrl}'>Reset Password</a></p>
            ",
        ]);

        $response->throw();
    }
}