From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Xen & VMI?
Date: Wed, 07 Mar 2007 11:44:06 +1100
Message-ID: <1173228246.4644.85.camel@localhost.localdomain>
References: <45ED82D9.6050204@codemonkey.ws>
	 <8FFF7E42E93CC646B632AB40643802A80229779B@scsmsx412.amr.corp.intel.com>
	 <20070306203712.GC21736@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161054AbXCGAox@vger.kernel.org>
In-Reply-To: <20070306203712.GC21736@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, virtualization <virtualization@lists.osdl.org>, Roland McGrath <roland@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-03-06 at 21:37 +0100, Ingo Molnar wrote:
> maybe i shouldnt call it 'VMI' but 'the paravirt ABI'. I dont mind if 
> it's the Xen ABI or the VMWare ABI or a mesh of the two - everyone can 
> map their own internals to that /one/ ABI.

I think it's an excellent aim, but it's *HARD*.  I rejected this
approach earlier because I'm just not smart enough.  (Yet?)

The Linux side is fairly stable.  The hardware side is changing, and the
hypervisor side is changing.  This means the ABI will churn fairly fast.
The hypervisors are very different, which means the ABI will be very
wide.

We could start with VMI and try to support Xen, KVM and lguest.  It
would at least give us a better idea of the scope of the problem.  But
IMHO it's a *huge* job.

Rusty.
