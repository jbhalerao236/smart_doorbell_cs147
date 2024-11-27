importScripts('https://www.gstatic.com/firebasejs/9.17.2/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/9.17.2/firebase-messaging.js');

const firebaseConfig = {
  apiKey: "AIzaSyCMBFFkQP_Y_Xu4gSHkLOy21Xq5cON2cpQ",
  authDomain: "smart-doorbell-cs-147.firebaseapp.com",
  projectId: "smart-doorbell-cs-147",
  storageBucket: "smart-doorbell-cs-147.appspot.com",
  messagingSenderId: "741686059791",
  appId: "1:741686059791:web:7cccf2e146da2cc09ed47a",
  measurementId: "G-B13RBLKEV7"
};

firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log('Received background message: ', payload);
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/firebase-logo.png', // optional
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
