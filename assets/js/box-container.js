import color from './color';

export default function(container) {
  return {
    clear,
    add,
    remove,
    mutate
  };

  function clear() {
    while (container.firstChild) {
      container.removeChild(container.firstChild);
    }
  }

  function add(id) {
    var box = document.createElement('div');

    box.classList.add('box');
    if(container.querySelectorAll('.box').length % 2 == 0) {
      box.classList.add('box-even');
    } else {
      box.classList.add('box-odd');
    }

    box.setAttribute('data-schedule-id', id)

    container.appendChild(box);
  }

  function remove(id) {
    var box = document.querySelector(".box[data-schedule-id='" + id + "']");

    if(box) {
      box.remove();
    } else {
      console.log('Box not found: ' + id);
    }
  }

  function mutate(id) {
    var box = document.querySelector(".box[data-schedule-id='" + id + "']");

    if(box) {
      box.classList.toggle('box-active');
    } else {
      console.log('El not found: ' + id);
    }
  }
}
