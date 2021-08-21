import { sleep } from "k6";
import http from "k6/http";

export let options = {
  vus: 10,
  duration: '30s',
};

export default function() {
  http.get('https://test.k6.io/static/examples/users.json');
  sleep(1);
}

