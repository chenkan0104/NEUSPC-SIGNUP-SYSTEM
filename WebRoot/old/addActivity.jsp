<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="dao.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">

<title>东北大学社会实践中心</title>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="东北大学,社会实践,一周一期,报名">
<meta http-equiv="description" content="东北大学社会实践中心报名系统">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/bootstrap-responsive.min.css" rel="stylesheet">

<link href="css/datetimepicker.css" rel="stylesheet">

<style>
body {
	padding-top: 60px;
	/* 60px to make the container go all the way to the bottom of the topbar */
}

#editor {
	max-height: 250px;
	height: 250px;
	background-color: white;
	border-collapse: separate;
	border: 1px solid rgb(204, 204, 204);
	padding: 4px;
	box-sizing: content-box;
	-webkit-box-shadow: rgba(0, 0, 0, 0.0745098) 0px 1px 1px 0px inset;
	box-shadow: rgba(0, 0, 0, 0.0745098) 0px 1px 1px 0px inset;
	border-top-right-radius: 3px;
	border-bottom-right-radius: 3px;
	border-bottom-left-radius: 3px;
	border-top-left-radius: 3px;
	overflow: scroll;
	outline: none;
}

#editor_title {
	height: 20px;
	background-color: white;
	border-collapse: separate;
	border: 1px solid rgb(204, 204, 204);
	padding: 4px;
	box-sizing: content-box;
	-webkit-box-shadow: rgba(0, 0, 0, 0.0745098) 0px 1px 1px 0px inset;
	box-shadow: rgba(0, 0, 0, 0.0745098) 0px 1px 1px 0px inset;
	border-top-right-radius: 3px;
	border-bottom-right-radius: 3px;
	border-bottom-left-radius: 3px;
	border-top-left-radius: 3px;
	outline: none;
}

#voiceBtn {
	width: 20px;
	color: transparent;
	background-color: transparent;
	transform: scale(2.0, 2.0);
	-webkit-transform: scale(2.0, 2.0);
	-moz-transform: scale(2.0, 2.0);
	border: transparent;
	cursor: pointer;
	box-shadow: none;
	-webkit-box-shadow: none;
}

div[data-role="editor-toolbar"] {
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

.dropdown-menu a {
	cursor: pointer;
}
</style>

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="//cdnjs.bootcss.com/ajax/libs/html5shiv/3.6.2/html5shiv.js"></script>
    <![endif]-->

<!-- Fav and touch icons -->
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="../assets/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="../assets/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="../assets/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="../assets/ico/apple-touch-icon-57-precomposed.png">
<link rel="shortcut icon" href="../assets/ico/favicon.png">
</head>

<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<button type="button" class="btn btn-navbar" data-toggle="collapse"
					data-target=".nav-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="brand" href="admin.jsp">东北大学社会实践中心</a>
				<div class="nav-collapse collapse">
					<ul class="nav">
						<li><a href="admin.jsp">活动列表</a></li>
						<li class="active"><a href="addActivity.jsp">添加活动</a></li>
					</ul>
				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</div>

	<div class="container">

		<div class="page-header">
			<div class="pull-right"></div>
			<h1>添加活动</h1>
		</div>

		<div class="tab-content">
			<div class="tab-pane fade active in" id="activity">
				<div>
					<form accept-charset="UTF-8" class="form-horizontal" method="post"
						action="RegisterConf" id="regist">
						<fieldset>
							<legend>活动内容</legend>
							<div>
								<div id="editor_title" contenteditable="true">
									活动标题&hellip;</div>
							</div>
							<br>
							<div class="btn-toolbar" data-role="editor-toolbar"
								data-target="#editor">
								<div class="btn-group">
									<a class="btn dropdown-toggle" data-toggle="dropdown" title=""
										data-original-title="Font"><i class="icon-font"></i><b
										class="caret"></b> </a>
									<ul class="dropdown-menu">
										<li><a data-edit="fontName Serif"
											style="font-family:'Serif'">Serif</a></li>
										<li><a data-edit="fontName Sans"
											style="font-family:'Sans'">Sans</a>
										</li>
										<li><a data-edit="fontName Arial"
											style="font-family:'Arial'">Arial</a></li>
										<li><a data-edit="fontName Arial Black"
											style="font-family:'Arial Black'">Arial Black</a></li>
										<li><a data-edit="fontName Courier"
											style="font-family:'Courier'">Courier</a></li>
										<li><a data-edit="fontName Courier New"
											style="font-family:'Courier New'">Courier New</a></li>
										<li><a data-edit="fontName Comic Sans MS"
											style="font-family:'Comic Sans MS'">Comic Sans MS</a></li>
										<li><a data-edit="fontName Helvetica"
											style="font-family:'Helvetica'">Helvetica</a></li>
										<li><a data-edit="fontName Impact"
											style="font-family:'Impact'">Impact</a></li>
										<li><a data-edit="fontName Lucida Grande"
											style="font-family:'Lucida Grande'">Lucida Grande</a></li>
										<li><a data-edit="fontName Lucida Sans"
											style="font-family:'Lucida Sans'">Lucida Sans</a></li>
										<li><a data-edit="fontName Tahoma"
											style="font-family:'Tahoma'">Tahoma</a></li>
										<li><a data-edit="fontName Times"
											style="font-family:'Times'">Times</a></li>
										<li><a data-edit="fontName Times New Roman"
											style="font-family:'Times New Roman'">Times New Roman</a></li>
										<li><a data-edit="fontName Verdana"
											style="font-family:'Verdana'">Verdana</a></li>
									</ul>
								</div>
								<div class="btn-group">
									<a class="btn dropdown-toggle" data-toggle="dropdown" title=""
										data-original-title="Font Size"><i
										class="icon-text-height"></i>&nbsp;<b class="caret"></b> </a>
									<ul class="dropdown-menu">
										<li><a data-edit="fontSize 5"><font size="5">Huge</font>
										</a></li>
										<li><a data-edit="fontSize 3"><font size="3">Normal</font>
										</a></li>
										<li><a data-edit="fontSize 1"><font size="1">Small</font>
										</a></li>
									</ul>
								</div>
								<div class="btn-group">
									<a class="btn" data-edit="bold" title=""
										data-original-title="Bold (Ctrl/Cmd+B)"><i
										class="icon-bold"></i> </a> <a class="btn" data-edit="italic"
										title="" data-original-title="Italic (Ctrl/Cmd+I)"><i
										class="icon-italic"></i> </a> <a class="btn"
										data-edit="strikethrough" title=""
										data-original-title="Strikethrough"><i
										class="icon-strikethrough"></i> </a> <a class="btn"
										data-edit="underline" title=""
										data-original-title="Underline (Ctrl/Cmd+U)"><i
										class="icon-underline"></i> </a>
								</div>
								<div class="btn-group">
									<a class="btn" data-edit="insertunorderedlist" title=""
										data-original-title="Bullet list"><i class="icon-list-ul"></i>
									</a> <a class="btn" data-edit="insertorderedlist" title=""
										data-original-title="Number list"><i class="icon-list-ol"></i>
									</a> <a class="btn" data-edit="outdent" title=""
										data-original-title="Reduce indent (Shift+Tab)"><i
										class="icon-indent-left"></i> </a> <a class="btn"
										data-edit="indent" title="" data-original-title="Indent (Tab)"><i
										class="icon-indent-right"></i> </a>
								</div>
								<div class="btn-group">
									<a class="btn btn-info" data-edit="justifyleft" title=""
										data-original-title="Align Left (Ctrl/Cmd+L)"><i
										class="icon-align-left"></i> </a> <a class="btn"
										data-edit="justifycenter" title=""
										data-original-title="Center (Ctrl/Cmd+E)"><i
										class="icon-align-center"></i> </a> <a class="btn"
										data-edit="justifyright" title=""
										data-original-title="Align Right (Ctrl/Cmd+R)"><i
										class="icon-align-right"></i> </a> <a class="btn"
										data-edit="justifyfull" title=""
										data-original-title="Justify (Ctrl/Cmd+J)"><i
										class="icon-align-justify"></i> </a>
								</div>
								<div class="btn-group">
									<a class="btn dropdown-toggle" data-toggle="dropdown" title=""
										data-original-title="Hyperlink"><i class="icon-link"></i>
									</a>
									<div class="dropdown-menu input-append">
										<input class="span2" placeholder="URL" type="text"
											data-edit="createLink">
										<button class="btn" type="button">Add</button>
									</div>
									<a class="btn" data-edit="unlink" title=""
										data-original-title="Remove Hyperlink"><i class="icon-cut"></i>
									</a>

								</div>

								<div class="btn-group">
									<a class="btn" title="" id="pictureBtn"
										data-original-title="Insert picture (or just drag &amp; drop)"><i
										class="icon-picture"></i> </a> <input type="file"
										data-role="magic-overlay" data-target="#pictureBtn"
										data-edit="insertImage"
										style="opacity: 0; position: absolute; top: 0px; left: 0px; width: 41px; height: 30px;">
								</div>
								<div class="btn-group">
									<a class="btn" data-edit="undo" title=""
										data-original-title="Undo (Ctrl/Cmd+Z)"><i
										class="icon-undo"></i> </a> <a class="btn" data-edit="redo"
										title="" data-original-title="Redo (Ctrl/Cmd+Y)"><i
										class="icon-repeat"></i> </a>
								</div>
								<input type="text" data-edit="inserttext" id="voiceBtn"
									x-webkit-speech="" style="display: none;">
							</div>

							<div id="editor" contenteditable="true">活动内容&hellip;</div>
						</fieldset>

						<fieldset>
							<legend>活动设置</legend>
							<div class="control-group">
								<label class="control-label" for="starttime">开始时间</label>
								<div class="controls">
									<div class="input-append date form_starttime">
										<input size="16" type="text" value="" readonly> <span
											class="add-on" id="starttime"><i class="icon-th"></i>
										</span>
									</div>
								</div>
								<label class="control-label" for="endtime">结束时间</label>
								<div class="controls">
									<div class="input-append date form_endtime">
										<input size="16" type="text" value="" readonly> <span
											class="add-on" id="endtime"><i class="icon-th"></i> </span>
									</div>
								</div>
							</div>
						</fieldset>

						<script>
							function postInfo() {
								$.post("Test", {
									"info" : $('#editor').html()
								});
							}
						</script>
						<button class="btn btn-primary" type="button" onclick="postInfo()">提交修改</button>
					</form>
				</div>
				<hr />
			</div>

			<div class="tab-pane fade" id="teams">
				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th width="45"></th>
							<th>队名</th>
							<th width="80">创建时间</th>
							<th width="60">成员数量</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><span class="label label-success">已经生效</span>
							</td>
							<td><a href="/teams/1586">陈侃的团队</a></td>
							<td>07 Apr 12:54</td>
							<td>1</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<footer>
			<p class="pull-right">
				<%
					out.print(new java.util.Date());
				%>, <a href="admin.jsp">后台管理</a>
			</p>
			<p>
				© 2013<a href="index.jsp" target="_blank">东北大学社会实践中心</a> ·<a
					href="joinUs.jsp">加入我们</a>
			</p>
		</footer>
	</div>

	<!-- /container -->
	<script src="js/jquery.min.js"></script>
	<script src="js/jquery.hotkeys.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/bootstrap.wysiwyg.js"></script>
	<script src="js/bootstrap-datetimepicker.js"></script>
	<script src="js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	<script>
		$(function() {
			function initToolbarBootstrapBindings() {
				var fonts = [ 'Serif', 'Sans', 'Arial', 'Arial Black',
						'Courier', 'Courier New', 'Comic Sans MS', 'Helvetica',
						'Impact', 'Lucida Grande', 'Lucida Sans', 'Tahoma',
						'Times', 'Times New Roman', 'Verdana' ], fontTarget = $(
						'[title=Font]').siblings('.dropdown-menu');
				$
						.each(
								fonts,
								function(idx, fontName) {
									fontTarget
											.append($('<li><a data-edit="fontName ' + fontName +'" style="font-family:\''+ fontName +'\'">'
													+ fontName + '</a></li>'));
								});
				$('a[title]').tooltip({
					container : 'body'
				});
				$('.dropdown-menu input').click(function() {
					return false;
				}).change(
						function() {
							$(this).parent('.dropdown-menu').siblings(
									'.dropdown-toggle').dropdown('toggle');
						}).keydown('esc', function() {
					this.value = '';
					$(this).change();
				});

				$('[data-role=magic-overlay]').each(
						function() {
							var overlay = $(this), target = $(overlay
									.data('target'));
							overlay.css('opacity', 0).css('position',
									'absolute').offset(target.offset()).width(
									target.outerWidth()).height(
									target.outerHeight());
						});
				$('#voiceBtn').hide();
				// if ("onwebkitspeechchange"  in document.createElement("input")) {
				//   var editorOffset = $('#editor').offset();
				//   $('#voiceBtn').css('position','absolute').offset({top: editorOffset.top, left: editorOffset.left+$('#editor').innerWidth()-35});
				// } else {
				//   $('#voiceBtn').hide();
				// }
			}
			;
			initToolbarBootstrapBindings();
			$('#editor').wysiwyg();
			window.prettyPrint && prettyPrint();
		});
	</script>
	<script type="text/javascript">
		$('.form_starttime').datetimepicker({
			language : 'zh-CN',
			weekStart : 7,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 2,
			forceParse : 0,
			showMeridian : 1,
			pickerPosition : "bottom-left"
		});
		$('.form_endtime').datetimepicker({
			language : 'zh-CN',
			weekStart : 7,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 2,
			forceParse : 0,
			showMeridian : 1,
			pickerPosition : "bottom-left"
		});
	</script>
</body>
</html>
