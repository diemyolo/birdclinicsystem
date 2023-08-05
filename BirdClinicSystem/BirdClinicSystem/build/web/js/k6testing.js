import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {
    stages: [
        {duration: "5s", target: 100},
        {duration: "3s", target: 200},
        {duration: "2s", target: 500}
    ]
};

export default function () {
  // Send a GET request to the API endpoint
    const facebookResponse = http.get('https://www.facebook.com/'); 
}

