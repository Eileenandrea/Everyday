import { timers } from "jquery"

console.log('my first JS code')

const alarm = document.getElementById('alarmAudio')
const timerOptions = document.querySelector('.timer-lists')
const timerString = document.querySelector('#timer-string')
const timerBtn = document.querySelector('#btn-time-action')
let activeTime = document.querySelector('.active-timer')
let time = activeTime.dataset.time;
timerString.innerHTML = `${Math.floor(time/60)}:${time%60 > 9 ? time%60 : '0' + time%60 }`

let countdowntimer
let pomodoroData = document.querySelector('#pomodoro-data')
console.log(pomodoroData);

let actualPomodoro = Number(pomodoroData.dataset.ap)
$.ajaxSetup({
    headers:
    { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') }
});
console.log(actualPomodoro);
timerBtn.addEventListener('click', function () {

  
    if (timerBtn.dataset.action == 'start') {
        timerBtn.dataset.action = 'stop'
        timerBtn.innerHTML = 'Stop'
        countdowntimer = setInterval(countdown,1000)
    }else    if (timerBtn.dataset.action == 'stop') {
        timerBtn.dataset.action = 'start'
        timerBtn.innerHTML = 'Start'
        clearInterval(countdowntimer)
    }
})

timerOptions.addEventListener('click', function (e) {
    let taskTimer = e.target.closest(".timer-list")
    if (timerBtn.dataset.action == 'stop') {
        let changeConfirm = confirm('The timer is still running, are you sure you want to switch?')
        if (changeConfirm) {
            clearInterval(countdowntimer);
            timerBtn.dataset.action = 'start'
            timerBtn.innerHTML = 'Start'
            time = taskTimer.dataset.time;
            timerString.innerHTML = `${Math.floor(time/60)}:${time%60 > 9 ? time%60 : '0' + time%60 }`
        }
    } else {
        activeTime = document.querySelector('.active-timer')
        activeTime.classList.remove('active-timer')
        e.target.closest('.btn-timer').classList.add('active-timer')
        time = taskTimer.dataset.time;
        timerString.innerHTML = `${Math.floor(time/60)}:${time%60 > 9 ? time%60 : '0' + time%60 }`
    
    }
   
  
  
})


function countdown() {
    if (time == 0) {
        alarm.play();
        alert('Time is up')
        clearInterval(countdowntimer)
        console.log(activeTime.id);
        activeTime = document.querySelector('.active-timer')
        if (activeTime.id == 'pomodoro-timer') {
            console.log('yes');
            actualPomodoro++;
            console.log(actualPomodoro);
            $.ajax({
                url: window.location.href,
                type: "PATCH",
                data: {task: { actual_pomodoro: actualPomodoro, break: true} },
            })
        }
        else {
            $.ajax({
                url: window.location.href,
                type: "PATCH",
                data: {task: { break: false} },
            })
        }
        timerBtn.dataset.action = 'start'
        timerBtn.innerHTML = 'Start'
        clearInterval(countdowntimer)
    }
    time--;
    timerString.innerHTML = `${Math.floor(time/60)}:${time%60 > 9 ? time%60 : '0' + time%60 }`

}
console.log(window.location.href);