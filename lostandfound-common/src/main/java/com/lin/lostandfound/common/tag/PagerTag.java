package com.lin.lostandfound.common.tag;

import com.lin.lostandfound.common.constants.Constants;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

public class PagerTag extends SimpleTagSupport {

	private Integer currentPage;
	private Integer totalPage;
	private Integer pageSize = Constants.PAGE_SIZE_15;
	private Integer totalCount = 0;
	private String url;
	private String valueId;

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}

	public Integer getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getValueId() {
		return valueId;
	}

	public void setValueId(String valueId) {
		this.valueId = valueId;
	}

	@Override
	public void doTag() throws JspException, IOException {
		JspWriter out = this.getJspContext().getOut();

		int pageNumber = 0;
		if (totalPage % pageSize == 0) {
			pageNumber = totalPage / pageSize;
		} else {
			pageNumber = (totalPage / pageSize) + 1;
		}
		
		if (currentPage < 1) {
			currentPage = 1;
		}

		try {
			if (pageNumber > 0) {
				//System.out.println("url: " + url + " " + "pageNum: " + curPage + " " + "pageSize: " + pageSize);
				// 如果valueId 为null 或 "" 则查询所有
				if (valueId == null || "".equals(valueId)) {
					out.print("<script type='text/javascript'>"

							+ "function go(pageNum){"
							
							+ "var index = '" + url + "'.indexOf('\\?');"							
							+ "if(index != -1) {"
							+ "var starturl = '" + url + "'.substring(0,index);"
							+ "var endurl = '" + url + "'.substring(index);"
							+ "var url = starturl +'/'+ pageNum +'/' + '"
							+ pageSize + "' +endurl;"
							+ "} else{"
							+ "var url = '" + url + "'+'/'+ pageNum +'/' + '"
							+ pageSize + "';"
							+ "}"
							+ "window.location = url;"
							+ "}"

							+ "</script>");
				} else {
					out.print("<script type='text/javascript'>"

							+ "function go(pageNum){"
							
							+ "var valueobj = document.getElementById('"+ valueId + "');"
							+ "var value = valueobj.options[valueobj.selectedIndex].value;"
							+ "value = value.substring(value.lastIndexOf('/') == -1 ? 0 : value.lastIndexOf('/')+1);"
							
							+ "var index = '" + url + "'.indexOf('\\?');"
							+ "if(index != -1) {"
							+ "var starturl = '" + url + "'.substring(0,index);"
							+ "var endurl = '" + url + "'.substring(index);"
							+ "var url = starturl +'/'+ pageNum +'/' + '"
							+ pageSize + "' + '/' + value +endurl;"
							+ "} else {"							
							+ "var url = '" + url + "'+'/'+ pageNum +'/' + '"
							+ pageSize + "' + '/' + value;"
							+ "}"
							+ "window.location = url;"
							+ "}"

							+ "</script>");
				}

				out.print("<div class='pagination'><ul>");
				int start = 1;
				int end = totalPage;
				for (int i = 4; i >= 1; i--) {
					if ((currentPage - i) >= 1) {
						start = currentPage - i;
						break;
					}
				}
				for (int i = 4; i >= 1; i--) {
					if ((currentPage + i) <= totalPage) {
						end = currentPage + i;
						break;
					}
				}
				// 如果小于9则右侧补齐
				if (end - start + 1 <= 9) {
					Integer padLen = 9 - (end - start + 1);
					for (int i = padLen; i >= 1; i--) {
						if ((end + i) <= totalPage) {
							end = end + i;
							break;
						}
					}
				}

				// 如果还小于9左侧补齐
				if (end - start + 1 <= 9) {
					Integer padLen = 9 - (end - start + 1);
					for (int i = padLen; i >= 1; i--) {
						if ((start - i) >= 1) {
							start = start - i;
							break;
						}
					}
				}

				if (currentPage > 1) {
					if (start > 1) {
						out.print("<li><a href='javascript:go(1)'>首页</a></li>");
					}
					out.print("<li><a href='javascript:go(" + (currentPage - 1)
							+ ")'>上一页</a></li>");
				}

				for (int i = start; i <= end; i++) {
					if (i == currentPage) {
						out.print("<li class='active'><a href='javascript:void(0);'>"
								+ i + "</a></li>");
					} else {
						out.print("<li><a href='javascript:go(" + i + ")'>" + i
								+ "</a></li>");
					}
				}
				
				if (currentPage < totalPage) {
					//System.out.println("pageNum: " + curPage + " " + "pageSize: " + pageSize);
					out.print("<li><a href='javascript:go(" + (currentPage + 1)
							+ ")'>下一页</a></li>");
					if (end < totalPage) {
						out.print("<li><a href='javascript:go(" + totalPage
								+ "," + pageSize + ")'>末页</a></li>");
					}
				}
				out.print("<li><a href='javascript:void(0)'>共" + totalPage
						+ "页" + this.totalCount + "条</a></li>");
				out.print("</ul></div>");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static Integer getStartIndex(Integer pageNum, Integer pageSize) {
		Integer startIndex = 0;
		if (pageNum > 0) {
			startIndex = (pageNum - 1) * pageSize;
		}
		return startIndex;
	}
}
