Chart.defaults.global.defaultFontSize = 8;
Chart.defaults.global.animation.duration = 500;
Chart.defaults.global.legend.display = false;
Chart.defaults.global.elements.line.backgroundColor = "rgba(0,0,0,0)";
Chart.defaults.global.elements.line.borderColor = "rgba(0,0,0,0.9)";
Chart.defaults.global.elements.line.borderWidth = 2;

var defaultOptions = {
  type: 'line',
  data: {
    labels: [],
    datasets: [{
      label: '',
      data: [],
      lineTension: 0.2,
      pointRadius: 0
    }]
  },
  options: {
    scales: {
      yAxes: [{
        ticks: {
          beginAtZero:true
        }
      }],
      xAxes: [{
        type: 'time',
        time: {
          unitStepSize: 110
        },
        minUnit: 'second',
        gridLines: {
          display: false
        }
      }]
    }
  },
  tooltips: {
    enabled: false
  },
  responsive: true,
  maintainAspectRatio: false,
  animation: false
}

var memoryChart = new Chart(document.getElementById('memory'), defaultOptions);
var loadavgChart = new Chart(document.getElementById('loadavg'), defaultOptions);

var socket = new WebSocket("ws://localhost:8080/");
socket.onmessage = function (raw_event) {
  var event = JSON.parse(raw_event.data)

  switch (event.data_type) {
    case 'memory':
      var mem = event.data.map(function(v) { return v[1] });
      var counts = event.data.map(function(v) { return v[0] });

      memoryChart.data.labels = counts
      memoryChart.data.datasets[0].data = mem
      memoryChart.update()

      break;
    case 'loadavg':
      var mem = event.data.map(function(v) { return v[1] });
      var counts = event.data.map(function(v) { return v[0] });

      loadavgChart.data.labels = counts
      loadavgChart.data.datasets[0].data = mem
      loadavgChart.update()

      break;
    default:
      break;
  }
}
