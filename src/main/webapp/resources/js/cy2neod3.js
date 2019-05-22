function Cy2NeoD3(config, graphId, tableId, sourceId, execId, urlSource, renderGraph, cbResult, params) {
    function createEditor() {
		return CodeMirror.fromTextArea(document.getElementById(sourceId), {
		  parserfile: ["codemirror-cypher.js"],
		  path: "scripts",
		  stylesheet: "styles/codemirror-neo.css",
		  autoMatchParens: true,
		  lineNumbers: true,
		  enterMode: "keep",
		  value: "some value"
		});
    }
    var neod3 = new Neod3Renderer();
	var neo = new Neo(urlSource);
    var editor = createEditor();
	$("#"+execId).click(function(evt) {
		nodeIdsArr = [];
		prev_query = "";
		try {
			evt.preventDefault();
			var query = editor.getValue();
			
			// 검색조건이 있는지 확인
			var thesis = $("#input_Thesis").val();
			var researcher = $("#input_Researcher").val();
			var organ = $("#input_Organ").val();
			
			if((researcher != null && researcher != "") || thesis != null && thesis != "" || organ != null && organ != ""){
				query = "MATCH p=";
				if(thesis != null && thesis != ""){
					query += "(m:Thesis {name: $t_name})";
					params["t_name"] = thesis;
				}else{
					query += "(m:Thesis)";
					delete params["t_name"];
				}
				if(researcher != null && researcher != ""){
					query += "<-[r1]-(n:Researcher { name: $r_name })-[r2]->";
					params["r_name"] = researcher;
				}else{
					query += "<-[r1]-(n:Researcher)-[r2]->";
					delete params["r_name"];
				}
				if(organ != null && organ != ""){
					query += "(o:Organ { name: $o_name })";
					params["o_name"] = organ;
				}else{
					query += "(o:Organ)";
					delete params["o_name"];
				}
				query += " RETURN p as total limit 100 ";
			}
//			console.log("Parameters === ",params);
			$("#cypher").val(query);
		
//			console.log("Executing Query === ",query);
			var execButton = $(this).find('i');
			execButton.toggleClass('fa-play-circle-o fa-spinner fa-spin')
			neo.executeQuery(query,params,function(err,res) {
				execButton.toggleClass('fa-spinner fa-spin fa-play-circle-o')
				res = res || {}
				var graph=res.graph;
				totalNodes = graph;
//				console.log(totalNodes);
				if (renderGraph) {
					if (graph) {
						var c=$("#"+graphId);
						c.empty();
//						console.log(graph);
						neod3.render(graphId, c ,graph);
					} else {
						if (err) {
							console.log(err);
							if (err.length > 0) {
								sweetAlert("Cypher error", err[0].code + "\n" + err[0].message, "error");
							} else {
								sweetAlert("Ajax " + err.statusText, "Status " + err.status + ": " + err.state(), "error");
							}
						}
					}
				}
				if(cbResult) cbResult(res);
			});
		} catch(e) {
			console.log(e);
			sweetAlert("Catched error", e, "error");
		}
		return false;
	});
}
