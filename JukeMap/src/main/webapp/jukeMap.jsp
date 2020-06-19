<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Welcome JukeMap</title>
<link rel="stylesheet" href="resources/css/scroll.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link href="resources/fontawesome/css/all.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.21/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" type="text/css" href="resources/css/toast.css">
<link rel="icon" type="image/png" href="resources/images/icons/favicon.ico"/>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<script defer src="resources/fontawesome/js/all.js"></script>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
<script src="//cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="//cdn.datatables.net/1.10.21/js/dataTables.bootstrap4.min.js"></script>
<script>
	$(document).ready(function(){
		$("#myTable").DataTable({
			searching: false,
			lengthChange:false,
			info:false,
			paging:false
		});
		$("#communityTable").DataTable({
			searching: false,
			lengthChange:false,
			info:false,
			paging:false
		});
		$("#bookmarkTable").DataTable({
			searching: false,
			lengthChange:false,
			info:false,
			paging:false
		});
	});
</script>

<script>
	var audio = new Audio("music/1.mp3");
	var audioSeq;
	function audioPlay(){
		audio.src = "music/" + audioSeq + ".mp3";
		audio.play();
	}
	function audioMapPlay(seq){
		audio.src = "music/" + seq + ".mp3";
		audio.play();
	}
</script>

<!-- WebSocket - Community 기능 -->
<script>
	function isMobile(){
	var UserAgent = navigator.userAgent;
		if (UserAgent.match(/iPad|iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null)
		{
			return true;
		}else{
			return false;
		}
	}
	function showToast(msg){
		var toast = document.getElementById('toastMsg');
		toast.innerHTML = msg;
		var isToastShown = false;
		if (isToastShown) return;
		isToastShown = true;
		toast.classList.add('show');
		setTimeout(function(){
			toast.classList.remove('show');
			isToastShown = false;
		}, 2700);
	}
	var webSocket;
	
	// 프로토콜 확인에 따른 웹소켓 요청형태
	if( window.location.protocol == 'http:'){
		alert('HTTP에서는 위치서비스가 제공되지 않습니다.')
		alert(window.location.host);
		webSocket = new WebSocket('ws://' + window.location.host + '/jukemap/community.do');
	} else {
		webSocket = new WebSocket('wss://' + window.location.host + '/jukemap/community.do');
	}
	
	if(isMobile() && window.location.protocol == 'http:'){
		alert("Mobile: Community Mode");
	}
	
	var id = '${user.id}';
	
	// 웹소켓 관련 작업
    webSocket.onopen = function(event) {
        onOpen(event)
    };
    webSocket.onclose = function(event) {
        onClose(event)
    };
    webSocket.onerror = function(event) {
        onError(event)
    };
    webSocket.onmessage = function(event) {
        onMessage(event)
    };
    function onMessage(event) {
		//alert(event.data);
		
		var message = event.data.split("|");
        var messageType = message[0];
        var seq = message[1];
        
        if(messageType == "onlikey"){
        	//alert("onlikey 들옴");
        	var lseq = message[2];
        	$("#jukeLike-"+seq).html(parseInt($("#jukeLike-"+seq).html()) + 1);
        	$("#likeyBtn-"+seq).removeAttr("onclick");
        	$("#likeyBtn-"+seq).attr("onclick","offLikey("+lseq+")");
        	$("#likeyBtn-"+seq).html("<i class='fas fa-heart fa-2x'></i>");
        	showToast('좋아요가 반영되었습니다.');
        } 
        else if(messageType == "offlikey"){
        	//alert("offlikey 들옴");
        	$("#jukeLike-"+seq).html(parseInt($("#jukeLike-"+seq).html()) - 1);
        	$("#likeyBtn-"+seq).removeAttr("onclick");
        	$("#likeyBtn-"+seq).attr("onclick","onLikey("+seq+")");
        	$("#likeyBtn-"+seq).html("<i class='far fa-heart fa-2x'></i>");
        	showToast('좋아요가 취소되었습니다.');
        }
        else if(messageType == "onbookmark"){
        	//alert("onbookmark 들옴");
        	
        	var jseq = message[1];
        	var bmseq = message[2];
        	var title = message[3];
        	var writer = message[4];
        	var content = message[5];
        	var likey = message[6];
        	var lat = message[7];
        	var lon = message[8];
        	
        	
        	$("#bookmarkBtn-"+seq).removeAttr("onclick");
        	$("#bookmarkBtn-"+seq).attr("onclick","offBookmark("+bmseq+")");
        	$("#bookmarkBtn-"+seq).html("<i class='fas fa-bookmark fa-2x'></i>");
        	
            var newRow = $('#bookmarkTable').DataTable().row.add([
            	bmseq,
            	title,
            	writer,
            	likey,
            	'<a href="#" data-toggle="modal" data-target="#boardDetail" style="color: black;" onclick="boardDetail(\'' +
        		jseq + '\',\'' + title + '\',\'' + writer + '\',\'' + content + '\',\'' + lat + '\',\'' + 
        		lon + '\')"><i class="far fa-file-alt fa-2x"></i></a> ' +
        		'<a href="#" style="color: black;" onclick="changeCenter(\'' + lat + '\',\'' + lon + '\'' +
        		')"><i class="fas fa-map-marker fa-2x"></i></a>'
            ]).draw(false).node();
            $(newRow).attr("id","bookmarkTr-" + bmseq);
            showToast('북마크 목록에 저장했습니다.');
        }
        else if(messageType == "offbookmark"){
        	//alert("offbookmark 들옴");
        	var bmseq = message[2];
        	$("#bookmarkBtn-"+seq).removeAttr("onclick");
        	$("#bookmarkBtn-"+seq).attr("onclick","onBookmark(+"+seq+")");
        	$("#bookmarkBtn-"+seq).html("<i class='far fa-bookmark fa-2x'></i>");
        	
        	$("#bookmarkTable").DataTable().row('#bookmarkTr-' + bmseq).remove().draw(false);
        	showToast('북마크 목록에서 삭제했습니다.');
        }
    };
    function onOpen(event) {
    };
    function onClose(event) {
    };
    function onError(event) {
    };
    
    function onLikey(seq){
    	webSocket.send("onlikey|" + seq + "|" + id);
    };
    function offLikey(seq){
    	webSocket.send("offlikey|" + seq);
    };
    function onBookmark(seq){
    	webSocket.send("onbookmark|" + seq + "|" + id);
    };
    function offBookmark(seq){
    	webSocket.send("offbookmark|" + seq);
    };
    function fileNameChange(){
    	var fileValue = $("#musicFile").val().split("\\");
    	var fileName = fileValue[fileValue.length-1];
    	$("#fileNameLabel").html(fileName);
    }
    
    // 종료시 웹소켓 정상 종료 처리
    function logout(){
    	webSocket.close();
    	location.href='logout.do';
    }
    function reload(){
    	webSocket.close();
    	location.href='jukeMap.do';
    }
    function insertJuke(){
    	webSocket.close();
    	newMarker.submit();
    }
    window.onunload = function() {
        webSocket.close();
  	}
    function jukeDisLoad(){
    	 navigator.geolocation.getCurrentPosition(function(position) {
    	        var lat = position.coords.latitude, // 위도
    	            lon = position.coords.longitude; // 경도
    	       
    	            document.getElementsByName('lat')[0].value = lat;
    	            document.getElementsByName('lon')[0].value = lon;
    	            
    	            jukeMapDis.submit();
    	      });
    }
</script>

<div id="toastMsg"></div>

<nav class="navbar navbar-dark bg-primary">
	<a class="navbar-brand" href="#"><font size="5px" style="font-family: 'Nanum Pen Script', cursive;">From JukeMap, 당신의 감성을 응원합니다:)</font></a>
	<div class="btn-group" role="group" aria-label="Basic example">
		<button type="button" class="btn btn-primary" onclick="audio.play()"><i class="fas fa-play"></i></button>
		<button type="button" class="btn btn-primary" onclick="audio.pause()"><i class="fas fa-pause"></i></button>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#jukeAdd"><i class="fas fa-plus"></i></button>
		<button type="button" class="btn btn-primary" onclick="reload()"><i class="fas fa-redo-alt"></i></button>
		<button type="button" class="btn btn-primary" onclick="jukeDisLoad()"><i class="fas fa-street-view"></i></button>
		<button type="button" class="btn btn-primary" onclick="logout()"><i class="fas fa-power-off"></i></button>
	</div>
</nav>

<!-- jukeDisForm -->
<form action="jukeMapDis.do" method="post" name="jukeMapDis">
	<input type="hidden" name="lat"/>
	<input type="hidden" name="lon"/>
</form>

<!-- 지도 -->
<div id="map" style="width:100%;height:350px;"></div>

<!-- My JukeMapList -->
<div class="col-xs-8 col-xs-offset-2 well">
	<table id="myTable" class="table table-scroll">
        <thead class="thead-light">
            <tr>
                <th>My Music Title</th>
                <th>My Music RegDate</th>
                <th>My Music Likey</th>
                <th>My Music ContentDetail</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${ujukeList }" var="ujuke">
        <tr>
        	<td>${ujuke.title }</td>
        	<td>${ujuke.id }</td>
        	<td>${ujuke.likey }</td>
        	<td>
                <a href="#" data-toggle="modal" data-target="#boardDetail" style="color: black;" onclick="boardDetail('${ujuke.jseq }','${ujuke.title }','${ujuke.id }','${ujuke.content}','${ujuke.lat }','${ujuke.lon }')"><i class="far fa-file-alt fa-2x"></i></a>
            	<a href="#" style="color: black;" onclick="changeCenter('${ujuke.lat }','${ujuke.lon }')"><i class="fas fa-map-marker fa-2x"></i></a>
            </td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<!-- nav -->
<nav>
  <div class="nav nav-tabs" id="nav-tab" role="tablist">
    <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">All</a>
    <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Bookmark</a>
  </div>
</nav>
<!-- JukeMap Like List -->
<div class="tab-content col-xs-8 col-xs-offset-2 well" id="nav-tabContent">
	<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
    <table id="communityTable" class="table table-scroll">
        <thead class="thead-light">
            <tr>
            	<th>seq</th>
            	<c:if test="${mode ne '' and !empty mode and mode ne null}">
	        	<th>dis</th>
				</c:if>
                <th>Title</th>
                <th>Writer</th>
                <th>Likey</th>
                <th>Community</th>
            </tr>
        </thead>
        <tbody>
        <c:set var="bmNum" value="0"/>
        <c:set var="lNum" value="0"/>
        <c:forEach items="${jukeList }" var="juke">
        <tr>
        	<td>${juke.jseq }</td>
        	<c:if test="${juke.dis ne '' and !empty juke.dis and juke.dis ne null}">
        	<td><fmt:formatNumber value="${juke.dis }" pattern=".000"/></td>
			</c:if>
        	<td>${juke.title }</td>
        	<td>${juke.id }</td>
        	<td id="jukeLike-${juke.jseq }">${juke.likey }</td>
        	<td>
        	<c:choose>
        		<c:when test="${juke.jseq eq bmList[bmNum].jseq }">
        			<a id="bookmarkBtn-${juke.jseq }" href="#" style="color: black;" onclick="offBookmark(${bmList[bmNum].bmseq})"><i class="fas fa-bookmark fa-2x"></i></a>
        			<c:set var="bmNum" value="${bmNum + 1 }"/>
        		</c:when>
        		<c:otherwise>
        			<a id="bookmarkBtn-${juke.jseq }" href="#" style="color: black;" onclick="onBookmark(${juke.jseq})"><i class="far fa-bookmark fa-2x"></i></a>
        		</c:otherwise>
        	</c:choose>
        	<c:choose>
        		<c:when test="${juke.jseq eq likeyList[lNum].jseq }">
        			<a id="likeyBtn-${juke.jseq }" href="#" style="color: black;" onclick="offLikey(${likeyList[lNum].lseq})"><i class="fas fa-heart fa-2x"></i></a>
        			<c:set var="lNum" value="${lNum + 1 }"/>
        		</c:when>
        		<c:otherwise>
        			<a id="likeyBtn-${juke.jseq }" href="#" style="color: black;" onclick="onLikey(${juke.jseq})"><i class="far fa-heart fa-2x"></i></a>
        		</c:otherwise>
        	</c:choose>
                <a href="#" data-toggle="modal" data-target="#boardDetail" style="color: black;" onclick="boardDetail('${juke.jseq }','${juke.title }','${juke.id }','${juke.content}','${juke.lat }','${juke.lon }')"><i class="far fa-file-alt fa-2x"></i></a>
                <a href="#" style="color: black;" onclick="changeCenter('${juke.lat }','${juke.lon }')"><i class="fas fa-map-marker fa-2x"></i></a>
            </td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
    </div>
    <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
		<table id="bookmarkTable" class="table table-scroll">
        <thead class="thead-light">
            <tr>
            	<th>seq</th>
                <th>Title</th>
                <th>Writer</th>
                <th>Likey</th>
                <th>Community</th>
            </tr>
        </thead>
        <tbody id="bookmarkBody">
        <c:forEach items="${jbmList }" var="jbm">
        <tr id="bookmarkTr-${jbm.jseq }">
        	<td>${jbm.jseq }</td>
        	<td>${jbm.title }</td>
        	<td>${jbm.id }</td>
        	<td>${jbm.likey }</td>
        	<td>
                <a href="#" data-toggle="modal" data-target="#boardDetail" style="color: black;" onclick="boardDetail('${jbm.jseq }','${jbm.title }','${jbm.id }','${jbm.content}','${jbm.lat }','${jbm.lon }')"><i class="far fa-file-alt fa-2x"></i></a>
            	<a href="#" style="color: black;" onclick="changeCenter('${jbm.lat }','${jbm.lon }')"><i class="fas fa-map-marker fa-2x"></i></a>
            </td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
	</div>
</div>

<!-- BootStrap Modal -->
<!-- Board Detail -->
<div class="modal fade" id="boardDetail" tabindex="-1" role="dialog" aria-labelledby="boardDetail" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="boardDetailTitle"></h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form name="marker" method="post" enctype="multipart/form-data">
	          <div class="form-group">
	            <label for="recipient-name"  class="col-form-label">ID:</label>
	            <input type="text" class="form-control" id="boardDetailId" readonly="readonly">
	          </div>
	          <div class="form-group">
	            <label for="message-text"  class="col-form-label">Content:</label>
	            <textarea class="form-control" id="boardDetailContent" readonly="readonly"></textarea>
	          </div>
	          <div class="form-group">
	            <label for="recipient-name"  class="col-form-label">Address:</label>
	            <input type="text" class="form-control" id="boardDetailAddress" readonly="readonly">
	          </div>
	        </form>
	      </div>
      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" id="musicBtn" class="btn btn-primary" onclick="audioPlay()" >Music Start</button>
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
        <form name="newMarker" method="post" action="jukeMarkerAdd_proc.do" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${user.id }"/>
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
			    <input type="file" id="musicFile" name="musicFile" class="custom-file-input" id="inputGroupFile02" onchange="fileNameChange()" accept="audio/mp3" required="required">
			    <label id="fileNameLabel" class="custom-file-label" for="inputGroupFile02">Choose file</label>
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
        <button type="button" class="btn btn-primary" onclick="insertJuke()">Register Marker</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e5bf3a2fe6fdda87dfe4d15dea3351e4&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨 
    }; 

//지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 
// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {
    
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
        
        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
        
        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
            message = '<div style="padding:5px;">현재 위치</div>'; // 인포윈도우에 표시될 내용입니다
        
        // 마커와 인포윈도우를 표시합니다
        displayMarker(locPosition, message);
            
      });
    
} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation을 사용할수 없어요..'
        
    displayMarker(locPosition, message);
}
// 지도에 마커와 인포윈도우를 표시하는 함수입니다
function displayMarker(locPosition, message) {

    // 마커를 생성합니다
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
    	alert('위도 - ' + marker.getPosition().getLat() + ' 경도 - ' + marker.getPosition().getLng());
    });
    
    var iwContent = message, // 인포윈도우에 표시할 내용
        iwRemoveable = true;

    // 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({
        content : iwContent,
        removable : iwRemoveable
    });
    
    // 인포윈도우를 마커위에 표시합니다 
    infowindow.open(map, marker);
    
    // 지도 중심좌표를 접속위치로 변경합니다
    map.setCenter(locPosition);      
}

</script>
<!-- MapMarker -->
<script>
	<c:forEach items="${jukeList }" var="juke">
	navigator.geolocation.getCurrentPosition(function(position) {
	   	// 마커 생성
	   var lat = ${juke.lat }, // 위도
	       lon = ${juke.lon}; // 경도
	       
	   var locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	        
	   var marker = new kakao.maps.Marker({  
	       map: map, 
	       position: locPosition
	   });
	   
	   marker.setMap(map);
	   
	   var jseq = ${juke.jseq};
	   var content = "${juke.content}";
	   // 마커에 이벤트 등록
	   // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다 
	   var iwContent = '<div style="padding:15px; width:250px; overflow:hidden; word-break:break-all;">' + content + '<br/>' + 
	   		'<button type="button" class="btn btn-primary" onclick="window.open(\'https://map.kakao.com/link/to/' + content + ',' + lat + ',' + lon + '\')"><i class="fas fa-route"></i></button>' + 
	   		'<button type="button" class="btn btn-primary" onclick="audioMapPlay(' + jseq + ')"><i class="fas fa-play"></i></button>' + 
	   		'</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
       iwRemoveable = true; // removeable 속성을 true 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
		   // 인포윈도우를 생성합니다
	   var infowindow = new kakao.maps.InfoWindow({
		       content : iwContent,
       		removable : iwRemoveable
	   });
		   // 마커에 클릭이벤트를 등록합니다
	   kakao.maps.event.addListener(marker, 'click', function() {
	         // 마커 위에 인포윈도우를 표시합니다
	         infowindow.open(map, marker);  
	   });
	});
	</c:forEach>
	function boardDetail(seq,title,id,content,lat,lon){
    	$("#boardDetailTitle").html(title);
    	$("#boardDetailId").val(id);
    	$("#boardDetailContent").val(content);
    	geocoder.coord2Address(lon, lat, function(result, status){
    		$("#boardDetailAddress").val(result[0].address.address_name);
    	});
    	audioSeq = seq;
    }
	
	function changeCenter(lat,lng){
		map.setCenter(new kakao.maps.LatLng(lat, lng));
		showToast('중심좌표를 변경했습니다.');
	}
</script>
</body>
</html>