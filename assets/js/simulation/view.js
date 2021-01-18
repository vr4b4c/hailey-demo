import api from './api';

export default function(rootEl) {
  const startBtn = rootEl.querySelector('.js-start');
  const stopBtn = rootEl.querySelector('.js-stop');
  const count = rootEl.querySelector('.js-form [name="simulation[count]"]')

  function bootstrap() {
    startBtn.addEventListener('click', start)
    stopBtn.addEventListener('click', stop)
  }

  function start(event) {
    event.preventDefault();

    api.start({count: count.value});
  }

  function stop(event) {
    event.preventDefault();

    api.stop();
  }


  bootstrap();
}
