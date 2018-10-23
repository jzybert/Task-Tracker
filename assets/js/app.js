// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import jQuery from 'jquery';
window.jQuery = window.$ = jQuery; // Bootstrap requires a global "$" object.
import "bootstrap";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
$(() => {
  $('#add-time-button').click(event => {
    let timestampIntervals = $('#add-time-text-area').val();
    let taskID = $(event.target).data('task-id');
    let timeList = timestampIntervals.split(";").map(str => {
      return str.replace("(", "").replace(")", "");
    });
    let splitList = timeList.map(time => {
      return time.split(",");
    });
    let removeList = splitList.filter(time => {
      return time.length === 2;
    });
    let dateList = removeList.map(dateList => {
      return dateList.map(dateString => {
        return new Date(dateString);
      });
    });

    function datetimeConverter(dt) {
      return {
        "year": dt.getFullYear(),
        "month": dt.getMonth(),
        "day": dt.getDate(),
        "hour": dt.getHours(),
        "minute": dt.getMinutes(),
        "second": dt.getSeconds()
      }
    }

    for (let ii = 0; ii < dateList.length; ii++) {
      let dateInterval = dateList[ii];
      let text = JSON.stringify({
        time_block: {
          task_id: taskID,
          start_time: datetimeConverter(dateInterval[0]),
          end_time: datetimeConverter(dateInterval[1])
        }
      });

      $.ajax('/ajax/time_blocks', {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: text,
        success: response => {
          console.log(response);
        }
      });
    }

    $('#task-edit-save-button').click();
  });
});