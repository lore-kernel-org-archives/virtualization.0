From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Fix preemptible lazy mode bug
Date: Thu, 23 Aug 2007 23:53:29 -0700
Message-ID: <46CE8069.9070404@goop.org>
References: <46CE70C8.2030005@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764359AbXHXGxh@vger.kernel.org>
In-Reply-To: <46CE70C8.2030005@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, stable@kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Virtualization Mailing List <virtualization@lists.osdl.org>, Andi Kleen <ak@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> I recently sent off a fix for lazy vmalloc faults which can happen
> under paravirt when lazy mode is enabled.  Unfortunately, I jumped the
> gun a bit on fixing this.  I neglected to notice that since the new
> call to flush the MMU update queue is called from the page fault
> handler, it can be pre-empted.  Both VMI and Xen use per-cpu variables
> to track lazy mode state, as all previous calls to set, disable, or
> flush lazy mode happened from a non-preemptable state.

Hm.  Doing any kind of lazy-state operation with preemption enabled is
fundamentally meaningless.  How does it get into a preemptable state
with a lazy mode enabled now?  If a sequence of code with preempt
disabled touches a missing vmalloc mapping, it gets a fault to fix up
the mapping, and the fault handler can end up preempting the thread? 
That sounds like a larger bug than just paravirt lazy mode problems.

    J
