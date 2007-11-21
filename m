From: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Next steps with pv_ops for Xen
Date: Wed, 21 Nov 2007 22:05:25 +0000
Message-ID: <1195682725.6726.48.camel@sisko.scot.redhat.com>
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
To: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Stephen Tweedie <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

I've been looking at the next steps to try to get Xen running fully on
top of pv_ops.  To that end, I've (just) started looking at one of the
next major jobs --- i686 dom0 on pv_ops.

There are still a number of things needing done to reach parity with
xen-unstable:

  x86_64 xen on pv_ops
  Paravirt framebuffer/keyboard
  CPU hotplug
  Balloon
  kexec
  driver domains

but it looks like these can largely proceed in parallel if desired.

My short-term goal with this is simply to come up with a first-pass
merge of the linux-2.6.18-xen.hg dom0 support into the current
kernel.org tree's pv_ops support.  No major refactoring in the first
pass, but absolutely no *-xen.c code copying.

I'm just starting this, but at least with the version magic check (see

	http://lists.xensource.com/archives/html/xen-devel/2007-11/msg00601.html

) out of the way, an SMP dom0 running pv_ops gets all the way through
start_kernel() and into rest_init() before dying with an unsupported cr0
write.  (I'm using direct console hypercalls for printk for now, full
xencons is not working yet.)

Current goal is to get as far as I can with the normal domU boot process
in a dom0 environment (getting console set up correctly, etc), before
starting to piece in the additional extra bits needed for dom0 startup
(mostly, but by no means exclusively, setup-xen.c).

I'm happy to put up a git tree for this once it gets anywhere.  We'd
need to decide which tree to track for that purpose --- Linus's, or
perhaps the tglx or mingo x86 merge tree might make more sense.

--Stephen
