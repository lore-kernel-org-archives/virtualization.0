From: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Updated dom0 pvops for 2.6.24 available on git
Date: Fri, 25 Jan 2008 16:37:20 +0000
Message-ID: <1201279040.18573.14.camel@sisko.scot.redhat.com>
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
Cc: Chris Wright <chrisw@redhat.com>, Stephen Tweedie <sct@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Juan Quintela <quintela@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

I've updated the dom0 pvops patches against 2.6.24, and they now have a
new git home:

http://git.et.redhat.com/?p=linux-2.6-dom0-pvops.git
git://et.redhat.com/linux-2.6-dom0-pvops.git

I'm maintaining the tree in this repo in two separate forms:

      * Development branch:

        The master branch is an ongoing, shareable development branch,
        currently including a fair amount of debug code and history that
        we will not ever want to push upstream
        
      * Clean patch queues:
        
        I'm also maintaining the same tree as a completely different set
        of patches/git history --- the tag "dom0-2.6.24-A0" is a clean
        patch queue applying directly against upstream v2.6.24, and the
        tag "dom0-2.6.24-A0-dev" is the corresponding tag on the master
        branch which results in _exactly_ the same tree, but which has
        the full development history behind it.  (git-diff-tree will
        show they are identical for verification.)
        
So for patch review and upstream pushing, the dom0-2.6.24-A0 tag is what
you want to be looking at; for development and git merging, the master
branch is where the activity will be.

New in this release:
--------------------

dom0-2.6.24-A0 adds:

Initial APIC support:
        This is a minimal brute-force merge of the 2.6.18-xen APIC code,
        enough to get interrupts being handled and to allow other dom0
        work to proceed; this will still need to be worked into a pvops-
        friendly format.
        
PCI DMA support:
        Adds an x86_64-style dma_mapping indirection, tested on
        baremetal, and adds Xen pfn-to-mfn translations to allow DMA to
        function under pvops.  This is fully pvops-friendly as it
        stands, but does not yet support swiotlb (so for now it's for
        development and testing on 32-bit <4GB boxes only.)
        
Various minor bugfixes.

Status
------

Boots through to initrd/module loading, but modular drivers are still
not working right, failing on init with a variety of symptoms including
fatal controller errors or init timeouts.  We currently suspect problems
in the caching/writethrough settings on the PCI accesses, but that's
just a guess right now.

The full patch will NOT boot on baremetal due to the heavy-handed APIC
merge; but the dma-mapping patches applied alone DO boot on baremetal.

Still includes lots of debug printks for irq and dma mapping, don't
expect a quiet boot.

--Stephen
