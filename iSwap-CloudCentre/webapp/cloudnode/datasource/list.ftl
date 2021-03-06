<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<#include "/common/taglibs.ftl">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>数据源注册</title>
		<link href="${path}/css/main.css" rel="stylesheet" type="text/css" />
		<link href="${path}/css/tree.css" rel="stylesheet" type="text/css" />
		<link href="${path}/css/pop.css" rel="stylesheet" type="text/css" />
		<script type='text/javascript' src='${path}/js/jquery-1.5.1.js'></script>
	</head>
	<body>
		<div class="common_menu">
			<div class="c_m_title">
				<img src="${path}/images/title/img_05.png" align="absmiddle" />数据源注册
			</div>
			<div class="c_m_btn">
				<span class="cm_btn_m">
				<a href="javascript:void(0)" id="hz1" onclick="opdg('${path}/cloudnode/datasource/datasource!addView.action?deptId=${deptId?default('')}','注册数据源','650','590');">
					<b>
						<img src="${path}/images/cmb_xj.gif" class="cmb_img" />
						注册数据源
						<a href="javascript:void(0)">
							<img src="${path}/images/bullet_add.png" class="bullet_add" />
						</a>
					</b>
				</a>
				</span><span class="cm_btn_m">&nbsp;</span>
			</div>
		</div>
		<div class="main_c">
			<form name="pageForm" action="${path}/cloudnode/datasource/datasource!list.action" method="post">
				<input type="hidden" name="deptId" value="${deptId?default('')}" />
				<table class="main_drop">
					<tr>
						<td align="right">数据源名称：
							 <input name="sourceName" type="text" value="${sourceName?default(" ")}" onkeypress="showKeyPress()" />
							<!-- onpaste="return false"--> 
							数据库类型：
							 <select name="type">
							 	<option value="">---全部---</option>
								<option value="ORACLE"<#if type?exists><#if type=='ORACLE'>selected</#if></#if> >Oracle</option>
								<option value="DB2"<#if type?exists><#if type=='DB2'>selected</#if></#if>>IBM DB2</option>
								<option value="SQLSERVER"<#if type?exists><#if type=='SQLSERVER'>selected</#if></#if>>MS SQLServer</option>
								<option value="MYSQL"<#if type?exists><#if type=='MYSQL'>selected</#if></#if>>MySQL</option>
							</select> 
							<input name="" type="button" value="查询" class="btn_s" onclick="selectdatasource();" />
						</td>
					</tr>
				</table>
				<table class="tabs1" style="margin-top:0px;">
					<tr>
						<th width="30">
							<a href="javascript:void(0);" onclick="checkedAll(this,'ids');return false;"></a>
						</th>
						<th width="30">序号</th>
						<th>数据源名称</th>
						<th>发布状态</th>
						<th>数据库类型</th>
						<th>创建时间</th>
						<th>操 作</th>
					</tr>
					<#list listDatas as entity>
					<tr <#if entity_index%2==0>class="trbg"</#if> onclick="selectedTD(this);">
						<td>
							<input name="ids" type="checkbox" value="${entity.id}" />
						</td>
					    <td width="18">
					   		${entity_index+1}
					    </td>
					    <td>
					    	<a href="javascript:void(0)" onclick="opdg('${path}/cloudnode/datasource/datasource!view.action?id=${entity.id}','数据源信息查看','550','250');">${entity.sourceName?default('')}</a>
					    </td>
						<td>
							<#if entity.status?exists><#if entity.status=='0'><font class="font_red">未发布</font></#if><#if entity.status=='1'>已发布</#if><#else>未发布</#if>
						</td>
					    <td>
					    	${entity.type?default('')}
					    </td>
					    <td>
					   		${entity.createDate?default('')}
					    </td>
					    <td style="text-align:left;" width="300">
					        <a id="hz2" href="javascript:void(0);" <#if entity.status=='1'> style="color:#ccc;"</#if> <#if entity.status=='0'> onclick="opdg('${path}/cloudnode/datasource/datasource!updateView.action?deptId=${deptId?default('')}&id='+${entity.id},'数据源编辑','650','590');" </#if> class="tabs1_cz">
					        	<img src="${path}/images/czimg_edit.gif" />编辑
					        </a>&nbsp;
					        <a id="hz4" href="javascript:void(0);" <#if entity.status=='1'> style="color:#ccc;"</#if> <#if entity.status=='0'> onclick="del(${entity.id});"</#if> class="tabs1_cz" >
					        	<img src="${path}/images/small9/czimg_sc.gif" />删除
					        </a>&nbsp;
						    	<#if entity.status?exists>
							        <#if entity.status=='1'>
							        <a id="hz4" href="javascript:testConn('${entity.id}');" class="tabs1_cz" >
						          		<img src="${path}/images/small9/s_ceshi.gif" />测试
						          	</a>&nbsp;
								    <a href="javascript:void(0);" onclick="deploy('${path}/cloudnode/datasource/datasource!updateStatus.action?status=0&ids=${entity.id}','0')" class="tabs1_cz" >
								    	<img src="${path}/images/small9/s_quxiaofabu.png" />取消发布
								    </a>
								    </#if>
								    <#if entity.status=='0'>
							    	<a id="hz4" href="#" style="color:#ccc;" class="tabs1_cz" >
					          			<img src="${path}/images/small9/s_ceshi.gif" />测试
					          		</a>&nbsp;
							        <a href="javascript:void(0);" onclick="deploy('${path}/cloudnode/datasource/datasource!updateStatus.action?status=1&ids=${entity.id}','1')" class="tabs1_cz" >
							        	<img src="${path}/images/small9/s_quxiaofabu.png" />发&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;布
							        </a>
								    </#if>
							     <#else>
							     	<a id="hz4"  class="tabs1_cz" href="#" style="color:#ccc;">
					          			<img src="${path}/images/small9/s_ceshi.gif" />测试
					          		</a>&nbsp;
							        <a href="javascript:void(0);" onclick="deploy('${path}/cloudnode/datasource/datasource!updateStatus.action?status=1&ids=${entity.id}','1')" class="tabs1_cz" >
							        	<img src="${path}/images/small9/s_quxiaofabu.png" />发&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;布
							        </a>
						         </#if>
					          </td>
					        </tr>
					</#list>
				</table>
				<div class="tabs_foot">
					<span class="tfl_btns"> 
						<img src="${path}/images/tabsf_arrow.gif" align="bottom" style="margin-left:8px; margin-right:8px;" /> 
						<a href="javascript:void(0);" onclick="checkedAll(this,'ids');return false;">全选</a> 
						<img src="${path}/images/tabsf_line.jpg" align="absmiddle" style="margin:0 4px 0 10px;" /> 
						<a href="javascript:void(0)" onclick="delMany('${path}/cloudnode/datasource/datasource!delete.action');" class="tfl_blink"> 
							<b class="hot">删除</b> 
						</a> 
						<a href="javascript:void(0)" class="tfl_blink" onclick="updateStatus('${path}/cloudnode/datasource/datasource!updateStatus.action?status=1','1');">
							<b class="">发布</b> 
						</a> 
						<a href="javascript:void(0)" class="tfl_blink" onclick="updateStatus('${path}/cloudnode/datasource/datasource!updateStatus.action?status=0','0');">
							<b class="">取消发布</b> 
						</a> 
					</span> 
					<span class="page pageR"><@pager.pageTag/></span>
				</div>
			</form>
		</div>
		<div class="clear"></div>
		<#include "/common/commonList.ftl"> <#include "/common/commonLhg.ftl">
		<script> 
			function selectflow(){
				document.pageForm.submit();
			}
			//删除数据
			function del(id){
				if (confirm("确定要删除选中记录吗？")) {
					document.forms['pageForm'].action ="${path}/cloudnode/datasource/datasource!delete.action?ids="+id ;
					document.forms['pageForm'].submit();
				}
			}
			
			function selectdatasource(){
				document.pageForm.submit();
			}
			//修改状态
			function updateStatus(url,type){
			 var state="";
			  if('0'==type){state="确定要取消发布数据源？"}
				  if('1'==type){state="确定发布数据源？"}
				  if(checks()) {
					  if(confirm(state)) {
					 	document.forms['pageForm'].action = url;
						document.forms['pageForm'].submit();
					  }
				  } else {
				  	alert('至少选择一条数据');
				  }
				
			}
			function deploy(url,type){
			  var state="";
			  if('0'==type){state="确定要取消发布数据源？"}
				  if('1'==type){state="确定发布数据源？"}
					  if(confirm(state)) {
					 	document.forms['pageForm'].action = url;
						document.forms['pageForm'].submit();
					  }
				
			}
			//测试数据库连接
			function  testConn(connId){
				$.ajax({
			  		   type: "POST",
					   url: "${path}/cloudnode/datasource/datasource!testConnDataSource.action",
					   data: "id=" + connId,
					   success: function(data){
					   		if(data=='true'){
					   			alert("连接成功!");
					   		}else{
					   			alert("连接失败!");
					   		}
					   }
			  	});
			}
		</script>
	</body>
</html>
