From: Andi Kleen <ak@suse.de>
Subject: Re: [patch] paravirt: VDSO page is essential
Date: Mon, 5 Mar 2007 15:34:37 +0100
Message-ID: <20070305143437.GF22829@bingen.suse.de>
References: <20070305120631.GA14105@elte.hu> <1173101297.26165.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965268AbXCENfH@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1173101297.26165.39.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>, Andi Kleen <ak@suse.de>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

> VDSO is only a problem if (1) the hypervisor wants to reserve the top
> virtual address space (CONFIG_PARAVIRT=y), and (2) the glibc is old and

It broke the boot even with native hardware, no hypervisor

>  
> +config RESERVE_TOP
> +	bool
> +	help
> +	  Many hypervisors want to reserve some amount of the top of
> +	  virtual address space.  Unfortunately, old glibc needs the
> +	  vdso page there, so we must disable vdso if COMPAT_VDSO is
> +	  enabled as well as this option.

But this still means I would need to decide between a PARAVIRT
kernel that either supports xen/VMI or cannot boot old user land without
weird options.  I don't think that's the correct solution. The goal
is a single binary that runs everywhere and is still compatible.

What would probably work is to somehow decide at runtime if a hypervisor
is there or not and then set vdso default based on that. I guess that
detection would be hypervisor specific though and probably would
need paravirt ops extensions.

-Andi
