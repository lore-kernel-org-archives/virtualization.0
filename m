From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Fix lazy mode vmalloc synchronization for paravirt
Date: Tue, 21 Aug 2007 23:28:28 -0700
Message-ID: <46CBD78C.3020804@goop.org>
References: <46CB91BC.2010808@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755395AbXHVG2g@vger.kernel.org>
In-Reply-To: <46CB91BC.2010808@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, Ben Collins <ben.collins@ubuntu.com>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Found this looping Ubuntu installs with VMI.
>
> If unlucky enough to hit a vmalloc sync fault during a lazy mode
> operation (from an IRQ handler for a module which was not yet
> populated in current page directory, or from inside copy_one_pte,
> which touches swap_map, and hit in an unused 4M region), the required
> PDE update would never get flushed, causing an infinite page fault loop.

Ah, good catch.

> This bug affects any paravirt-ops backend which uses lazy updates, I
> believe that makes it a bug in Xen, VMI and lguest.  It only happens
> on LOWMEM kernels. 

No, under Xen the kernel/hypervisor PMD is not shared between processes,
so this is still used when PAE is enabled.

    J
