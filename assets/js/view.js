import boxContainer from './box-container';

export default function(socket) {
  let channel = socket.channel("schedule", {})
  let container = boxContainer(document.querySelector('.box-container'));

  window.r = repo();

  channel.join()
    .receive("ok", (message) => joined(container, message))
    .receive("error", failed);

  channel.on("start", (message) => start(container, message));
  channel.on("stop", (message) => stop(container, message));
  channel.on("tick", (message) => tick(container, message));
}

function joined(container, scheduleIds) {
  container.clear();
  scheduleIds.forEach(container.add);
}

function failed(message) {
  console.log("Unable to join", message);
}

function start(boxContainer, message) {
  boxContainer.add(message.schedule.id)
}

function stop(boxContainer, message) {
  boxContainer.remove(message.schedule.id)
}

function tick(boxContainer, message) {
  r.add(message.timestamp, message.schedule.id);
  boxContainer.mutate(message.schedule.id)
};

function repo() {
  var _store = new Map();

  return {
    add: add,
    store: store
  }

  function add(key, value) {
    if(_store.has(key)) {
      _store.get(key).push(value);
    } else {
      _store.set(key, [value]);
    }
  }

  function store() {
    return _store;
  }
}
