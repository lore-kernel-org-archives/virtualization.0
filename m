From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 00/21] Xen-paravirt: Xen guest implementation
	for paravirt_ops interface
Date: Tue, 13 Feb 2007 14:17:29 -0800
Message-ID: <20070213221729.772002682@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Andi,

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
 * virtual network device (netfront)

The patch series is in two parts:

1-12: cleanups to the core kernel, either to fix outright problems,
      or to add appropriate hooks for Xen
13-21: the Xen guest implementation itself

I've tried to make each patch as self-explanatory as possible.  The
series is based on 2.6.20 + Andi Kleen's firstfloor patches, specifically:
	page-allocation-hooks-for-vmi-backend
	paravirt-cpu-batching.patch
	iopl-handling-for-paravirt-guests
	smp-boot-hook-for-paravirt
	vmi-backend-for-paravirt-ops
	vmi-timer

Changes since the previous posting:
- made vga not crash when vga hardware isn't present
- cleaned up sign issues in xen-console
- cleaned up mm-lifetime hooks
- blockfront cleanups
- other stuff

Thanks,
	J


-- 
