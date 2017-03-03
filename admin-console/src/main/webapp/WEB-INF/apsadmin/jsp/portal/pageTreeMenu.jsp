<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<ol class="breadcrumb page-tabs-header breadcrumb-position">
    <li><s:text name="title.pageDesigner" /></li>
    <li><s:text name="title.pageTree" /></li>
</ol>

<s:if test="hasActionErrors()">
    <div class="alert alert-danger alert-dismissable">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
            <span class="pficon pficon-close"></span>
        </button>
        <span class="pficon pficon-error-circle-o"></span>
        <s:text name="message.title.ActionErrors" />
        <ul>
            <s:iterator value="actionErrors">
                <li><s:property escape="false" /></li>
                </s:iterator>
        </ul>
    </div>
</s:if>

<div class="main-container">

    <button type="button" data-toggle="collapse" data-target="#page-info" class="btn btn-link">
        Info
        <span class="icon fa fa-chevron-down"></span>
    </button>
    <div id="page-info" class="collapse">
        <table class="table table-bordered">
            <tbody>
            <tr>
                <th class="text-right"><s:text name="name.pageCode" /></th>
                <td data-info-pagecode></td>
            </tr>
            <tr>
                <th class="text-right"><s:text name="name.pageTitle" /></th>
                <td data-info-titles></td>
            </tr>
            <tr>
                <th class="text-right">Owner Group</th>
                <td data-info-group></td>
            </tr>
            <tr>
                <th class="text-right"><s:text name="name.pageModel" /></th>
                <td data-info-model></td>
            </tr>
            <tr>
                <th class="text-right"><s:text name="name.isShowablePage" /></th>
                <td data-info-showmenu></td>
            </tr>
            <tr>
                <th class="text-right">
                    <abbr lang="en" title="<s:text name="name.SEO.full" />">
                        <s:text name="name.SEO.short" />
                    </abbr>: <s:text name="name.useBetterTitles" />   </th>
                <td data-info-extratitles></td>
            </tr>
            </tbody>
        </table>

    </div>





    <!----------------- griglia del template ----------->
    <div class="grid-container"></div>
</div>



<!----------------- widget menu sinistra ----------->

<div id="widget-sidebar" class="drawer-pf-sidebar-right">


    <div class="drawer-pf-title drawer-pf-title-right-menu ">
        <span id="widget-sidebar-page-tree-btn" class="right-bar-title" >
            <span class="fa fa-sitemap fa-16px" aria-hidden="true"></span>&nbsp;&nbsp;&nbsp;<span class="list-group-item-value"><s:text name="title.pages" /></span>
        </span>
    </div>
    <div class="panel-group">
        <div class="drawer-pf-container">
            <s:include value="/WEB-INF/apsadmin/jsp/portal/widget-list-menu.jsp" />
        </div>
    </div>

</div>

<!-----------------drawer menu sinistra----------->

<div id="sidebar-page-tree" class="drawer-pf hide drawer-pf-notifications-non-clickable">
    <div class="drawer-pf-title drawer-pf-title-right-menu">

        <a class="drawer-pf-toggle-expand"></a>        

        <div class="right-bar-title"><s:text name="title.pages" /></div>

        <span id="close-page-tree-sidebar" class=" close-button-menu-right pull-right"><i class="fa fa-times" aria-hidden="true"></i></span>

    </div>
    <div class="panel-group" id="notification-drawer-accordion">


        <%--<s:include value="/WEB-INF/apsadmin/jsp/portal/include/pageSearchForm.jsp" />--%>
        <s:form cssClass="action-form">

            <div class="drawer-pf-notification drawer-pf-notification-right-menu ">

                <wpsf:submit action="new" type="button" title="%{getText('page.options.new')}" cssClass="btn-links " data-toggle="tooltip">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;<s:text name="title.addPage" />
                </wpsf:submit>
            </div>


            <s:set var="pageTreeStyleVar" ><wp:info key="systemParam" paramName="treeStyle_page" /></s:set>

            <s:if test="#pageTreeStyleVar == 'classic'">
                <div class="drawer-pf-notification drawer-pf-notification-right-menu ">
                    <button type="button" class="btn-no-button-right" id="expandAll">
                        <i class="fa fa-plus-square-o treeInteractionButtons" aria-hidden="true"></i>
                    </button>
                    <button type="button" class="btn-no-button-right" id="collapseAll">
                        <i class="fa fa-minus-square-o treeInteractionButtons" aria-hidden="true"></i>
                    </button>
                </div>
            </s:if>
            <div class="table-responsive overflow-visible">
                <table id="pageTree" class="table table-bordered table-hover table-treegrid table-tree-right">
                    <thead>

                    </thead>
                    <tbody>  
                        <s:set var="inputFieldName" value="%{'selectedNode'}" />
                        <s:set var="selectedTreeNode" value="%{selectedNode}" />
                        <s:set var="selectedPage" value="%{getPage(selectedNode)}" />
                        <s:set var="liClassName" value="'page'" />
                        <s:set var="treeItemIconName" value="'fa-folder'" />
                        <s:if test="#pageTreeStyleVar == 'classic'">
                            <s:set var="currentRoot" value="allowedTreeRootNode" />

                            <s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilderPagesMenu.jsp" />

                        </s:if>
                        <s:elseif test="#pageTreeStyleVar == 'request'">
                        <style>
                            .table-treegrid span.collapse-icon, .table-treegrid span.expand-icon {
                                cursor: pointer;
                                display: none;
                            }
                        </style>
                        <s:set var="currentRoot" value="showableTree" />
                        <s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder-request-linksPagesMenu.jsp" />
                    </s:elseif>
                    </tbody>
                </table>     
            </div>
            <p class="sr-only"><wpsf:hidden name="copyingPageCode" /></p>

<!--            <fieldset data-toggle="tree-toolbar"><legend><s:text name="title.pageActions" /></legend>
                <p class="sr-only"><s:text name="title.pageActionsIntro" /></p>

                <div class="btn-toolbar" data-toggle="tree-toolbar-actions">
                    <div class="btn-group btn-group-sm margin-small-top margin-small-bottom">
            <wpsf:submit action="new" type="button" title="%{getText('page.options.new')}" cssClass="btn btn-info" data-toggle="tooltip">
                <span class="icon fa fa-plus-circle"></span>
            </wpsf:submit>
        </div>
    </div>
</fieldset>-->
        </s:form>


    </div>


    <style>

        .treeInteractionButtons{
            font-size: 16px;
            font-weight: bold;
        }
        .green{
            color: green;
        }

        #pageTree .statusField i.fa {
            font-size: 15px;
            margin-top: 6px;
        }
    </style>


    <script>

        $(document).ready(function () {
            // Show/Hide Notifications Drawer
            if ($('.drawer-pf').hasClass('drawer-pf-expanded')) {
                $('.moveButtons-right-container').show();
            } else {
                $('.moveButtons-right-container').hide();
            }

            $('#widget-sidebar-page-tree-btn').click(function () {

                var $drawer = $('.drawer-pf');

                $(this).toggleClass('open');
                if ($drawer.hasClass('hide')) {
                    // $('.drawer-pf').animate({width:'toggle'},300);
                    $drawer.removeClass('hide');


                    setTimeout(function () {
                        if (window.dispatchEvent) {
                            window.dispatchEvent(new Event('resize'));
                        }
                        // Special case for IE
                        if ($(document).fireEvent) {
                            $(document).fireEvent('onresize');
                        }
                    }, 100);
                } else {
                    console.log('animate in');
                    // $('.drawer-pf').animate({width:'toggle'},300);
                    $drawer.addClass('hide');
                }
            });


            $('#close-page-tree-sidebar').click(function () {
                var $drawer = $('.drawer-pf');
                //console.log("CLOSE CLICK");
                //$drawer.animate({width:'toggle'},300, function() {                        
                //   $drawer.addClass('hide')
                //});
                $drawer.addClass('hide');

            });


            $('.drawer-pf-toggle-expand').click(function () {
                var $drawer = $('.drawer-pf');
                var $drawerNotifications = $drawer.find('.drawer-pf-notification');

                if ($drawer.hasClass('drawer-pf-expanded')) {
                    $('.moveButtons-right-container').hide();
                    $drawer.removeClass('drawer-pf-expanded');
                    $drawerNotifications.removeClass('expanded-notification');
                } else {
                    $('.moveButtons-right-container').show();
                    $drawer.addClass('drawer-pf-expanded');
                    $drawerNotifications.addClass('expanded-notification');
                }

            });

            // Mark All Read
            $('.panel-collapse').each(function (index, panel) {
                var $panel = $(panel);
                $panel.on('click', '.drawer-pf-action .btn', function () {
                    $panel.find('.unread').removeClass('unread');
                    $(panel.parentElement).find('.panel-counter').text('0 New Events');
                });
            });

            $('#notification-drawer-accordion').initCollapseHeights('.panel-body');

        });

    </script>


    <h1><s:text name="title.pageTree" /></h1>


    <script>

        $(document).ready(function () {

            $("#expandAll").click(function () {
                $(".childrenNodes").removeClass("hidden");
            });
            $("#collapseAll").click(function () {
                $(".childrenNodes").addClass("hidden");
            });

            var isTreeOnRequest = <s:property value="#pageTreeStyleVar == 'request'"/>;
            $('.table-treegrid').treegrid(null, isTreeOnRequest);
            $(".treeRow ").on("click", function (event) {
                $(".treeRow").removeClass("active");
                $(".moveButtons-right").addClass("hidden");
                $(".table-view-pf-actions").addClass("hidden");
                $(this).find('.subTreeToggler').prop("checked", true);
                $(this).addClass("active");
                $(this).find(".moveButtons-right").removeClass("hidden");
                $(this).find(".table-view-pf-actions").removeClass("hidden");
            });
        });

    </script> 

</div>
