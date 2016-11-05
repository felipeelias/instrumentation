function updateChart(chart, data) {
  var values = data.map(function(value) { return value[1] });
  var labels = data.map(function(value) { return value[0] });

  chart.data.labels = labels;
  chart.data.datasets[0].data = values;
  chart.update();
}

function formatBytes(bytes) {
  if (bytes <= 1024) {
    return bytes.toString().concat("B");
  } else if (bytes > 1024 && bytes <= 1000*1024) {
    return (bytes / 1024).toFixed(1).toString().concat("MB");
  } else {
    return (bytes / 1024 / 1024).toFixed(1).toString().concat("GB");
  }
}

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

var lastMemory = document.getElementById('last-memory');
var lastLoadavg = document.getElementById('last-loadavg');

var socket = new WebSocket("ws://localhost:8080/");
socket.onmessage = function (raw_event) {
  var event = JSON.parse(raw_event.data)

  switch (event.data_type) {
    case 'memory':
      updateChart(memoryChart, event.data)
      lastMemory.textContent = formatBytes(event.data[event.data.length - 1][1]);
      break;
    case 'loadavg':
      updateChart(loadavgChart, event.data)
      lastLoadavg.textContent = event.data[event.data.length - 1][1];
      break;
    default:
      break;
  }
}
