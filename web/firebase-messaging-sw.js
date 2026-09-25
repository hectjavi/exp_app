importScripts(
  "https://www.gstatic.com/firebasejs/10.13.2/firebase-app-compat.js"
);

importScripts(
  "https://www.gstatic.com/firebasejs/10.13.2/firebase-messaging-compat.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyA-4iTU6-EniSMY7GbybVcwCuzwPYUD4Pc",
  appId: "1:666133883397:web:cb16e1536f6460cd47ca6c",
  messagingSenderId: "666133883397",
  projectId: "ecomerce-flutter-ae26f",
  authDomain: "ecomerce-flutter-ae26f.firebaseapp.com",
  storageBucket: "ecomerce-flutter-ae26f.firebasestorage.app",
  measurementId: "G-HWMZYQ3BC8",
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {

  console.log(
    "Mensaje recibido en background",
    payload
  );

  self.registration.showNotification(
    payload.notification?.title ??
      "Nueva notificación",
    {
      body:
        payload.notification?.body ?? "",
      icon: "/favicon.png",
      data: payload.data,
    }
  );
});

self.addEventListener(
  "notificationclick",
  function (event) {

    event.notification.close();

    const orderId =
      event.notification.data?.orderId;

    let targetUrl = "/orders";

    if (orderId) {
      targetUrl =
        `/order-detail/${orderId}`;
    }

    event.waitUntil(
      clients.matchAll({
        type: "window",
        includeUncontrolled: true,
      }).then((clientList) => {

        for (const client of clientList) {

          if ("focus" in client) {
            client.navigate(targetUrl);
            return client.focus();
          }
        }

        if (clients.openWindow) {
          return clients.openWindow(
            targetUrl
          );
        }
      })
    );
  }
);