<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="styles/codemirror.css">
<link rel="stylesheet" href="styles/codemirror-neo.css">
<link rel="stylesheet" href="styles/cy2neo.css">
<link rel="stylesheet" href="styles/neod3.css">
<link rel="stylesheet" href="styles/datatable.css">
<link rel="stylesheet" href="styles/vendor.css"> <!-- bootstrap -->
<link rel="stylesheet" href="styles/sweet-alert.css">
<link rel="stylesheet" href="styles/gh-fork-ribbon.css">
<link rel="stylesheet" href="styles/bootstrap-select.css">

<!-- <script src="js/jquery-3.3.1.min.js"></script> -->
<script src="js/codemirror.js"></script>
<script src="js/codemirror-cypher.js"></script>
<script src="js/vendor.js"></script>
<script src="js/sweet-alert.min.js"></script>
<script src="js/neod3.js"></script>
<script src="js/neod3-visualization.js"></script>
<script src="js/neo4d3.js"></script>
<script src="js/cy2neod3.js"></script>
<script src="js/jquery.dataTables.min.js"></script>
<script src="js/cypher.datatable.js"></script>
<script src="js/bootstrap-select.js"></script>

</head>
<body>

<div style="display:none;">
	<input class="form-control" type="url" value="http://localhost:7474" id="neo4jUrl"/><br/>
	<input class="form-control" type="text" size="8" value="neo4j" id="neo4jUser"/>
	<input class="form-control" type="password" size="8" placeholder="password" value="neo4j!@" id="neo4jPass"/><br/>
	<textarea name="cypher" id="cypher" rows="4" cols="120" data-lang="cypher" class="code form-control">
		MATCH (n)
		RETURN n
		LIMIT 100;
	</textarea>
</div>

<div role="form" style="margin-top: 10px;">
	<div class="col-lg-offset-4 col-lg-2 form-group">
		<select id="selectId" class="selectpicker show-menu-arrow form-control">
			<option>연구원</option>
			<option>논문</option>
		</select>
	</div>
	<div class="col-lg-2 form-group">
		<input type="text" size="10" id="inputId" class="form-control">
	</div>
	<div class="col-lg-1 form-group" style="text-align: left;">
		<a href="#" title="Execute" id="execute"><i class="fa fa-play-circle-o"></i></a>
	</div>
</div>

<div role="tabpanel">

    <!-- Nav tabs -->
<!-- 	<ul class="nav nav-tabs" role="tablist"> -->
<!-- 	  <li role="presentation" class="active"><a href="#graph" aria-controls="home" role="tab" data-toggle="tab">Graph</a></li> -->
<!-- 	  <li role="presentation"><a href="#table" aria-controls="table" role="tab" data-toggle="tab">Table</a></li> -->
<!-- 	</ul> -->

	<!-- Tab panes -->
	<div class="tab-content">
		<div role="tabpanel" style="height: 800px" class="tab-pane active" id="graph">
			<div class="tab-pane active" id="graph">&nbsp;</div>
		</div>
<!-- 		<div role="tabpanel" class="tab-pane" id="table"> -->
<!-- 	  		<div id="datatable"></div> -->
<!-- 		</div> -->
	</div>

</div>
	
	
<script>

$(function(){
	//todo dynamic configuration
	var config = {}
    var connection = function() { return {url:$("#neo4jUrl").val(), user:$("#neo4jUser").val(),pass:$("#neo4jPass").val()}; }
	new Cy2NeoD3(config,"graph","datatable","cypher","execute", connection , true);
	$("#execute").trigger("click");
});

</script>
</body>
</html>