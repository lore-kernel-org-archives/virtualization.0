From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 00/20] XEN-paravirt: Xen guest implementation
	for paravirt_ops interface
Date: Fri, 12 Jan 2007 17:45:39 -0800
Message-ID: <20070113014539.408244126@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@osdl.org>
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This patch series implements the Linux Xen guest in terms of the
paravirt-ops interface.  The features in implemented this patch series
are:
 * domU only
 * UP only (most code is SMP-safe, but there's no way to create a new vcpu)
 * writable pagetables, with late pinning/early unpinning
   (no shadow pagetable support)
 * supports both PAE and non-PAE modes
 * xen console
 * virtual block device (blockfront)

(Netfront needs a bit of updating, and will be in a separate patch later.)

The patch series is in two parts:

1-11: cleanups to the core kernel, either to fix outright problems,
      or to add appropriate hooks for Xen
12-20: the Xen guest implementation itself

I've tried to make each patch as self-explanatory as possible.  The
series is based on 2.6.20-rc4-mm1.

Thanks,
	J
-- 
