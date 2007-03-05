From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] paravirt: VDSO page is essential
Date: Mon, 5 Mar 2007 14:48:03 +0100
Message-ID: <20070305134803.GA31327@elte.hu>
References: <20070305120631.GA14105@elte.hu> <1173101297.26165.39.camel@localhost.localdomain> <20070305143437.GF22829@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932642AbXCEN4X@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070305143437.GF22829@bingen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org


* Andi Kleen <ak@suse.de> wrote:

> > VDSO is only a problem if (1) the hypervisor wants to reserve the 
> > top virtual address space (CONFIG_PARAVIRT=y), and (2) the glibc is 
> > old and
> 
> It broke the boot even with native hardware, no hypervisor

yeah - i just sent the fix for that regression - by making 
CONFIG_COMPAT_VDSO usable again.

basically, we want to avoid all the compatibility mess that exists on 
the hypervisor side to enter the Linux kernel.

	Ingo
