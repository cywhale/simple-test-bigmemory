import * as firebase from "firebase/app";
//import 'firebase/database';
import 'firebase/auth';
const { firebaseConfig } = require('../../.credentials.development.js')

firebase.initializeApp(firebaseConfig);

export default firebase;

//export const database = firebase.database();
export const auth = firebase.auth();
export const googleAuthProvider = new firebase.auth.GoogleAuthProvider();
