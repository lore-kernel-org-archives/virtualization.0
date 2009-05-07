From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [Xen-devel] [patch xen.git xen-tip/master] xen: fix xenbus
	frontend build
Date: Wed, 06 May 2009 19:20:54 -0700
Message-ID: <4A024586.20007@oracle.com>
References: <4A008878.7030409@oracle.com>
	<alpine.LFD.2.00.0905062324440.22137@vega2.dur.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0905062324440.22137@vega2.dur.ac.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: M A Young <m.a.young@durham.ac.uk>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

M A Young wrote:
> On Tue, 5 May 2009, Randy Dunlap wrote:
> 
>> From: Randy Dunlap <randy.dunlap@oracle.com>
>>
>> When a driver kconfig symbol =m and it selects another symbol,
>> that other symbol will also be =m (unless something else
>> causes it to be =y), so when XEN_BLKDEV_FRONTEND=m and/or
>> XEN_NETDEV_FRONTEND=m, then XEN_XENBUS_FRONTEND=m, but that
>> won't build (build error message below).  Changing
>> XEN_XENBUS_FRONTEND from a tristate to a bool makes it be
>> =y (builtin) any time that it is selected, so there is
>> no build error.
> 
> That isn't the right solution. The real problem is that something you
> have selected as "y" does depend on XEN_XENBUS_FRONTEND but doesn't
> select it. Switching XEN_XENBUS_FRONTEND from tristate to bool might fix
> your particular compile problem, but it means that the situation you
> would get if you changed your configuration so that
> XEN_BLKDEV_FRONTEND=n and XEN_NETDEV_FRONTEND=n (likewise any other
> options that do select XEN_XENBUS_FRONTEND) would still broken because
> then XEN_XENBUS_FRONTEND won't be selected at all.
> 
> If your configuration has XEN_PCI_PASSTHROUGH=y then I posted a patch
> for this very situation a few days ago (and it is now in xen-tip/next,
> though wasn't yet in xen-tip/master when I last checked).

fwiw, yes, XEN_PCI_PASSTHROUGH=y in my .config file.

Where did you post the patch?

thanks,
-- 
~Randy
LPC 2009, Sept. 23-25, Portland, Oregon
http://linuxplumbersconf.org/2009/
