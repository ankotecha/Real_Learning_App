const express = require('express');
const app = express();
app.use(function (request, response, next) {
  response.setHeader("Access-Control-Allow-Origin", "*");
  response.setHeader("Access-Control-Allow-Credential", "true");
  response.setHeader("Access-Control-Allow-Methods", "GET,HEAD,OPTIONS,POST,PUT,DELETE");
  response.setHeader("Access-Control-Allow-Headers", "Access-Control-Allow-Origin,Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers,Authorization");
  next();
});





app.listen(7762, function () {
  console.log('Listening on port: 7762');
});

app.post('/home', function (req, res) {
  console.log(req.body);

});

var adminAccount = require("./pythonadmin.json");
const admin = require('firebase-admin');




admin.initializeApp({
  credential: admin.credential.cert(adminAccount)
});

let db = admin.firestore();

let docRef = db.collection('users').doc('alovelace');



db.collection('users').get()
  .then((snapshot) => {
    snapshot.forEach((doc) => {
      console.log(doc.id, '=>', doc.data());
    });
  })
  .catch((err) => {
    console.log('Error getting documents', err);
  });




app.get('/usercount', function (req, res) {
  size = 0;
  db.collection('users').get()
    .then((snapshot) => {
      size = snapshot.size;
      return res.send({ size });

    })


}
)

app.get('/coursecount', function (req, res) {
  size = 0;
  db.collection('course').get()
    .then((snapshot) => {
      size = snapshot.size;
      return res.send({ size });

    })
})



