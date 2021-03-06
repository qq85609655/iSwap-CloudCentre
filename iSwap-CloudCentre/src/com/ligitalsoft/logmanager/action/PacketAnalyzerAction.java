/*
 * @(#)ItemAction.java
 *
 * Copyright (C) 2005, zgcworld All right reserved.
 * see the site: http://www.zgcworld.com
 */

package com.ligitalsoft.logmanager.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.context.annotation.Scope;

import com.common.framework.services.IBaseServices;
import com.common.framework.view.FreemarkerBaseAction;
import com.common.framework.view.StrutsAction;
import com.ligitalsoft.model.changemanage.ChangeItem;

/**
 * 
 * 数据包比对分析
 * @Company 中海纪元
 * @author  Administrator
 * @mail    moujunhu@163.com
 * @since   2013-12-16下午5:23:38
 * @name    PacketAnalyzerAction.java
 * @version iSwap V1.0
 * @Team    研发中心
 */
@Scope("prototype")
@Namespace("/logmanager/packetAnalyzer")
@Action("packetAnalyzer")
@Results({ @Result(name = StrutsAction.RELOAD, location = "../../common/succ.ftl", type = "freemarker"),
        @Result(name = "listAction", location = "packetAnalyzer!list.action", type = "redirectAction", params = {}) })
public class PacketAnalyzerAction extends FreemarkerBaseAction<ChangeItem> {

    private static final long serialVersionUID = 5854980905054524517L;

	@Override
	public String list() {
		for(int i=1;i<=5;i++){
		}
		return "list";
	}
	
	@Override
	public String addView() {
		return "add";
	}

	@Override
	public String updateView() {
		return "update";
	}

	@Override
	protected IBaseServices<ChangeItem> getEntityService() {
		return null;
	}

}
