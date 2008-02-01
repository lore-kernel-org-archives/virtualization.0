From: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Updated dom0 for pvops: now boots on 32-bit!
Date: Fri, 01 Feb 2008 21:02:42 +0000
Message-ID: <1201899762.11365.10.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
Cc: Mark McLoughlin <markmc@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Juan Quintela <quintela@redhat.com>, Stephen Tweedie <sct@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi folks,

I've finished off Xen dma support for pv_ops, and dom0 now boots!  

I've had an uptime of 40 minutes so far with it.  Under intensive disk
load it locks up with a soft lockup, but still, this is good progress.  

I've pushed the current bits to the "WIP" (work-in-progress) branch at
the usual git repo,

	git://et.redhat.com/linux-2.6-dom0-pvops.git

with gitweb at 

	http://git.et.redhat.com/?p=linux-2.6-dom0-pvops.git 

New since the last drop are some MTRR cleanups from Mark McLoughlin, a
number of dma-mapping cleanups, and full dma_alloc/free_coherent
support, including xen contiguous mapping support.  I've also updated it
to Linus' final v2.6.24.

The APIC code is still non-pvops-friendly, but other than that, all the
new code is completely pvops-friendly and will work happily on baremetal
as well as Xen.  So next job is to clean up the xen contiguous-region
support (split it up, update the calls to use cleaner, pvops
virt/mfn/pfn macros, and use Jeremy's per-cpu pvops multicall batching),
and to redo much of the APIC code to work properly with pvops.

But in its current state it's useful enough for testing that I've pushed
it as it stands.

NOTE: this current code has not actually been tagged and rebased, it's
not exactly a "release" as much as a snapshot of the development work
--- I'll do a rebase and patchqueue release of it once I've done the
contig region cleanups.  I've also got paravirt framebuffer patches from
Markus Armbruster to integrate for that.

--Stephen
