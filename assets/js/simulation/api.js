function start(data) {
  return fetch('/api/simulation', {
    method: 'POST',
    body: JSON.stringify(data),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }
  });
}

function stop() {
  return fetch('/api/simulation', {
    method: 'DELETE'
  });
}

export default {
  start: start,
  stop: stop
}
