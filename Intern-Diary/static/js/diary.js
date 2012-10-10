var nextPage = $('#next-page').text();

var getPager = function (event) {
    var url = '/api.page/' + nextPage;

    if (nextPage > 1) {
        $.get(url).done(function (res) {
            for (var i = 0; i < res.data.length; ++i) {
                var data = res.data[i];

                var titleElement  = document.createElement('a');
                titleElement.href = '/diary/' + data.id;
                var titleText     = document.createTextNode(data.title);
                titleElement.appendChild(titleText);

                var bodyElement = document.createElement('div');
                var bodyText    = document.createTextNode(data.body);
                bodyElement.appendChild(bodyText);

                var diaryListContainer = document.getElementById('diary-list');
                diaryListContainer.appendChild(titleElement);   
                diaryListContainer.appendChild(bodyElement);
            }

            nextPage = res.pager.next || 0;
        });
    }
};

$(document).on('scroll', _.throttle(getPager, 1000));