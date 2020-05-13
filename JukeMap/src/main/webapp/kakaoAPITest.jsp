<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Welcome JukeMap</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link href="resources/fontawesome/css/all.css" rel="stylesheet">
<script defer src="resources/fontawesome/js/all.js"></script>
<style type="text/css">
.well {
    background: none;
    height: 320px;
}

.table-scroll tbody {
    position: absolute;
    overflow-y: scroll;
    height: 250px;
}

.table-scroll tr {
    width: 100%;
    table-layout: fixed;
    display: inline-table;
}

.table-scroll thead > tr > th {
    border: none;
}
</style>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
<script>
	var audio = new Audio();
	audio.src = "music/10cm-03-����Ʈ.mp3";
</script>

<nav class="navbar navbar-dark bg-primary">
	<a class="navbar-brand" href="#">JukeMap</a>
	<div class="btn-group" role="group" aria-label="Basic example">
		<button type="button" class="btn btn-primary" onclick="audio.play()"><i class="fas fa-play"></i></button>
		<button type="button" class="btn btn-primary" onclick="audio.pause()"><i class="fas fa-pause"></i></button>
		<button type="button" class="btn btn-primary"><i class="fas fa-plus"></i></button>
	</div>
<!--  
  <a class="navbar-brand" href="#">JukeMap</a>
  <audio src="music/10cm-03-����Ʈ.mp3" controls="controls">
  </audio>
-->
</nav>

<!-- ���� -->
<div id="map" style="width:100%;height:350px;"></div>

<!-- My JukeMapList -->
<div class="col-xs-8 col-xs-offset-2 well">
    <table class="table table-scroll">
        <thead class="thead-dark">
            <tr>
                <th>My Music Title</th>
                <th>My Music Content</th>
                <th>My Music Likey</th>
                <th>My Music ContentDetail</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>Andrew</td>
                <td>Jackson</td>
                <td>Washington</td>
            </tr>
            <tr>
                <td>2</td>
                <td>Thomas</td>
                <td>Marion</td>
                <td>Jackson</td>
            </tr>
            <tr>
                <td>3</td>
                <td>Benjamin</td>
                <td>Warren</td>
                <td>Lincoln</td>
            </tr>
            <tr>
                <td>4</td>
                <td>Grant</td>
                <td>Wayne</td>
                <td>Union</td>
            </tr>
            <tr>
                <td>5</td>
                <td>John</td>
                <td>Adams</td>
                <td>Marshall</td>
            </tr>
            <tr>
                <td>6</td>
                <td>Morgan</td>
                <td>Lee</td>
                <td>Lake</td>
            </tr>
            <tr>
                <td>7</td>
                <td>John</td>
                <td>Henry</td>
                <td>Brown</td>
            </tr>
            <tr>
                <td>8</td>
                <td>William</td>
                <td>Jacob</td>
                <td>Orange</td>
            </tr>
            <tr>
                <td>9</td>
                <td>Kelly</td>
                <td>Davidson</td>
                <td>Taylor</td>
            </tr>
            <tr>
                <td>10</td>
                <td>Colleen</td>
                <td>Hurst</td>
                <td>Randolph</td>
            </tr>
            <tr>
                <td>11</td>
                <td>Rhona</td>
                <td>Herrod</td>
                <td>Cumberland</td>
            </tr>
            <tr>
                <td>12</td>
                <td>Jane</td>
                <td>Paul</td>
                <td>Marshall</td>
            </tr>
            <tr>
                <td>13</td>
                <td>Ashton</td>
                <td>Fox</td>
                <td>Calhoun</td>
            </tr>
            <tr>
                <td>14</td>
                <td>Garrett</td>
                <td>John</td>
                <td>Madison</td>
            </tr>
            <tr>
                <td>15</td>
                <td>Fredie</td>
                <td>Winters</td>
                <td>Washington</td>
            </tr>
        </tbody>
    </table>
</div>

<!-- JukeMap Like List -->
<div class="col-xs-8 col-xs-offset-2 well">
    <table class="table table-scroll">
        <thead class="thead-light">
            <tr>
                <th>Title</th>
                <th>Writer</th>
                <th>Likey</th>
                <th>Community</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Title[1]</td>
                <td>Writer[1]</td>
                <td>100</td>
                <td>
                <a href="#" style="color: black;"><i class="far fa-bookmark fa-2x"></i></a>
                <a href="#" style="color: black;"><i class="far fa-heart fa-2x"></i></a>
                <a href="#" data-toggle="modal" data-target="#boardDetail" style="color: black;"><i class="far fa-file-alt fa-2x"></i></a>
                
                <!-- Board Detail -->
                <div class="modal fade" id="boardDetail" tabindex="-1" role="dialog" aria-labelledby="boardDetail" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				        ...
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				        <button type="button" class="btn btn-primary">Save changes</button>
				      </div>
				    </div>
				  </div>
				</div>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>Thomas</td>
                <td>Marion</td>
                <td>Jackson</td>
            </tr>
            <tr>
                <td>3</td>
                <td>Benjamin</td>
                <td>Warren</td>
                <td>Lincoln</td>
            </tr>
            <tr>
                <td>4</td>
                <td>Grant</td>
                <td>Wayne</td>
                <td>Union</td>
            </tr>
            <tr>
                <td>5</td>
                <td>John</td>
                <td>Adams</td>
                <td>Marshall</td>
            </tr>
            <tr>
                <td>6</td>
                <td>Morgan</td>
                <td>Lee</td>
                <td>Lake</td>
            </tr>
            <tr>
                <td>7</td>
                <td>John</td>
                <td>Henry</td>
                <td>Brown</td>
            </tr>
            <tr>
                <td>8</td>
                <td>William</td>
                <td>Jacob</td>
                <td>Orange</td>
            </tr>
            <tr>
                <td>9</td>
                <td>Kelly</td>
                <td>Davidson</td>
                <td>Taylor</td>
            </tr>
            <tr>
                <td>10</td>
                <td>Colleen</td>
                <td>Hurst</td>
                <td>Randolph</td>
            </tr>
            <tr>
                <td>11</td>
                <td>Rhona</td>
                <td>Herrod</td>
                <td>Cumberland</td>
            </tr>
            <tr>
                <td>12</td>
                <td>Jane</td>
                <td>Paul</td>
                <td>Marshall</td>
            </tr>
            <tr>
                <td>13</td>
                <td>Ashton</td>
                <td>Fox</td>
                <td>Calhoun</td>
            </tr>
            <tr>
                <td>14</td>
                <td>Garrett</td>
                <td>John</td>
                <td>Madison</td>
            </tr>
            <tr>
                <td>15</td>
                <td>Fredie</td>
                <td>Winters</td>
                <td>Washington</td>
            </tr>
        </tbody>
    </table>
</div>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e5bf3a2fe6fdda87dfe4d15dea3351e4"></script>
<script>
var mapContainer = document.getElementById('map'), // ������ ǥ���� div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // ������ �߽���ǥ
        level: 5 // ������ Ȯ�� ���� 
    }; 

var map = new kakao.maps.Map(mapContainer, mapOption); // ������ �����մϴ�

// HTML5�� geolocation���� ����� �� �ִ��� Ȯ���մϴ� 
if (navigator.geolocation) {
    
    // GeoLocation�� �̿��ؼ� ���� ��ġ�� ���ɴϴ�
    navigator.geolocation.getCurrentPosition(function(position) {
        
        var lat = position.coords.latitude, // ����
            lon = position.coords.longitude; // �浵
        
        var locPosition = new kakao.maps.LatLng(lat, lon), // ��Ŀ�� ǥ�õ� ��ġ�� geolocation���� ���� ��ǥ�� �����մϴ�
            message = '<div style="padding:5px;">���⿡ ��Ű���?!</div>'; // ���������쿡 ǥ�õ� �����Դϴ�
        
        // ��Ŀ�� ���������츦 ǥ���մϴ�
        displayMarker(locPosition, message);
            
      });
    
} else { // HTML5�� GeoLocation�� ����� �� ������ ��Ŀ ǥ�� ��ġ�� ���������� ������ �����մϴ�
    
    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation�� ����Ҽ� �����..'
        
    displayMarker(locPosition, message);
}

// ������ ��Ŀ�� ���������츦 ǥ���ϴ� �Լ��Դϴ�
function displayMarker(locPosition, message) {

    // ��Ŀ�� �����մϴ�
    var marker = new kakao.maps.Marker({  
        map: map, 
        position: locPosition
    }); 
    
    var iwContent = message, // ���������쿡 ǥ���� ����
        iwRemoveable = true;

    // ���������츦 �����մϴ�
    var infowindow = new kakao.maps.InfoWindow({
        content : iwContent,
        removable : iwRemoveable
    });
    
    // ���������츦 ��Ŀ���� ǥ���մϴ� 
    infowindow.open(map, marker);
    
    // ���� �߽���ǥ�� ������ġ�� �����մϴ�
    map.setCenter(locPosition);      
}    
</script>
</body>
</html>