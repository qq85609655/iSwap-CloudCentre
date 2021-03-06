<#assign s=JspTaglibs["/WEB-INF/struts-tags.tld"]>
<#include "/common/taglibs.ftl">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>指标管理</title>
	<link href="${path}/css/pop.css" rel="stylesheet" type="text/css" />
	<link href="${path}/js/liger/lib/ligerUI/skins/Aqua/css/ligerui-form.css" rel="stylesheet" type="text/css" />  
	<link href="${path}/js/liger/lib/ligerUI/skins/Aqua/css/ligerui-tree.css" rel="stylesheet" type="text/css" />        
	<script type='text/javascript' src='${path}/js/jquery-1.5.1.js'></script>
	<script type="text/javascript" src="${path}/js/liger/lib/ligerUI/js/core/base.js"></script>
	<script type="text/javascript" src="${path}/js/liger/lib/ligerUI/js/plugins/ligerTree.js"></script>
	<script type="text/javascript" src="${path}/js/liger/lib/ligerUI/js/plugins/ligerComboBox.js"></script> 
</head>
<body class="pm01_c">
	<form method="post" action="${path}/appitemmgr/appItemExchangeConf/appItemExchangeConf!add.action" id="saveForm">
   <@s.token/>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center" valign="middle"  height="100%">
        <table width="100%" border="0" cellspacing="0" cellpadding="0"  height="100%">
            <tr>
              <td  height="100%" valign="top" >
              <div class="item1">
                  <ul class="item1_c">
                  	<li class="item_bg">
                      <p>所属应用:</p>
                      <span>
                      	<select style="width:300px;" id="appMsgId"><!-- name="appItemExchangeConf.appMsg.id"-->
                      		<option value="">请选择...</option>
                      	</select>
                      <span><div id="appMsgIdTip"></div></span>
                      </li>
                    <li>
                      <p>所属指标:</p>
                      <span>
                      	<select style="width:300px;" id="appItemId"><!-- name="appItemExchangeConf.appItem.id" -->
                      		<option value="">请选择...</option>
                      	</select>
                      </span>
                      <span><div id="appItemId"></div></span>
                    </li>
                    <li class="item_bg">
                      <p>数据提供部门:</p>
                      <span>
                      	<input type="hidden" id="sendDeptIds"/><!--  name="appItemExchangeConf.sendDept.id" -->
                      	<span style="display:none;" id="appItemExchangeConfsSpan"></span>
                     	<input type="text" id="txt1" style="border: 0 none;padding: 0;"/>
                      </span>
                      <span><div id="sendDeptIdsTip"></div></span>
                    </li>
                    <li>
                      <p>数据接收部门:</p>
                      <span>
                      <span style="display:none;" id="appItemExchangeConfDetailsSpan"></span>
                      <input type="text" id="txt2" style="border: 0 none;padding: 0;"/>
                      </span>
                    </li>
                    <li class="item_bg">
                      <p>是否共享:</p>
                      <span>
                     	<input type="radio" id="isShare" value="0" checked="true">是</input><!-- name="appItemExchangeConf.isShare"-->
                     	<input type="radio" id="isShare" value="1">否</input><!-- name="appItemExchangeConf.isShare"-->
                      </span>
                    </li>
                      <li>
						  <p>描述</p>
						  <span>
						  <textarea cols="42" rows="5" id="remark" ></textarea><!-- name="appItemExchangeConf.remark"-->
						  </span>
						</li>
                  </ul>
                </div>
                </td>
            </tr>
          </table>
         </td>
      </tr>
    </table>
    </form>
    </body>
</html>
<#include "/common/commonUd.ftl">
<#include "/common/commonValidator.ftl">
<script type='text/javascript' src='${path}/js/validator/metaData/item.js'></script> 
<script type="text/javascript"> 
	$(document).ready(function(){
		//应用
		$.post('${path}/appitemmgr/appMsg/appMsg!getAppMsgList4Ajax.action',{},function(result, status){
			var options = "";
			if(result){
				//var resobj = eval("("+result+")");
				$.each(result, function(index, obj){
					options += "<option value='"+obj.id+"'>"+obj.appName+"</option>";
				});
			}
			$('#appMsgId').html($('#appMsgId').html()+options);
		});
		
		//指标
		$.post('${path}/appitemmgr/appItem/appItem!getAppItemList4Ajax.action',{},function(result, status){
			var options = "";
			if(result){
				//var resobj = eval("("+result+")");
				$.each(result, function(index, obj){
					options += "<option value='"+obj.id+"'>"+obj.appItemName+"</option>";
				});
			}
			$('#appItemId').html($('#appItemId').html()+options);
		});
	
		var treeManager1 = null;
		var treeManager2 = null;
		var txt1Manager = $("#txt1").ligerComboBox({
	        width: 300,
	        selectBoxWidth: 300,
	        selectBoxHeight: 200,
	        textField:'name', valueField: 'id',treeLeafOnly:true,
	        tree: { url: "${path}/sysmanager/dept/dept!getDeptTree.action", 
	        		checkbox: true,
	                textFieldName:"name",
	                idFieldName:"id",
	                parentIDFieldName:"pid"
	              },
	        onBeforeOpen:function(){
	        	var appMsgId = $('#appMsgId').val();
	        	var appItemId = $('#appItemId').val();
	        	if(appMsgId){
	        		if(appItemId){
	        			return true;
		        	}else{
		        		alert("请选择所属指标");
		        		return false;
		        	}
	        	}else{
	        		alert("请选择所属应用");
	        		return false;
	        	}
	        },
	        onSelected:function(values){
	        	$('#sendDeptIds').val(values);
	        	var appMsgId = $('#appMsgId').val();
	        	var appItemId = $('#appItemId').val();
    			treeManager2 = $(txt2Manager.tree).ligerGetTreeManager();  
    			treeManager2.clear();
    			treeManager2.loadData(null,"${path}/ajax/ajax!getDeptTree4AppItemExchangeConf.action",{appMsgId:appMsgId,appItemId:appItemId,sendDeptIds:values});
	       		$('#appItemExchangeConfsSpan').html();
				var idsArray = values.split(";");
				var html = '';
				$.each(idsArray, function(index, id){
					html += '<input type="hidden" name="appItemExchangeConfList['+index+'].sendDept.id" value="'+id+'"/>'
				        +'<input type="hidden" name="appItemExchangeConfList['+index+'].appMsg.id" value="'+appMsgId+'"/>'
				        +'<input type="hidden" name="appItemExchangeConfList['+index+'].appItem.id" value="'+appItemId+'"/>';
				});
				$('#appItemExchangeConfsSpan').html(html);
	        }
	    });
	    
	    var txt2Manager = $("#txt2").ligerComboBox({
	        width: 300,
	        selectBoxWidth: 300,
	        selectBoxHeight: 200,
	        textField:'name', valueField: 'id',treeLeafOnly:true,
	        onSelected:onSelectedReceiveDept,
	        tree: { url: "${path}/sysmanager/dept/dept!getDeptTree.action", 
	        		checkbox: true,
	                textFieldName:"name",
	                idFieldName:"id",
	                parentIDFieldName:"pid"
	              },
	        onBeforeOpen:function(){
	        	var appMsgId = $('#appMsgId').val();
	        	var appItemId = $('#appItemId').val();
	        	var sendDeptIds = $('#sendDeptIds').val();
	        	if(appMsgId){
	        		if(appItemId){
	        			if(sendDeptIds){
	        				return true;
			        	}else{
			        		alert("请选择数据提供部门");
			        		return false;
			        	}
		        	}else{
		        		alert("请选择所属指标");
		        		return false;
		        	}
	        	}else{
	        		alert("请选择所属应用");
	        		return false;
	        	}
	        }
	    });
		
		//大小写转换
		$('#itemCode').keypress(function(e) {     
		    var keyCode= event.keyCode;  
		    var realkey = String.fromCharCode(keyCode).toUpperCase();  
		    $(this).val($(this).val()+realkey);  
		    event.returnValue =false;  
		});
	});

	function onSelectedReceiveDept(values){
		$('#appItemExchangeConfDetailsSpan').html();
		var idsArray = values.split(";");
		var html = '';
		var num = $('#appItemExchangeConfsSpan input').length;
		if(num)num=num/3;
		$.each(idsArray, function(index, id){
			for(i=0; i<num; i++){
				html += '<input type="hidden" name="appItemExchangeConfList['+i+'].appItemExchangeConfDetails['+index+'].receiveDept.id" value="'+id+'"/>';
			}
		});
		$('#appItemExchangeConfDetailsSpan').html(html);
	}
	
	var doSubmit = isSub;
	isSub = function(){
		var isShare = $('#isShare').val();
		var remark = $('#remark').val();
		var num = $('#appItemExchangeConfsSpan input').length;
		if(num)num=num/3;
		var html = "";
		for(i=0; i<num; i++){
			html += '<input type="hidden" name="appItemExchangeConfList['+i+'].isShare" value="'+isShare+'"/>'
			        +'<input type="hidden" name="appItemExchangeConfList['+i+'].remark" value="'+remark+'"/>';
		}
		$('#appItemExchangeConfsSpan').html($('#appItemExchangeConfsSpan').html()+html);
		doSubmit();
	}
</script>
