From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Fix preemptible lazy mode bug
Date: Tue, 04 Sep 2007 14:42:01 +0100
Message-ID: <46DD60A9.8080203@goop.org>
References: <46CE70C8.2030005@vmware.com> <46CE8069.9070404@goop.org>	 <46CE81DC.90103@vmware.com>  <46D9D517.6010201@goop.org> <1188850468.10802.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754188AbXIDNmm@vger.kernel.org>
In-Reply-To: <1188850468.10802.66.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, stable@kernel.org, Virtualization Mailing List <virtualization@lists.osdl.org>, Andi Kleen <ak@suse.de>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
>  static inline void arch_flush_lazy_mmu_mode(void)
>  {
> -	PVOP_VCALL1(set_lazy_mode, PARAVIRT_LAZY_FLUSH);
> +	if (unlikely(__get_cpu_var(paravirt_lazy_mode) == PARAVIRT_LAZY_MMU))
> +		arch_leave_lazy_mmu_mode();
>  }
>   

This changes the semantics a bit; previously "flush" would flush
anything pending but leave us in lazy mode.  This just drops lazymode
altogether?

I guess if we assume that flushing is a rare event then its OK, but I
think the name's a bit misleading.  How does it differ from plain
arch_leave_lazy_mmu_mode()?

    J
