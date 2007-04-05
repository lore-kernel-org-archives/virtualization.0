From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 0/2] Updates to compat VDSOs
Date: Thu, 05 Apr 2007 08:53:23 -0700
Message-ID: <20070405155323.759992347@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1767117AbXDEP4i@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>, Jan Beulich <JBeulich@novell.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Andi,

Here's a couple of patches to fix up COMPAT_VDSO:

The first is a straightforward implementation of Jan's original idea
of relocating the VDSO to match its mapped location.  Unlike Jan and
Zach's version, I changed it to relocate based on the phdrs rather than
the sections; the result is pleasantly compact.

The second patch takes advantage of the fact that all the COMPAT_VDSO work
happens at runtime now, and allows compat mode to be enabled dynamically.
If you specify vdso=2 on the kernel command line, it comes up in compat
mode; vdso=1 is normal vdso mode, and vdso=0 disables vdso altogether.
You can also switch modes with sysctl.

Changes since last posting:
 - rebase sections as well as phdrs
 - relocate symbols
 - more robust DT_tag handling
 - handle dynamic compat mode switches a bit better

Thanks to Jan and Roland for the review.

Thanks,
	J

-- 
