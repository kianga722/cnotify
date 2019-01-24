//Logic to manipulate DOM elements
const DOMLogic = (() => {
  //Funtion to hide all of page
  const hideAll = () => {
    const eventList = document.getElementById('eventList');
    for (let i=0; i<eventList.children.length; i+=1) {
      eventList.children[i].classList.add('hide');
    }
  }
  //Funtion to show all of page
  const showAll = () => {
    const eventList = document.getElementById('eventList');
    for (let i=0; i<eventList.children.length; i+=1) {
      eventList.children[i].classList.remove('hide');
    }
  }
  //Function to unhide selected event day and month
  const unhideEventDate = (event, type) => {
    let dateFound = false;
    let previousElement = event.previousElementSibling;
    while (!dateFound) {
      if (previousElement.classList.contains(type)) {
        previousElement.classList.remove('hide');
        dateFound = true;
      } else {
        previousElement = previousElement.previousElementSibling;
      }
    }
  }
  //Function to unhide events in a month
  const unhideMonthEvents = (month) => {
    let monthEnd = false;
    let nextElement = month.nextElementSibling;
    while (!monthEnd) {
      if (!nextElement || nextElement.classList.contains('month-wrapper')) {
        monthEnd = true;
      } else {
        nextElement.classList.remove('hide');
        nextElement = nextElement.nextElementSibling;
      }
    }
  }
  //Function to filter page by artist
  const filterArtist = (target) => {
    //Hide all events first and then unhide selected
    hideAll();
    const events = document.getElementsByClassName('event');
    for (let i=0; i<events.length; i+=1) {
      if (events[i].querySelector('.artistSelect').innerHTML.trim().toLowerCase().includes(target.innerHTML.trim().toLowerCase())) {
        //Unhide Event
        events[i].classList.remove('hide');
        //Unhide corresponding day and month
        unhideEventDate(events[i], 'day');
        unhideEventDate(events[i], 'month-wrapper');
      }
    }
  }
  //Function to filter page by venue
  const filterVenue = (target) => {
    //Hide all events first and then unhide selected
    hideAll();
    const events = document.getElementsByClassName('event');
    for (let i=0; i<events.length; i+=1) {
      if (events[i].querySelector('.venueTitle').innerHTML.trim().toLowerCase().includes(target.innerHTML.trim().toLowerCase())) {
        //Unhide Event
        events[i].classList.remove('hide');
        //Unhide corresponding day and month
        unhideEventDate(events[i], 'day');
        unhideEventDate(events[i], 'month-wrapper');
      }
    }
  }
  //Function to filter page by month
  const filterMonth = (target) => {
    //Hide all events first and then unhide selected
    hideAll();
    const months = document.getElementsByClassName('month-wrapper');
    for (let i=0; i<months.length; i+=1) {
      if (months[i].innerHTML.trim().toLowerCase().includes(target.innerHTML.trim().toLowerCase())) {
        //Unhide Month
        months[i].querySelector('.month').classList.remove('hide');
        //Unhide corresponding events in the month
        unhideMonthEvents(months[i]);
      }
    }
  }
  //Function to filter page by recent events
  const filterRecent = () => {
    //Hide all events first and then unhide selected
    hideAll();
    const events = document.getElementsByClassName('event');
    for (let i=0; i<events.length; i+=1) {
      if (events[i].querySelector('.new')) {
        //Unhide Event
        events[i].classList.remove('hide');
        //Unhide corresponding day and month
        unhideEventDate(events[i], 'day');
        unhideEventDate(events[i], 'month-wrapper');
      }
    }
  }

  //Function to show filterCurrent section
  const filterShow = (show) => {
    const filterCurrent = document.getElementById('filterCurrent');
    if (show) {
      filterCurrent.classList.remove('hide');
    } else {
      filterCurrent.classList.add('hide');
    }
  }
  //Function to fill in filter section
  const filterFill = (target) => {
    const filterFill = document.getElementById('filterFill');
    filterFill.innerHTML = `${target.innerHTML}`;
  }

  //Function to check if any events are displayed
  const noEventsCheck = () => {
    const eventList = document.getElementById('eventList');
    for (let i=0; i<eventList.children.length; i+=1) {
      if (eventList.children[i].classList.contains('event') && !eventList.children[i].classList.contains('hide')) {
        return false;
      }
    }
    return true;
  }

  //Function to show no events message
  const noEventsDisplay = (show) => {
    const noEvents = document.getElementById('noEvents');
    if (show) {
      noEvents.classList.remove('hide');
    } else {
      noEvents.classList.add('hide');
    }
  }

  //Function to initalize page
  const pageInit = () => {
    //Show no events message if no events
    noEventsCheck() === true ? noEventsDisplay(true) : noEventsDisplay(false) 
    //Add event listeners to filter dropdown menus
    document.body.addEventListener('click', e => {
      target = e.target;
      if (target.classList.contains('dropdown-item')
        ||target.classList.contains('recent')
        ||target.classList.contains('reset')) {
        e.preventDefault();
        if (target.classList.contains('artists')) {
          filterArtist(target);
          filterShow(true);
          filterFill(target);
        } else if (target.classList.contains('venueTitle')) {
          filterVenue(target);
          filterShow(true);
          filterFill(target);
        } else if (target.classList.contains('monthYear')) {
          filterMonth(target);
          filterShow(true);
          filterFill(target);
        } else if (target.classList.contains('recent')) {
          filterRecent();
          filterShow(true);
          filterFill(target);
        } else if (target.classList.contains('reset')) {
          showAll();
          filterShow(false);
        }
      }
      noEventsCheck() === true ? noEventsDisplay(true) : noEventsDisplay(false) 
    })
  }

  return { pageInit }

})();

//When page is loaded
document.addEventListener('turbolinks:load', function() {
  DOMLogic.pageInit();
})
