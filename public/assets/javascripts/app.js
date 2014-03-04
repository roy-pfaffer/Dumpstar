$(document).ready(function() {
  // configuring refreshUrl
  var refreshRate = 5;
  var sortKey = 'retweets';
  var dateRange = '15';
  var lastId = 0;
  var baseUrl = '/programs/' + programId + '/';
  var refreshUrl = function() {
    return baseUrl + 'stream?date_range=' + dateRange + '&last_id=' + lastId;
  };

  // poll the server for activities
  var getActivities = function() {
    console.log('sending message to server for latest info');
    $.ajax({
      url: refreshUrl(),
      success: function(data) { renderActivities(data) },
      failure: function() { console.log('failure =(') }
    });
  };
  getActivities();
  setInterval(getActivities, refreshRate * 1000);

  //template
  var template = _.template('\
    <div class="activity-item">\
      <div style="display:inline-block"><img src="<%= activity["body"]["actor"]["image"] %>"></div>\
      <div style="display:inline-block">\
        <a href="<%= activity["body"]["actor"]["link"] %>"><%= activity["body"]["actor"]["displayName"] %></a> - <%= activity["body"]["actor"]["followersCount"] %> followers.  <a href="' + baseUrl + 'activities/<%= activity["id"] %>/create_action">Create Action</a>\
        <p><%= activity["body"]["body"] %><br>Retweeted <%= activity["body"]["retweetCount"] %> times.</p>\
      </div>\
    </div>\
  ');

  // rendering activities
  var renderActivities = function(activities) {
    if (activities.length > 0) { lastId = activities[0].id }

    var $activitiesContainer = $('.master-stream');
    _.each(activities, function(activity) {
      var params = { activity: activity };
      $activitiesContainer.prepend(template(params)).hide().fadeIn('slow');
    });
  };
});
