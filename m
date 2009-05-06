From: M A Young <m.a.young@durham.ac.uk>
Subject: Re: [patch xen.git xen-tip/master] xen: fix xenbus
	frontend build
Date: Wed, 6 May 2009 23:38:27 +0100 (BST)
Message-ID: <alpine.LFD.2.00.0905062324440.22137@vega2.dur.ac.uk>
References: <4A008878.7030409@oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <4A008878.7030409@oracle.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, "jeremy@goop.org" <jeremy@goop.org>, xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 5 May 2009, Randy Dunlap wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> When a driver kconfig symbol =m and it selects another symbol,
> that other symbol will also be =m (unless something else
> causes it to be =y), so when XEN_BLKDEV_FRONTEND=m and/or
> XEN_NETDEV_FRONTEND=m, then XEN_XENBUS_FRONTEND=m, but that
> won't build (build error message below).  Changing
> XEN_XENBUS_FRONTEND from a tristate to a bool makes it be
> =y (builtin) any time that it is selected, so there is
> no build error.

That isn't the right solution. The real problem is that something you have 
selected as "y" does depend on XEN_XENBUS_FRONTEND but doesn't select it. 
Switching XEN_XENBUS_FRONTEND from tristate to bool might fix your 
particular compile problem, but it means that the situation you would get 
if you changed your configuration so that XEN_BLKDEV_FRONTEND=n and 
XEN_NETDEV_FRONTEND=n (likewise any other options that do select 
XEN_XENBUS_FRONTEND) would still broken because then XEN_XENBUS_FRONTEND 
won't be selected at all.

If your configuration has XEN_PCI_PASSTHROUGH=y then I posted a patch for 
this very situation a few days ago (and it is now in xen-tip/next, though 
wasn't yet in xen-tip/master when I last checked).

 	Michael Young
