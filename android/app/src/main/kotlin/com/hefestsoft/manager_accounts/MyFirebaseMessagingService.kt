package com.hefestsoft.manager_accounts

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Intent
import android.graphics.Color
import android.net.Uri
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage

class MyFirebaseMessagingService : FirebaseMessagingService() {

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        val data = remoteMessage.data
        val title = data["title"] ?: "Cuenta por vencer"
        val body = data["body"] ?: "Haz clic para contactar al cliente"
        val cellphone = data["cellphone_user"] ?: ""
        val service = data["service"] ?: ""
        val email = data["email_account"] ?: ""

        showNotification(title, body, cellphone, service, email)
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun showNotification(title: String, body: String, cellphone: String, service: String, email: String) {
        val channelId = "expiraciones_channel"

        val manager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        val channel = NotificationChannel(
            channelId,
            "Notificaciones de expiraciones",
            NotificationManager.IMPORTANCE_HIGH
        )
        channel.description = "Notificaciones con acción de WhatsApp"
        channel.enableLights(true)
        channel.lightColor = Color.GREEN
        manager.createNotificationChannel(channel)

        // Intent principal -> abrir la app
        val appIntent = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
            putExtra("cellphone_user", cellphone)
            putExtra("service", service)
            putExtra("email_account", email)
            putExtra("from_notification", true)
        }
        val appPendingIntent = PendingIntent.getActivity(
            this,
            System.currentTimeMillis().toInt(),
            appIntent,
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )

        // Intent de WhatsApp -> acción del botón
        val message =
            "🚨 ¡Atención! Tu servicio de $service vence mañana 😱%0A%0A📧 Cuenta: $email%0A%0A¡Renueva hoy y evita interrupciones! 💪%0A%0A🛍️ Escríbenos para renovar al instante 🔁"
        val whatsappIntent = Intent(Intent.ACTION_VIEW)
        whatsappIntent.data = Uri.parse("https://wa.me/$cellphone?text=$message")

        val whatsappPendingIntent = PendingIntent.getActivity(
            this,
            (System.currentTimeMillis() + 1).toInt(), // requestCode diferente
            whatsappIntent,
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )

        // Construye la notificación con dos acciones
        val notification = NotificationCompat.Builder(this, channelId)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle(title)
            .setContentText(body)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .setContentIntent(appPendingIntent)
            .addAction(
                R.mipmap.ic_launcher,
                "💬 WhatsApp",
                whatsappPendingIntent
            )
            .build()

        manager.notify(System.currentTimeMillis().toInt(), notification)
    }
}
