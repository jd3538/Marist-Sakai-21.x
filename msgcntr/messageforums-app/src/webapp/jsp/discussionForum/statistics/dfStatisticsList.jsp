<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf2/sakai" prefix="sakai" %>
<%@ taglib uri="http://sakaiproject.org/jsf/messageforums" prefix="mf" %>
<jsp:useBean id="msgs" class="org.sakaiproject.util.ResourceLoader" scope="session">
	<jsp:setProperty name="msgs" property="baseName" value="org.sakaiproject.api.app.messagecenter.bundle.Messages"/>	
</jsp:useBean>
<f:view>
  <sakai:view >
  	<h:form id="dfStatisticsForm" rendered="#{ForumTool.instructor}">
<!-- discussionForum/statistics/dfStatisticsList.jsp-->
       		<script>includeLatestJQuery("msgcntr");</script>
       		<script src="/messageforums-tool/js/sak-10625.js"></script>
       		<link rel="stylesheet" type="text/css" href="/messageforums-tool/css/msgcntr_statistics.css" />
        <script>
        $(document).ready(function() {
            var menuLink = $('#forumsStatisticsMenuLink');
            var menuLinkSpan = menuLink.closest('span');
            menuLinkSpan.addClass('current');
            menuLinkSpan.html(menuLink.text());
        });
        </script>
        <%@ include file="/jsp/discussionForum/menu/forumsMenu.jsp" %>
  		<h:panelGrid columns="2" width="100%" styleClass="navPanel  specialLink">
          <h:panelGroup>
			  <div class="page-header">
			 	<f:verbatim><h1></f:verbatim>
				  <h:commandLink action="#{ForumTool.processActionHome}" value="#{msgs.cdfm_message_forums}" title=" #{msgs.cdfm_message_forums}"
						rendered="#{ForumTool.messagesandForums}" />
				  <h:commandLink action="#{ForumTool.processActionHome}" value="#{msgs.cdfm_discussion_forums}" title=" #{msgs.cdfm_discussion_forums}"
						rendered="#{ForumTool.forumsTool}" />
				  <h:outputText value=" " /><h:outputText value=" / " /><h:outputText value=" " />
				  <h:outputText value="#{msgs.stat_list}" />
				<f:verbatim></h1></f:verbatim>
			  </div>
          </h:panelGroup>
          <h:panelGroup styleClass="itemNav specialLink">
			<h:outputText value="#{msgs.cdfm_statistics} #{msgs.stat_byUser} " />
			<h:outputText value="#{msgs.cdfm_toolbar_separator} " />
			<h:commandLink action="#{mfStatisticsBean.processActionStatisticsByAllTopics}" value="#{msgs.cdfm_statistics} #{msgs.stat_byTopic}" title="#{msgs.cdfm_statistics} #{msgs.stat_byTopic}"/>
		  </h:panelGroup>
        </h:panelGrid>
  	
      <div class="table-responsive">
  		<h:dataTable styleClass="table table-hover table-striped table-bordered lines nolines" id="members" value="#{mfStatisticsBean.allUserStatistics}" var="stat" rendered="true"
   	 		columnClasses="specialLink,bogus,bogus,bogus,bogus" cellpadding="0" cellspacing="0">
  			<h:column>
  				<f:facet name="header">
					<h:commandLink action="#{mfStatisticsBean.toggleNameSort}" title="#{mfStatisticsBean.pureAnon ? msgs.stat_anon_user : msgs.stat_name}">
					   	<h:outputText value="#{mfStatisticsBean.pureAnon ? msgs.stat_anon_user : msgs.stat_name}" />
						<h:graphicImage value="/images/sortascending.gif" rendered="#{mfStatisticsBean.nameSort && mfStatisticsBean.ascending}" alt="#{msgs.stat_sort_name}"/>
						<h:graphicImage value="/images/sortdescending.gif" rendered="#{mfStatisticsBean.nameSort && !mfStatisticsBean.ascending}" alt="#{msgs.stat_sort_name}"/>
					</h:commandLink>
  				</f:facet>
  				<h:commandLink action="#{mfStatisticsBean.processActionStatisticsUser}" immediate="true">
  				    <f:param value="#{stat.siteUserId}" name="siteUserId"/>
  				    <h:outputText rendered="#{!stat.useAnonId}" value="#{stat.siteUser}" />
  				    <h:outputText rendered="#{stat.useAnonId}" value="#{stat.siteAnonId}" styleClass="anonymousAuthor"/>
	          	</h:commandLink>
			</h:column>
			<h:column rendered="#{!mfStatisticsBean.pureAnon}">
				<f:facet name="header">
					<h:commandLink action="#{mfStatisticsBean.toggleIdSort}" title="#{msgs.stat_eid}">
						<h:outputText value="#{msgs.stat_eid}" />
						<h:graphicImage value="/images/sortascending.gif" rendered="#{mfStatisticsBean.idSort && mfStatisticsBean.ascending}" alt="#{msgs.stat_sort_eid}"/>
						<h:graphicImage value="/images/sortdescending.gif" rendered="#{mfStatisticsBean.idSort && !mfStatisticsBean.ascending}" alt="#{msgs.stat_sort_eid}"/>
					</h:commandLink>
				</f:facet>
				<h:commandLink action="#{mfStatisticsBean.processActionStatisticsUser}" immediate="true">
					<f:param value="#{stat.siteUserId}" name="siteUserId"/>
					<h:outputText value="#{stat.siteUserDisplayId}" />
				</h:commandLink>
			</h:column>
  			<h:column>
  				<f:facet name="header">
  					<h:commandLink action="#{mfStatisticsBean.toggleAuthoredSort}" title="#{msgs.stat_authored}">
					   	<h:outputText value="#{msgs.stat_authored}" />
						<h:graphicImage value="/images/sortascending.gif" rendered="#{mfStatisticsBean.authoredSort && mfStatisticsBean.ascending}" alt="#{msgs.stat_sort_authored}"/>
						<h:graphicImage value="/images/sortdescending.gif" rendered="#{mfStatisticsBean.authoredSort && !mfStatisticsBean.ascending}" alt="#{msgs.stat_sort_authored}"/>
					</h:commandLink>
  				</f:facet>
  				<h:outputText value="#{stat.authoredForumsAmt}" />
  			</h:column>
  			<h:column>
  				<f:facet name="header">
  					<h:commandLink action="#{mfStatisticsBean.toggleReadSort}" title="#{msgs.stat_read}">
					   	<h:outputText value="#{msgs.stat_read}" />
						<h:graphicImage value="/images/sortascending.gif" rendered="#{mfStatisticsBean.readSort && mfStatisticsBean.ascending}" alt="#{msgs.stat_sort_read}"/>
						<h:graphicImage value="/images/sortdescending.gif" rendered="#{mfStatisticsBean.readSort && !mfStatisticsBean.ascending}" alt="#{msgs.stat_sort_read}"/>
					</h:commandLink>
  				</f:facet>
  				<h:outputText value="#{stat.readForumsAmt}" />
  			</h:column>
  			<h:column>
  				<f:facet name="header">
  					<h:commandLink action="#{mfStatisticsBean.toggleUnreadSort}" title="#{msgs.stat_unread}">
					   	<h:outputText value="#{msgs.stat_unread}" />
						<h:graphicImage value="/images/sortascending.gif" rendered="#{mfStatisticsBean.unreadSort && mfStatisticsBean.ascending}" alt="#{msgs.stat_sort_unread}"/>
						<h:graphicImage value="/images/sortdescending.gif" rendered="#{mfStatisticsBean.unreadSort && !mfStatisticsBean.ascending}" alt="#{msgs.stat_sort_unread}"/>
					</h:commandLink>
  				</f:facet>
  				<h:outputText value="#{stat.unreadForumsAmt}" />
  			</h:column>
  			<h:column>
  				<f:facet name="header">
  					<h:commandLink action="#{mfStatisticsBean.togglePercentReadSort}" title="#{msgs.stat_percent_read}">
					   	<h:outputText value="#{msgs.stat_percent_read}" />
						<h:graphicImage value="/images/sortascending.gif" rendered="#{mfStatisticsBean.percentReadSort && mfStatisticsBean.ascending}" alt="#{msgs.stat_sort_percent_read}"/>
						<h:graphicImage value="/images/sortdescending.gif" rendered="#{mfStatisticsBean.percentReadSort && !mfStatisticsBean.ascending}" alt="#{msgs.stat_sort_percent_read}"/>
					</h:commandLink>
  				</f:facet>
  				<h:outputText value="#{stat.percentReadForumsAmt}">
  					<f:convertNumber type="percent" />
  				</h:outputText>
  			</h:column>
  		</h:dataTable>
      </div>
  	</h:form>
  </sakai:view>
</f:view>
