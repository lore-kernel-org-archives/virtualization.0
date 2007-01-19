From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 17/20] XEN-paravirt: Add Xen grant table
	support
Date: Fri, 19 Jan 2007 15:07:22 +1100
Message-ID: <45B043FA.9090905@goop.org>
References: <20070113014539.408244126@goop.org>
	<20070113014648.925356430@goop.org> <20070115130556.GB4272@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070115130556.GB4272@ucw.cz>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Pavel Machek wrote:
> What is going on? Diffstat does not seem to match the diff.
Sorry, forgot to update the diffstat for this one:

 drivers/xen/Makefile           |    1 
 drivers/xen/core/Makefile      |    1 
 drivers/xen/core/grant_table.c |  445 ++++++++++++++++++++++++++++++++++++++++
 include/xen/grant_table.h      |  107 +++++++++
 4 files changed, 554 insertions(+)


    J
