From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Fix preemptible lazy mode bug
Date: Thu, 06 Sep 2007 06:37:46 +1000
Message-ID: <1189024666.10802.197.camel@localhost.localdomain>
References: <46CE70C8.2030005@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757492AbXIEUiY@vger.kernel.org>
In-Reply-To: <46CE70C8.2030005@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, stable@kernel.org, Virtualization Mailing List <virtualization@lists.osdl.org>, Andi Kleen <ak@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-08-23 at 22:46 -0700, Zachary Amsden wrote:
> I recently sent off a fix for lazy vmalloc faults which can happen under 
> paravirt when lazy mode is enabled.  Unfortunately, I jumped the gun a 
> bit on fixing this.  I neglected to notice that since the new call to 
> flush the MMU update queue is called from the page fault handler, it can 
> be pre-empted.  Both VMI and Xen use per-cpu variables to track lazy 
> mode state, as all previous calls to set, disable, or flush lazy mode 
> happened from a non-preemptable state.

Hi Zach,

	I don't think this patch does anything.  The flush is because we want
the just-completed "set_pte" to have immediate effect, so if preempt is
enabled we're already screwed because we can be moved between set_pte
and the arch_flush_lazy_mmu_mode() call.

Now, where's the problem caller?  By my reading or rc4, vmalloc faults
are fixed up before enabling interrupts.

Confused,
Rusty.
