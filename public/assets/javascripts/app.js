$(document).ready(function() {
  // configuring refreshUrl
  var baseUrl = '/programs/' + programId + '/';

  var settings = {
    refreshRate: 5,
    lastId: 0,
    limit: 30,
    sortKey: '',
    dateRange: 15
  };

  var refreshUrl = function(params) {
    return baseUrl + 'stream?last_id=' + settings.lastId
      + (settings.dateRange ? '&date_range=' + settings.dateRange : '')
      + (settings.limit ? '&limit=' + settings.limit : '')
      + (settings.sortKey ? '&sort_key=' + settings.sortKey : '');
  };

  // poll the server for activities
  var getActivities = function() {
    console.log('getting activities from server');
    $.ajax({
      url: refreshUrl(),
      success: function(data) { renderActivities(data) },
      failure: function() { console.log('failure =(') }
    });
  };

  //template
  var template = _.template('\
    <div class="activity-item-container">\
      <div class="activity-item">\
        <div class="avatar"><img src="<%= activity["body"]["actor"]["image"] %>"></div>\
        <div class="body">\
          <a class="bolded" target="blank" href="<%= activity["body"]["actor"]["link"] %>"><%= activity["body"]["actor"]["displayName"] %></a> - <a target="blank" href="<%= activity["body"]["link"] %>"><%= activity["body"]["link"] %></a>\
          <p><%= activity["body"]["body"] %><br><%= activity["body"]["retweetCount"] %> retweets, <%= activity["body"]["actor"]["followersCount"] %> followers.  <a class="create-action" data-id="<%= activity["id"] %>" href="#">Create Action</a></p>\
        </div>\
      </div>\
    </div>\
  ');

  // rendering activities
  var renderActivities = function(activities) {
    if (activities.length > 0) { settings.lastId = activities[activities.length - 1].id }
    var $activitiesContainer = $('.master-stream');
    _.each(activities, function(activity) {
      var params = { activity: activity };
      $activitiesContainer.prepend(template(params));
      $activitiesContainer.find('.activity-item-container').first().hide().slideDown('slow', function(){
        $(this).find('.activity-item').css('visibility','visible').hide().fadeIn('slow');
        $(this).find('.create-action').click(createAction);
      });
    });
  };

  // settings
  var pollingInterval;
  var submitSettings = function() {
    $(".master-stream").html('');
    var liveMode = modeSetting() == 'live';
    settings = _.extend(settings, {
      sortKey: liveMode ? '' : modeSetting(),
      dateRange: dateRangeSetting(),
      lastId: liveMode ? settings.lastId : 0
    });
    getActivities();
    clearInterval(pollingInterval);
    settings.lastId = 0;
    if (!settings.sortKey) { pollingInterval = setInterval(getActivities, settings.refreshRate * 1000); }
  };

  var modeSetting = function() { return $('.mode-setting .value.selected').text() };
  var colorSetting = function() { return $('.color-setting .value.selected').text() };
  var dateRangeSetting = function() { return $('.date-range-setting .value.selected').text() };

  var selectSetting = function(e) {
    $el = $(e.target);
    $el.parent().find('.value').removeClass('selected');
    $el.addClass('selected');
  };

  var createAction = function(e) {
    console.log('create action called');
    var activityId = $(e.target).data('id');
    if (confirm('Are you sure you want to create this action?')) {
      $.ajax({
        url: baseUrl + 'activities/' + activityId + '/create_action',
        success: function() { alert("Done!") },
        error: function() { alert("Oops, there was an error.") }
      });
    };
  };

  //events
  $(".settings .value").click(selectSetting);
  $("#settings-submit").click(submitSettings);

  //initialization
  getActivities();
  var pollingInterval = setInterval(getActivities, settings.refreshRate * 1000);
});
