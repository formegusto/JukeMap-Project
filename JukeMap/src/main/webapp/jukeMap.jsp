<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Welcome JukeMap</title>
<link rel="stylesheet" href="resources/css/scroll.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link href="resources/fontawesome/css/all.css" rel="stylesheet">
<script defer src="resources/fontawesome/js/all.js"></script>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
<script>
	var audio = new Audio("music/1.mp3");
	function changeAudio(){
		if(audio.src == 'https://localhost:8443/jukemap/music/2.mp3'){
			audio.src = "music/1.mp3";
		} 
		else {
			audio.src = "music/2.mp3";
		}
		alert(audio.src);
	}
</script>

<nav class="navbar navbar-dark bg-primary">
	<a class="navbar-brand" href="#">JukeMap</a>
	<div class="btn-group" role="group" aria-label="Basic example">
		<button type="button" class="btn btn-primary" onclick="audio.play()"><i class="fas fa-play"></i></button>
		<button type="button" class="btn btn-primary" onclick="audio.pause()"><i class="fas fa-pause"></i></button>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#jukeAdd"><i class="fas fa-plus"></i></button>
		<button type="button" class="btn btn-primary" onclick="changeAudio()">Change</button>
	</div>
</nav>

<!-- ���� -->
<div id="map" style="width:100%;height:350px;"></div>

<!-- My JukeMapList -->
<div class="col-xs-8 col-xs-offset-2 well">
    <table class="table table-scroll">
        <thead class="thead-dark">
            <tr>
                <th>My Music Title</th>
                <th>My Music RegDate</th>
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
        <c:forEach items="${jukeList }" var="juke">
        <tr>
        	<td>${juke.title }</td>
        	<td>${juke.id }</td>
        	<td>${juke.likey }</td>
        	<td>
                <a href="#" style="color: black;"><i class="far fa-bookmark fa-2x"></i></a>
                <a href="#" style="color: black;"><i class="far fa-heart fa-2x"></i></a>
                <a href="#" data-toggle="modal" data-target="#boardDetail" style="color: black;"><i class="far fa-file-alt fa-2x"></i></a>
            </td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- BootStrap Modal -->
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

<!-- jukeAdd -->
<div class="modal fade" id="jukeAdd" tabindex="-1" role="dialog" aria-labelledby="jukeAdd" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">New JukeMarker</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form name="marker" method="post" action="jukeMarkerAdd_proc.do" enctype="multipart/form-data">
          <div class="form-group">
            <label for="recipient-name"  class="col-form-label">Title:</label>
            <input type="text" name="title" class="form-control" id="recipient-name">
          </div>
          <div class="form-group">
            <label for="message-text"  class="col-form-label">Content:</label>
            <textarea class="form-control" name="content" id="message-text"></textarea>
          </div>
          <div class="form-group">
			  <div class="custom-file">
			    <input type="file" name="musicFile" class="custom-file-input" id="inputGroupFile02">
			    <label class="custom-file-label" for="inputGroupFile02">Choose file</label>
			  </div>
			</div>
          <div class="form-row">
		    <div class="col">
		      <input type="text" id="lat" name="lat" class="form-control" readonly="readonly">
		    </div>
		    <div class="col">
		      <input type="text" id="lon" name="lon" class="form-control" readonly="readonly">
		    </div>
		  </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="marker.submit()">Registe Marker</button>
      </div>
    </div>
  </div>
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
            message = '<div style="padding:5px;">���� ��ġ</div>'; // ���������쿡 ǥ�õ� �����Դϴ�
        
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
    
    marker.setDraggable(true); 
    document.getElementById("lat").value = marker.getPosition().getLat();
	document.getElementById("lon").value = marker.getPosition().getLng();
    
    kakao.maps.event.addListener(marker, 'dragend', function(){
    	document.getElementById("lat").value = marker.getPosition().getLat();
    	document.getElementById("lon").value = marker.getPosition().getLng();
    	alert('���� - ' + marker.getPosition().getLat() + ' �浵 - ' + marker.getPosition().getLng());
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

<script>
	<c:forEach items="${jukeList }" var="juke">
		navigator.geolocation.getCurrentPosition(function(position) {
		        
		        var lat = ${juke.lat }, // ����
		            lon = ${juke.lon}; // �浵
		        
		        var locPosition = new kakao.maps.LatLng(lat, lon); // ��Ŀ�� ǥ�õ� ��ġ�� geolocation���� ���� ��ǥ�� �����մϴ�
		        
		        var marker = new kakao.maps.Marker({  
			        map: map, 
			        position: locPosition
			    });
		        
		        marker.setMap(map);
		});
		
	</c:forEach>
</script>
</body>
</html>